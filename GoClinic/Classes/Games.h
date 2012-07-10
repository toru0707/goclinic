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

#define MAX_MOVE 400 ///< ゲームの最大手数
#define AUTO_SAVE_INTERVAL 5 ///< ゲームの自動セーブ間隔（手数）
#define NORMAL_GAME_CATEGORY 0 ///< 通常モードのゲームカテゴリ
#define TSUMEGO_GAME_CATEGORY 1 ///< 詰碁モードのゲームカテゴリ
#define QUESTION_GAME_CATEGORY 2 ///< 問題モードのゲームカテゴリ

#define THE_STONE_IS_NOT_PUTTABLE_BECAUSE_DUPULICATED -1 ///< 状態ID（既に碁石が存在するため、石を配置できない）
#define THE_STONE_IS_NOT_PUTTABLE_BECAUSE_SUICEDED -2 ///< 状態ID（自殺手のため、石を配置できない）
#define THE_STONE_IS_PUTTABLE 1 ///< 状態ID（石を配置できる）

/**
 ゲームの情報を扱う抽象クラス
 @auther inoko
 */
@interface Games :  NSManagedObject  
{
	NSMutableArray* _recordStack; ///< プロパティ受け渡し用変数
	BOOL _isNewBranchRecord; ///< プロパティ受け渡し用変数
  BOOL _isShowNumberMode; ///< プロパティ受け渡し用変数
  BOOL _isShowFaceMode; ///< プロパティ受け渡し用変数
	
	int _xSize; ///< プロパティ受け渡し用変数
	int _ySize; ///< プロパティ受け渡し用変数
	
	NSMutableArray* _stoneArray; ///< プロパティ受け渡し用変数
	NSMutableArray* _checkBoard; ///< プロパティ受け渡し用変数
  NSMutableArray* _okiishiArray; ///< プロパティ受け渡し用変数
	
	int _insertMode; ///< プロパティ受け渡し用変数
	int _currentUserId; ///< プロパティ受け渡し用変数
	BOOL _autoSaveEnable; ///< 自動セーブをするか
	int _autoSaveInterval; ///< 自動セーブまでの手数間隔
	int _currentDepth; ///< 現在のクリニック階層 
}
@property int currentUserId; ///<現在の順番のユーザID
@property int insertMode; ///<棋譜入力モードか否か
@property int autoSaveInterval; ///<自動セーブ間隔
@property int xSize; ///<盤面の幅（何目か）
@property int ySize; ///<盤面の高さ（何目か）
@property int currentDepth; ///<クリニックの階層を示す。デフォルトは０
@property BOOL isNewBranchRecord; ///<分岐を開始した直後の碁石か否か
@property BOOL isShowNumberMode; ///<手数を表示するか
@property BOOL isShowFaceMode; ///<BOB顔を表示するか
@property BOOL autoSaveEnable; ///<自動セーブが有効化どうか
@property (nonatomic, retain) NSMutableArray* stoneArray; ///<ゲーム中の全ての碁石（階層0）を格納する配列。手数でソートされている
@property (nonatomic, retain) NSMutableArray* recordStack; ///<現在盤面に表示されている碁石を格納しており、抜き石された場合、取り除かれる。手数でソートされている。
@property (nonatomic, retain) NSMutableArray* checkBoard; ///<抜き石状態を確認するための碁石配列。手数でソートされている。
@property (nonatomic, retain) NSMutableSet* game_records; ///<ゲーム中の全ての碁石を格納する配列
@property (nonatomic, retain) NSString* title; ///<ゲームのタイトル
@property (nonatomic, retain) GameRecords* current_root_record; ///<現在の階層の初手を示す。分岐していた場合、分岐元の碁石を示す。
@property (nonatomic, retain) GameRecords* current_record; ///<現在選択されている碁石
@property (nonatomic, retain) GameRecords* first_record; ///<初手の碁石
@property (nonatomic, retain) GameRecords* last_record; ///<現在の階層の最終手の碁石
@property (nonatomic, retain) BoardView* boardView; ///<盤面のView
@property (nonatomic, retain) NSNumber* current_move; ///<現在の手数
@property (nonatomic, retain) NSNumber* current_branch_move; ///<分岐元の碁石の手数
@property (nonatomic, retain) NSNumber* game_category; ///<ゲームのカテゴリ
@property (nonatomic, retain) NSNumber* is_tmp_game; ///<未保存のゲームか
@property (nonatomic, retain) NSNumber* is_updated; ///<更新されたゲームか
@property (nonatomic, retain) NSNumber* is_state_saved; ///<セーブされたゲームか
@property (nonatomic, retain) NSNumber* first_user_id; ///<先手のユーザID
@property (nonatomic, retain) NSNumber* second_user_id; ///<後手のユーザID
@property (nonatomic, retain) Users* current_user; ///<現在の手番のユーザ
@property (nonatomic, retain) Users* first_user; ///<先手のユーザ
@property (nonatomic, retain) Users* second_user; ///<後手のユーザ
@property (nonatomic, retain) NSDate* save_date; ///<最終セーブ日付

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

/**
 指定された座標に通常の碁石を配置する。
 */
-(GameRecords*)createNewNormalRecord:(int)x y:(int)y;
/**
 指定された座標に分岐の碁石を配置する。
 */
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

/**
指定されたGameRecordをCurrent_recordに設定する
*/
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

/**
 以下のメソッドの実装は、ManagedObjectによって動的に生成される
 */
@interface Games (CoreDataGeneratedAccessors)
/**
 * 指定された碁石を保存する
 */
-(void)addGame_recordsObject:(GameRecords *)value;
/**
 * 指定された碁石を削除する
 */
-(void)removeGame_recordsObject:(GameRecords *)value;
/**
 * 指定された碁石配列を保存する
 */
-(void)addGame_records:(NSSet *)value;
/**
 * 指定された碁石配列を削除する
 */
-(void)removeGame_records:(NSSet *)value;
@end



