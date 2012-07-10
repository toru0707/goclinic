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
 問題モード用のGameクラス
 @auther inoko
 */
@interface QuestionGames : Games {
  QuestionGameState* _state; ///< プロパティ受け渡し用変数
    
	NSMutableArray* _answerStack; ///< プロパティ受け渡し用変数
	NSMutableArray* _answerRecordsArray; ///< 解答用の碁石を格納する配列。
  NSMutableArray* _questionRecordsArray; ///< プロパティ受け渡し用変数
}
@property (nonatomic, retain) QuestionGameState* state; ///< ゲームの状態を表すStateオブジェクト
@property (nonatomic ,retain) NSMutableArray* answerStack; ///< 現在表示中の解答の碁石を格納するStack。抜き石は削除されている。手数でソートされている。
@property (nonatomic, retain) NSMutableSet* question_records; ///< 問題用の碁石を格納する配列

/**
 *通常モードか
 */
-(BOOL)isNormalState;
/**
 *メッセージ書き込みモードか
 */
-(BOOL)isMessageState;
/**
 *解答モードか
 */
-(BOOL)isAnswerState;


/**
 指定された状態オブジェクトへ状態を変更する
 */
-(void)changeState:(QuestionGameState*)state;

/**
 *通常モードへ変更する
 */
-(void)changeToNormalState;
/**
 *解凍モードへ変更する
 */
-(void)changeToAnswerState;
/**
 *問題用碁石を生成する
 */
-(GameRecords*)createQuestionMessageRecord:(int)x y:(int)y faceCategory:(int)faceCategory comment:(NSString*)comment;
/**
 *指定されたXY座標に存在する問題碁石を取得する。存在しない場合nilを返す。
 */
-(GameRecords*)getQuestionRecordXY:(int)x y:(int)y;
/**
 *指定されたXY座標に問題碁石をセットする
 */
-(void)setQuestionRecordsXY:(int)x y:(int)y record:(GameRecords*)record;
/**
 *指定されたXY座標の解答用碁石を取得する。存在しない場合nilを返す
 */
-(GameRecords*)getQuestionAnswerRecordXY:(int)x y:(int)y;
/**
 *指定されたXY座標に解答用碁石をセットする
 */
-(void)setQuestionAnswerRecordsXY:(int)x y:(int)y record:(GameRecords*)record;

@end
