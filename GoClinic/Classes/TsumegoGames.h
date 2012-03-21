//
//  *
//  GoClinic
//
//  Created by 猪子 徹 on 11/02/23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "Games.h"
#import "GameRecordStack.h"
#import "TsumegoGameState.h"

/**
 詰碁モード用のゲームクラス
 @auther inoko
 */
@interface TsumegoGames :  Games  
{
	NSMutableArray* _answerStack;
	NSMutableArray* _challengeStack;
	NSMutableArray* _tsumegoStones;
	//解答登録モード
	BOOL _isAnswerRegistMode;
	//問題チャレンジモード
	BOOL _isChallengeRegistMode;
    //詰碁置石モード
    BOOL _isOkisihiMode;
    
    int _okiishiUserId;
    
    NSString* _questionCategory;
    
    //TsumegoGame
    int _answerMove;
    
    TsumegoGameState* _state;
}

@property BOOL isAnswerRegistMode;
@property BOOL isChallengeRegistMode;
@property BOOL isOkiishiMode;
@property int answerMove;
@property int okiishiUserId;
@property BOOL isAnswerRegisterMode;
@property (nonatomic, retain) NSNumber* answer_move;
@property (nonatomic, retain) NSString* questionCategory;

-(void)changeState:(TsumegoGameState*)state;

/**
 解答棋譜スタックから指定された手番以降の抜き石棋譜配列を取得する
 @param fromMove 指定された起点となる手番
 @return 抜き石棋譜配列
 */
-(NSMutableArray*)getEnclosedStonesFromAnswerStack:(int)fromMove;

/**
 チャレンジ棋譜スタックから指定された手番以降の抜き石棋譜配列を取得する
 @param fromMove 指定された起点となる手番
 @return 抜き石棋譜配列
 */
-(NSMutableArray*)getEnclosedStonesFromChallengeStack:(int)fromMove;
@end



