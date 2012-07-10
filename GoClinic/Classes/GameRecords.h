//
//  GameRecords.h
//  GoClinic
//
//  Created by 猪子 徹 on 10/10/17.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>
@class GoStoneView;
@class Comments;
@class GoStones;
@class Games;

/**
 棋譜の手情報を格納クラス
 @auther inoko
 */
@interface GameRecords :  NSManagedObject  
{
	GoStoneView* _view; ///< プロパティ受け渡し用変数
	NSNumber* _prevX; ///< プロパティ受け渡し用変数
	NSNumber* _prevY; ///< プロパティ受け渡し用変数
  BOOL _isRemoved; ///< プロパティ受け渡し用変数
}
@property BOOL isRemoved; ///< 抜き石になったかどうか
@property (nonatomic, retain) GoStoneView* view; ///<碁石を表現するView
@property (nonatomic, retain) NSNumber* prevX; ///<直前のX座標
@property (nonatomic, retain) NSNumber* prevY; ///<直前のY座標
@property (nonatomic, retain) NSNumber* depth; ///<分岐の階層
@property (nonatomic, retain) NSNumber* is_bad; ///<悪手か否か
@property (nonatomic, retain) NSNumber* face_id; ///<BOB顔ID
@property (nonatomic, retain) NSNumber* point; ///<手の評価
@property (nonatomic, retain) NSNumber* is_good; ///<良手か否か
@property (nonatomic, retain) NSNumber* is_shown_state; ///<碁石が表示されているか否か
@property (nonatomic, retain) NSNumber* move; ///<手数
@property (nonatomic, retain) NSNumber* removed_move; ///<この碁石が取られた手数
@property (nonatomic, retain) NSNumber* answer_move; ///<この碁石が取られた手数

@property (nonatomic, retain) NSMutableSet * removed_by; ///< この碁石を抜き石する碁石の集合
@property (nonatomic, retain) NSNumber* move_on_face_registered; ///<この碁石に対するBOB顔が表示される手数
@property (nonatomic, retain) NSNumber* user_id; ///<この碁石を置いたユーザのID
@property (nonatomic, retain) NSSet* comments; ///<碁石に対するコメント配列
@property (nonatomic, retain) GameRecords* next_game_records; ///<この碁石の次の碁石
@property (nonatomic, retain) GameRecords* branch_records; ///<この碁石の分岐碁石
@property (nonatomic, retain) Games* games; ///<この碁石が使用されているGame
@property (nonatomic, retain) GameRecords* root_record; ///<一番初めの手数の碁石。分岐している場合は分岐元の碁石。
@property (nonatomic, retain) GameRecords* prev_game_records; ///<一手前の碁石
@property (nonatomic, retain) NSNumber* is_answer; ///<解答用の碁石か否か
@property (nonatomic, retain) NSNumber* is_okiishi; ///<置き石か否か
@property (nonatomic, retain) NSNumber* x; ///<現在のX座標
@property (nonatomic, retain) NSNumber* y; ///<現在のY座標
@property (nonatomic, retain) NSNumber* real_x; ///<現在のX座標(pixel)
@property (nonatomic, retain) NSNumber* real_y; ///<現在のY座標(pixel)
@property (nonatomic, retain) NSNumber* width; ///<碁石の幅
@property (nonatomic, retain) NSNumber* height; ///<碁石の高さ


/**
 コンストラクタ
 Frame情報（xピクセル、yピクセル）から作成する。
 @param frame 棋譜のxピクセル,yピクセル
 @return インスタンス
 */
- (id)initWithFrame:(CGRect)frame;

/**
 コンストラクタ
 手数が0の一時レコードを作成する。石を打った時に、その手が自殺手か否か判断するために使用する
 @return インスタンス
 */
- (id)initTmpRecord;

/**
 コンストラクタ
 @param game 現在のゲーム
 @param move 手番
 @param prev 一つ前の手番の棋譜
 @param next 一つ後の手番の棋譜
 @return インスタンス
 */
- (id)initNewRecord:(Games *)game move:(int)move prev:(GameRecords*)prev next:(GameRecords*)next;

/**
 *指定されたパラメータで碁石を初期化する
 */
-(void)initParams:(Games*)game move:(int)move prev:(GameRecords*)prev next:(GameRecords*)next;

/**
 指定されたユーザIDと同一のユーザIDの棋譜かを返す
 @param userId 指定されたユーザID
 @return 同一のユーザIDの場合YES
 */
- (BOOL)isSameUserId:(int)userId;

/**
 棋譜をDBから削除する
 @return 削除が成功した場合YES
 */
- (BOOL)delete;
@end


/**
 以下のメソッドの実装は、ManagedObjectによって動的に生成される
 */
@interface GameRecords (CoreDataGeneratedAccessors)
/**
 指定されたコメントを保存する
 */
- (void)addCommentsObject:(Comments *)value;
/**
 指定されたコメントを削除する
 */
- (void)removeCommentsObject:(Comments *)value;
/**
 指定された複数のコメントを保存する
 */
- (void)addComments:(NSSet *)value;
/**
 指定された複数のコメントを削除する
 */
- (void)removeComments:(NSSet *)value;
@end

