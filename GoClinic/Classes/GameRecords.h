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
 棋譜のモデルクラス
 @auther inoko
 */
@interface GameRecords :  NSManagedObject  
{
	GoStoneView* _view;
	NSNumber* _prevX;
	NSNumber* _prevY;
	//抜き石になったかどうか
	BOOL _isRemoved;
}
@property BOOL isRemoved;
@property (nonatomic, retain) GoStoneView* view;
@property (nonatomic, retain) NSNumber * prevX;
@property (nonatomic, retain) NSNumber * prevY;

@property (nonatomic, retain) NSNumber * depth;
@property (nonatomic, retain) NSNumber * is_bad;
@property (nonatomic, retain) NSNumber * face_id;
@property (nonatomic, retain) NSNumber * point;
@property (nonatomic, retain) NSNumber * is_good;
@property (nonatomic, retain) NSNumber * is_shown_state;
@property (nonatomic, retain) NSNumber * move;
@property (nonatomic, retain) NSNumber * removed_move;
@property (nonatomic, retain) NSNumber * answer_move;
@property (nonatomic, retain) NSNumber * move_on_face_registered;
@property (nonatomic, retain) NSNumber * user_id;
@property (nonatomic, retain) NSSet* comments;
@property (nonatomic, retain) GameRecords * next_game_records;
@property (nonatomic, retain) GameRecords * branch_records;
@property (nonatomic, retain) Games* games;
@property (nonatomic, retain) GameRecords * root_record;
@property (nonatomic, retain) GameRecords * prev_game_records;
@property (nonatomic, retain) NSNumber * is_answer;
@property (nonatomic, retain) NSNumber * is_okiishi;
@property (nonatomic, retain) NSMutableSet * removed_by;
@property (nonatomic, retain) NSNumber * x;
@property (nonatomic, retain) NSNumber * y;
@property (nonatomic, retain) NSNumber * real_x;
@property (nonatomic, retain) NSNumber * real_y;
@property (nonatomic, retain) NSNumber * width;
@property (nonatomic, retain) NSNumber * height;


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


@interface GameRecords (CoreDataGeneratedAccessors)
- (void)addCommentsObject:(Comments *)value;
- (void)removeCommentsObject:(Comments *)value;
- (void)addComments:(NSSet *)value;
- (void)removeComments:(NSSet *)value;


@end

