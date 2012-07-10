//
//  QuestionGames.m
//  GoClinic
//
//  Created by 猪子 徹 on 11/04/03.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "QuestionGames.h"
#import "Global.h"
#import "GoStoneView.h"
#import "NormalQuestionGameState.h"
#import "AnswerQuestionGameState.h"
#import "RegistQuestionGameState.h"
#import "Comments.h"
#import "QuestionGameState.h"
#import "GoStoneViewFactory.h"

@implementation QuestionGames
@synthesize state = _state;
@synthesize answerStack = _answerStack;
@dynamic question_records;


-(id)initGames{
	if((self = [[QuestionGames alloc] initWithEntity:[NSEntityDescription entityForName:@"QuestionGames" inManagedObjectContext:managedObjectContextGlobal] 
					insertIntoManagedObjectContext:managedObjectContextGlobal])){
		[super initGamesWithBoardSize:BOARD_SIZE ySize:BOARD_SIZE];
        self.game_category = [NSNumber numberWithInt:QUESTION_GAME_CATEGORY];
        [self changeToNormalState];
	}
	return self;
}

-(BOOL)isNormalState{
    if([_state isKindOfClass:[NormalQuestionGameState class]]){
        return YES;
    }
    return NO;
}
-(BOOL)isMessageState{
    if([_state isKindOfClass:[RegistQuestionGameState class]]){
        return YES;
    }
    return NO;
}
-(BOOL)isAnswerState{
    if([_state isKindOfClass:[AnswerQuestionGameState class]]){
        return YES;
    }
    return NO;
}

-(void)changeState:(QuestionGameState*)state{
    [_state release];
    _state = [state retain];
}

-(void)changeToNormalState{
    QuestionGameState* state = [[NormalQuestionGameState alloc] initWithGames:self];
    [self changeState:state];
}

-(void)changeToAnswerState{
    QuestionGameState* state = [[AnswerQuestionGameState alloc] initWithGames:self];
    [self changeState:state];
}

-(GameRecords*)createNewRecord:(int)x y:(int)y goStoneView:(GoStoneView*)view{
    GameRecords* newRecord = nil;
    //0:ノーマルの棋譜を入力する. 1:ブランチの棋譜を入力する
    newRecord = [_state createNewRecord:x y:y goStoneView:view];
    
    newRecord.depth = [NSNumber numberWithInt:self.currentDepth];
    newRecord.user_id = [self getCurrentUserId];
	newRecord.real_x = [NSNumber numberWithFloat:view.frame.origin.x];
    newRecord.real_y = [NSNumber numberWithFloat:view.frame.origin.y];
    newRecord.width = [NSNumber numberWithFloat:view.frame.size.width];
    newRecord.height = [NSNumber numberWithFloat:view.frame.size.height];
    
    GoStoneView* newView = [GoStoneViewFactory createGoStoneView:newRecord];
    newView.originLocation = view.originLocation;
    newView.delegate = view.delegate;
    newRecord.view = newView;
    newView.record = newRecord;
    
    [self setStoneArrayXY:x y:y stone:newRecord];
    self.is_updated = [NSNumber numberWithBool:YES];
    return newRecord;
}

/**
 
 */
-(GameRecords*)createQuestionMessageRecord:(int)x y:(int)y faceCategory:(int)faceCategory comment:(NSString*)_comment{
    QuestionMessageRecords* newRecord = [[QuestionMessageRecords alloc] initNewRecord:self move:[self.last_record.move intValue] + 1 prev:nil next:nil];
    newRecord.x = [NSNumber numberWithInt:x];
    newRecord.y = [NSNumber numberWithInt:y];
    
    //問題の顔と、コメントを設定
    newRecord.face_id = [NSNumber numberWithInt:faceCategory];
    Comments* comment = [[Comments alloc] initNewComment];
    comment.text = _comment;
    [newRecord addCommentsObject:comment];
    
    [self.question_records addObject:newRecord];
    [self setQuestionRecordsXY:x y:y record:newRecord];
    
    return newRecord;
}

-(QuestionMessageRecords*)getQuestionRecordXY:(int)x y:(int)y{
    return (QuestionMessageRecords*)[_questionRecordsArray objectAtIndex:(x + _xSize * y)];
}

-(void)setQuestionRecordsXY:(int)x y:(int)y record:(GameRecords*)record{
    [_questionRecordsArray replaceObjectAtIndex:(x + _xSize * y) withObject:record];
}


-(QuestionAnswerRecords*)getQuestionAnswerRecordXY:(int)x y:(int)y{
    return (QuestionAnswerRecords*)[_answerRecordsArray objectAtIndex:(x + _xSize * y)];
    
}

-(void)setQuestionAnswerRecordsXY:(int)x y:(int)y record:(QuestionAnswerRecords*)record{
    [_answerRecordsArray replaceObjectAtIndex:(x + _xSize * y) withObject:record];
    
}


@end
