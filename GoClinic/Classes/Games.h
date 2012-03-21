//
//  Games.h
//  GoClinic
//
//  Created by 猪子 徹 on 10/10/11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "GameRecords.h"
#import "Users.h"
#import "GameRecordStack.h"
#import "Global.h"
#import "BoardView.h"
#import "GoStoneView.h"

#define MAX_MOVE 400
#define AUTO_SAVE_INTERVAL 5
#define NORMAL_GAME_CATEGORY 0
#define TSUMEGO_GAME_CATEGORY 1
#define QUESTION_GAME_CATEGORY 2

#define THE_STONE_IS_NOT_PUTTABLE_BECAUSE_DUPULICATED -1
#define THE_STONE_IS_NOT_PUTTABLE_BECAUSE_SUICEDED -2
#define THE_STONE_IS_PUTTABLE 1

/**
 ゲームの情報を扱う抽象クラス
 @auther inoko
 */
@interface Games :  NSManagedObject  
{
	NSMutableArray* _recordStack;
	BOOL _isNewBranchRecord;
    BOOL _isShowNumberMode;
    BOOL _isShowFaceMode;
	
	int _xSize;
	int _ySize;
	
	NSMutableArray* _stoneArray;
	NSMutableArray* _checkBoard;
    NSMutableArray* _okiishiArray;
	
    //棋譜入力モード
	int _insertMode;
    //現在の
	int _currentUserId;
	//自動セーブを行う
	BOOL _autoSaveEnable;
	//自動セーブ迄のカウント
	int _autoSaveInterval;
	//クリニックの階層を示す。デフォルトは０
	int _currentDepth;
}
@property int currentUserId;
@property int insertMode;
@property int autoSaveInterval;
@property int xSize;
@property int ySize;
@property int currentDepth;
@property BOOL isNewBranchRecord;
@property BOOL isShowNumberMode;
@property BOOL isShowFaceMode;
@property BOOL autoSaveEnable;
@property (nonatomic, retain) NSMutableArray* stoneArray;
@property (nonatomic, retain) NSMutableArray* checkBoard;

@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) GameRecords* current_root_record;
@property (nonatomic, retain) BoardView* boardView;
@property (nonatomic, retain) NSMutableArray* recordStack;
@property (nonatomic, retain) NSNumber * current_move;
@property (nonatomic, retain) NSNumber * current_branch_move;
@property (nonatomic, retain) GameRecords* current_record;
@property (nonatomic, retain) GameRecords* first_record;
@property (nonatomic, retain) GameRecords* last_record;
@property (nonatomic, retain) Users* current_user;
@property (nonatomic, retain) NSNumber * first_user_id;
@property (nonatomic, retain) NSNumber * second_user_id;
@property (nonatomic, retain) NSNumber * game_category;
@property (nonatomic, retain) NSMutableSet* game_records;
@property (nonatomic, retain) Users * first_user;
@property (nonatomic, retain) Users * second_user;
@property (nonatomic, retain) NSNumber * is_tmp_game;
@property (nonatomic, retain) NSDate *save_date;
@property (nonatomic, retain) NSNumber* is_updated;
@property (nonatomic, retain) NSNumber* is_state_saved;

/**
 コンストラクタ
 @return インスタンス
 */
-(id)initGames;

/**
 コンストラクタ
 盤面のサイズを指定する
 @param xSize 盤面のx幅
 @param ySize 盤面のy幅
 @return インスタンス
 */
-(id)initGamesWithBoardSize:(int)xSize ySize:(int)ySize;

/**
 ゲームを保存する
 @return 保存が成功した場合YES
 */
-(BOOL)save;


/**
 ゲームを初期状態に戻す
 @return 初期状態への変更が成功した場合YES
 */
-(BOOL)reset;

/**
 ゲームを削除する
 @return 削除が成功した場合YES
 */
-(BOOL)delete;

/**
 ゲームをリストアする
 <p>
 全ての棋譜に対応するGoStoneViewを作成し、棋譜に関連付ける。
 又、手番順にRecordスタックに格納し、最も手番が大きい棋譜をCurrent_recordに設定する。
 </p>
 */
-(void)restore;


/**
 盤面に表示されているGoStoneViewをクリアする
 */
-(void)clearStoneBoard;

/**
 x, y座標を指定して棋譜を作成する。各ゲーム実装により作成される棋譜は異なる。
 @param x x座標
 @param y y座標
 @param goStoneView 棋譜Viewオブジェクト
 @return 作成されたGameRecordオブジェクト
 */
-(GameRecords*)createNewRecord:(int)x y:(int)y goStoneView:(GoStoneView*)view;

/**
 x, y座標を指定して置石を作成する。各ゲーム実装により作成される棋譜は異なる。
 @param x x座標
 @param y y座標
 @param record 棋譜オブジェクト
 @return 作成されたGameRecordオブジェクト
 */
-(GameRecords*)createOkiishiRecord:(int)x y:(int)y goStoneView:(GoStoneView*)view;


