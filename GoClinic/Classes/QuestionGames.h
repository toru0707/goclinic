//
//  QuestionGames.h
//  GoClinic
//
//  Created by 猪子 徹 on 11/04/03.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Games.h"
#import "QuestionMessageRecords.h"
#import "QuestionAnswerRecords.h"

@class QuestionGameState;

/**
 問題モード用のゲームクラス
 @auther inoko
 */
@interface QuestionGames : Games {
    QuestionGameState* _state;
    
	NSMutableArray* _answerStack;
	NSMutableArray* _answerRecordsArray;
    NSMutableArray* _questionRecordsArray;
}
@property (nonatomic, retain) QuestionGameState* state;
@property (nonatomic ,retain) NSMutableArray* answerStack;
@property (nonatomic, retain) NSMutableSet* question_records;

-(BOOL)isNormalState;
-(BOOL)isMessageState;
-(BOOL)isAnswerState;

-(void)changeToNormalState;
-(void)changeToAnswerState;
-(GameRecords*)createQuestionMessageRecord:(int)x y:(int)y faceCategory:(int)faceCategory comment:(NSString*)comment;
-(GameRecords*)getQuestionRecordXY:(int)x y:(int)y;
-(void)setQuestionRecordsXY:(int)x y:(int)y record:(GameRecords*)record;
-(GameRecords*)getQuestionAnswerRecordXY:(int)x y:(int)y;
-(void)setQuestionAnswerRecordsXY:(int)x y:(int)y record:(GameRecords*)record;

@end
