// 
//  TsumegoGames.m
//  GoClinic
//
//  Created by 猪子 徹 on 11/02/23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TsumegoGames.h"
#import "GameRecords.h"
#import "GameRecordStack.h"
#import "Global.h"

@implementation TsumegoGames 
@synthesize isAnswerRegistMode = _isAnswerRegistMode;
@synthesize isChallengeRegistMode = _isChallengeRegistMode;
@synthesize isOkiishiMode = _isOkiishiMode; 
@synthesize okiishiUserId = _okiishiUserId;
@synthesize answerMove = _answerMove;
@synthesize isAnswerRegisterMode = _isAnswerRegisterMode;
@synthesize questionCategory = _questionCategory;
@dynamic answer_move;

-(id)initGames{
	if((self = [[TsumegoGames alloc] initWithEntity:[NSEntityDescription entityForName:@"TsumegoGames" inManagedObjectContext:managedObjectContextGlobal] 
			 insertIntoManagedObjectContext:managedObjectContextGlobal])){
		[super initGamesWithBoardSize:BOARD_SIZE ySize:BOARD_SIZE];
		self.answerMove = 0;
		self.isAnswerRegisterMode = NO;
        self.isChallengeRegistMode = NO;
        self.isOkiishiMode = NO;
        self.okiishiUserId = 0;
        self.game_category = [NSNumber numberWithInt:TSUMEGO_GAME_CATEGORY];
		_answerStack = [[NSMutableArray alloc] init];
		[_answerStack retain];
		_challengeStack = [[NSMutableArray alloc] init];
		[_challengeStack retain];
		_tsumegoStones = [[NSMutableArray alloc] init];
		[_tsumegoStones retain];
        
	}
	return self;
}

-(void)changeState:(TsumegoGameState*)state{
    [_state release];
    _state = [state retain];
}

-(GameRecords*)createNewNormalRecord:(int)x y:(int)y{
	GameRecords* newRecord;
	//実戦譜の最後の譜のあとに連結させるように修正
    newRecord = [[GameRecords alloc] initNewRecord:self move:[self.current_move intValue] prev:self.last_record next:nil];
	
	//現在の手の次の手数を設定する
    newRecord.user_id = [self getCurrentUserId];
    newRecord.x = [NSNumber numberWithInt:x];
    newRecord.y = [NSNumber numberWithInt:y];
    
	//現在の手の次の手数を設定する
	newRecord.move = [NSNumber numberWithInt:[self.last_record.move intValue] + 1];
    
	//answerMoveを設定する
	if (_isAnswerRegisterMode) {
		self.answerMove++;
		NSLog(@"answer move is %d" ,self.answerMove);
		newRecord.answer_move = [NSNumber numberWithInt:self.answerMove];
		newRecord.move = newRecord.answer_move;
	}
	
	//一番初めの棋譜の場合
	if(self.first_record == nil){
		NSLog(@"self.first is : %@, self.last is : %@", [self.first_record description], [self.last_record description]);
		self.first_record = newRecord;
		self.last_record = newRecord;
	}
	
	//NormalRecordで、一番最後の手の場合、last_recordを入れ替える
	if([self.last_record.move intValue] < [newRecord.move intValue]){
		self.last_record = newRecord;
	}
	[self setNewCurrentRecord:newRecord];
	self.current_move = newRecord.move;
	self.current_record.move = self.current_move;
	[(NSMutableSet*)
	 self.game_records addObject:newRecord];
	
	//Stackに追加
	if(_isAnswerRegisterMode){
		//解凍登録モードの場合（登録画面）
		[self.recordStack push:newRecord];
		[_answerStack push:newRecord];
	}else if(_isChallengeRegistMode){
		//問題挑戦モードの場合（表示画面）
		[_challengeStack push:newRecord];
	}else {
		//基板登録モードの場合（登録画面）
		[_tsumegoStones push:newRecord];
	}
    
    //Stackに追加
	[self.recordStack push:newRecord];

	return newRecord;
}

-(GameRecords*)createOkiishiRecord:(int)x y:(int)y goStoneView:(GoStoneView *)view{
    GameRecords* newRecord;
	//実戦譜の最後の譜のあとに連結させるように修正
    newRecord = [[GameRecords alloc] initNewRecord:self move:0 prev:nil next:nil];
    newRecord.user_id = [NSNumber numberWithInt:self.okiishiUserId];
    newRecord.x = [NSNumber numberWithInt:x];
    newRecord.y = [NSNumber numberWithInt:y];
    newRecord.is_okiishi = [NSNumber numberWithBool:YES];
    newRecord.view = view;
    newRecord.depth = [NSNumber numberWithInt:self.currentDepth];
	newRecord.real_x = [NSNumber numberWithFloat:newRecord.view.frame.origin.x];
    newRecord.real_y = [NSNumber numberWithFloat:newRecord.view.frame.origin.y];
    newRecord.width = [NSNumber numberWithFloat:newRecord.view.frame.size.width];
    newRecord.height = [NSNumber numberWithFloat:newRecord.view.frame.size.height];
    NSLog(@"x : %f, y : %f, w : %f, h : %f", newRecord.view.frame.origin.x, newRecord.view.frame.origin.y, newRecord.view.frame.size.width, 
          newRecord.view.frame.size.height);
    
    newRecord.view.stoneColorId = [newRecord.user_id intValue];
    newRecord.view.record = newRecord;
    newRecord.view.move = [newRecord.move intValue];
    
	//手数は0
    [self.game_records addObject:newRecord];
	
	//Stackの最初に追加
    [self.recordStack insertObject:newRecord atIndex:0];
    
    //盤面に追加
    [self setStoneArrayXY:x y:y stone:newRecord];
    self.is_updated = [NSNumber numberWithBool:YES];
    
	return newRecord;
}



-(NSNumber*)getCurrentNextRecodeMove{
	switch (self.insertMode) {
		case 0:
			return [NSNumber numberWithInt:[self.current_move intValue] + 1];
			break;
		case 1:
			return [NSNumber numberWithInt:[self.current_branch_move intValue] + 1];
			break;
		default:
			break;
	}
    return [NSNumber numberWithInt:0];
}

-(NSNumber*)getCurrentUserId{
    //先攻後攻で石の色を変える
    if (self.isAnswerRegisterMode) {
        return [NSNumber numberWithInt:[self checkUser:self.answerMove]];
    }else if(self.isOkiishiMode) {
        return [NSNumber numberWithInt:self.okiishiUserId];
    }else{
        //return [NSNumber numberWithInt:_currentUserId];
        return [NSNumber numberWithInt:[self checkUser:[self.current_record.move intValue]]];
    }
}


-(NSMutableArray*)getEnclosedStonesFromAnswerStack:(int)fromMove{
	return [self getEnclosedStonesFromStackWithStack:fromMove stack:_answerStack];		
}

-(NSMutableArray*)getEnclosedStonesFromChallengeStack:(int)fromMove{
	return [self getEnclosedStonesFromStackWithStack:fromMove stack:_challengeStack];	
}


-(void)dealloc{
	[_answerStack release];
	[_challengeStack release];
	[_tsumegoStones	release];
	//[self.answer_move release];
	[super dealloc];	
}

@end
