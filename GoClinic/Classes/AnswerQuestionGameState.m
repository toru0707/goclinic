//
//  AnswerQuestionGameState.m
//  GoClinic
//
//  Created by 猪子 徹 on 11/06/09.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AnswerQuestionGameState.h"
#import "QuestionAnswerRecords.h"

@implementation AnswerQuestionGameState

-(GameRecords*)createNewRecord:(int)x y:(int)y goStoneView:(GoStoneView*)view{
    QuestionAnswerRecords* newRecord;
	//実戦譜の最後の譜のあとに連結させるように修正
    newRecord = [[QuestionAnswerRecords alloc] initNewRecord:_game move:[_game.last_record.move intValue] + 1 prev:nil next:nil];
    newRecord.x = [NSNumber numberWithInt:x];
    newRecord.y = [NSNumber numberWithInt:y];
	
    
    
    //現在の手の次の手数を設定する
	newRecord.move = [NSNumber numberWithInt:[_game.last_record.move intValue] + 1];
	//一番初めの棋譜の場合
	if(_game.first_record == nil){
		NSLog(@"self.first is : %@, self.last is : %@", [_game.first_record description], [_game.last_record description]);
		_game.first_record = newRecord;
		_game.last_record = newRecord;
	}
	
	//NormalRecordで、一番最後の手の場合、last_recordを入れ替える
	if([_game.last_record.move intValue] < [newRecord.move intValue]){
		_game.last_record = newRecord;
	}
	[_game setNewCurrentRecord:newRecord];
    _game.current_move = newRecord.move;
	_game.current_record.view.move = [_game.current_move intValue];
	[(NSMutableSet*)
	 _game.game_records addObject:newRecord];
	
	//Stackに追加
    [_game setQuestionAnswerRecordsXY:x y:y record:newRecord];
    [_game.answerStack addObject:newRecord];
    
	
	return newRecord;
}

@end
