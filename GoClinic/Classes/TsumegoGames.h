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
 詰碁モード用のGameクラス
 @auther inoko
 */
@interface TsumegoGames :  Games  
{
	NSMutableArray* _answerStack; ///< 解答登録モードの碁石が格納されるスタック。抜き石は削除される。手数でソートされている。
	NSMutableArray* _challengeStack; ///< 問題チャレンジモード用の碁石が格納されるスタック。抜き石は削除される。手数でソートされている。
	NSMutableArray* _tsumegoStones; ///< 詰碁置き石モードの全碁石が格納される配列。
	BOOL _isAnswerRegistMode; ///< プロパティ受け渡し用変数
	BOOL _isChallengeRegistMode; ///< プロパティ受け渡し用変数
  BOOL _isOkisihiMode; ///< プロパティ受け渡し用変数
  
  int _okiishiUserId; ///< プロパティ受け渡し用変数
  int _answerMove; ///< プロパティ受け渡し用変数
  NSString* _questionCategory; ///< プロパティ受け渡し用変数
  TsumegoGameState* _state; ///< ゲーム状態オブジェクト
}
@property BOOL isChallengeRegistMode; ///<問題チャレンジモードか
@property BOOL isOkiishiMode; ///<詰碁置き石モードか
@property BOOL isAnswerRegisterMode; ///<解答登録モードか
@property int answerMove; ///<解答登録碁石の手数
@property int okiishiUserId; ///<置き石のユーザID
@property (nonatomic, retain) NSNumber* answer_move; ///< 解答登録碁石の手数
@property (nonatomic, retain) NSString* questionCategory; ///< 問題のカテゴリ

/**
 指定された状態オブジェクトへ状態を変更する
*/
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