-(GameRecords*)createNewNormalRecord:(int)x y:(int)y;
-(GameRecords*)createNewBranchRecord:(int)x y:(int)y;

/**
 現在の棋譜の分岐レコードにへ遷移する。
 @return 分岐があり、遷移可能な場合はYES
 */
-(BOOL)changeToBranchRecord;

/**
 現在の棋譜のRootレコード（一つ上の階層）へ遷移する。
 @return Rootレコードがあり、遷移可能な場合はYES
 */
-(BOOL)changeToRootRecord;

/**
 現在の手の次の手として指定された座標に石を置いた場合、石を置くことが出来るかを示す。
 返却されるコードにより、石を置けない理由が判断可能
 @param x x座標
 @param y y座標
 @return 理由ID THE_STONE_IS_NOT_PUTTABLE_BECAUSE_DUPULICATED -1
                THE_STONE_IS_NOT_PUTTABLE_BECAUSE_SUICEDED -2
                THE_STONE_IS_PUTTABLE 1
 */
-(int)checkCurrentNextRecordPuttable:(int)x y:(int)y;

/**
 指定された棋譜を置くことが出来るかを示す。
 返却されるコードにより、石を置けない理由が判断可能
 条件：指定された棋譜にはXY座標と、手番が指定されていなければならない。
 @param record 指定された棋譜
 @return 理由ID THE_STONE_IS_NOT_PUTTABLE_BECAUSE_DUPULICATED -1
                THE_STONE_IS_NOT_PUTTABLE_BECAUSE_SUICEDED -2
                THE_STONE_IS_PUTTABLE 1
 */
-(int)checkRecordPuttable:(GameRecords*)record;

/**
 指定された手番のユーザIDを返す
 @param move 手番
 @return ユーザID
 */
-(int)checkUser:(int)move;

/**
 指定された棋譜を削除する。同時に以下に影響を与える。
 ・Current_recordのPrevRecordのNextRecordにNilを設定する
 ・指定された棋譜がLastRecordの場合は、棋譜のPrevRecordをLastRecordに設定する
 ・RecordStackから棋譜を取り除く
 @param record 削除する棋譜
 */
-(void)deleteGameRecord:(GameRecords*)record;

/**
 指定した棋譜以降の棋譜を全て削除する
 @param record 削除の起点となる棋譜
 */
-(void)deleteGameRecordCyclic:(GameRecords *)record;

/**
 現在の手番のユーザのユーザIDを返す
 @return 現在の手番のユーザのユーザID
 */
-(NSNumber*)getCurrentUserId;

/**
 棋譜のスタックの中で、指定された手番以降の棋譜で抜き石となる棋譜の配列を返す
 @param fromMove 抜き石を評価する起点となる手番
 @return 抜き石となる棋譜の配列
 
 */
-(NSMutableArray*)getEnclosedStonesFromStack:(int)fromMove;

/**
 指定された棋譜により抜き石となる棋譜配列を返す
 @param record 指定された棋譜
 @return 抜き石となる棋譜の配列
 */
-(NSMutableArray*)getEnclosedStonesFromRecord:(GameRecords*)record;

/**
 指定の座標に存在する棋譜を返す
 @param x x座標
 @param y y座標
 @return 指定された座標の棋譜。存在しない場合はNilを返す。
 */
-(GameRecords*)getStoneArrayXY:(int)x y:(int)y;

/**
 現在の棋譜を一手先に進める
 影響：Current_recordが変更される
 @return 一手先の棋譜。存在しない場合はNilを返す。
 */
-(GameRecords *)moveToNextRecord;

/**
 現在の棋譜を一手前に戻す
 影響：Current_recordが変更される
 @return 一手前の棋譜。存在しない場合はNilを返す。
 */
-(GameRecords *)moveToPrevRecord;


-(void)setNewCurrentRecord:(GameRecords *)newRecord;

/**
 指定された棋譜以降の棋譜全てをRecordスタックに順に追加する。
 但し、同じ階層の棋譜のみを追加し、分岐の棋譜は追加しない
 @param record 追加の起点となる棋譜
 */
-(void)pushRecordToStackCyclic:(GameRecords*)record;

/**
 指定された手番以降の棋譜を棋譜スタックから取り除く。
 @param move 取り除く起点となる手番
 */
-(void)popStackToMoveCyclic:(NSNumber*)move;

/**
 Recordスタック内の棋譜全てをログに出力する
 */
-(void)showStackLog;

/**
 盤面上の棋譜全てをログに出力する
 */
-(void)showStonesXYLog;

/**
 Recordスタック内の棋譜全てを盤面上に配置する
 */
-(void)setStackToXYArray;

/**
 指定された座標の盤面に指定された棋譜を配置する
 @param x 盤面のX座標
 @param y 盤面のY座標
 @param record 盤面に配置する棋譜
 */
-(void)setStoneArrayXY:(int)x y:(int)y stone:(GameRecords*)record;

@end


