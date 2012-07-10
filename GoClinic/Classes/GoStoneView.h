//
//  GoStoneView.h
//  GoClinic
//
//  Created by 猪子 徹 on 10/08/15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define STONE_FONT_SIZE 18; ///< 碁石の手数のフォントサイズ
#define GOSTONE_VIEW_WHITE_COLOR_ID 0 ///< 白石の色ID
#define GOSTONE_VIEW_BLACK_COLOR_ID 1 ///< 黒石の色ID

@class GoStoneView;
@class GameRecords;

@protocol GoStoneViewDelegate
/**
碁石へのタッチが終了したときに呼び出されるメソッド
*/
-(void) touchEndGoStone:(NSSet *)theTouch withEvent:(UIEvent *)event withGoStoneView:(GoStoneView *)stoneView;
/**
碁石へのタッチが開始したときに呼び出されるメソッド
*/
-(void) touchBeganGoStone:(NSSet *)theTouch withEvent:(UIEvent *)event withGoStoneView:(GoStoneView *)stoneView;
/**
碁石へのタッチがキャンセルされたときに呼び出されるメソッド
*/
-(void) touchCancelledGoStone:(NSSet *)theTouch withEvent:(UIEvent *)event withGoStoneView:(GoStoneView *)stoneView;
/**
コンテキストメニューにタッチしたときに呼び出されるメソッド
*/
-(void) touchForMenu:(NSSet *)theTouch withEvent:(UIEvent*)event withGoStoneView:(GoStoneView *)stoneView;
/**
コンテキストメニューへのタッチがキャンセルされたときに呼び出されるメソッド
*/
-(void) touchForMenuCancel:(GoStoneView*)stoneView;
@end

/**
 碁石のView
 @author inoko
 */
@interface GoStoneView : UIView{
	id<GoStoneViewDelegate> _delegate; ///< プロパティ受け渡し用変数
	UIImageView* _faceView; ///< BOB顔View
	int _displayMode; ///< プロパティ受け渡し用変数
	int _move; ///< プロパティ受け渡し用変数
	int _faceId; ///< プロパティ受け渡し用変数
	//0:Black, 1:White
	int _stoneColorId; ///< プロパティ受け渡し用変数
	float _stoneOpacity; ///< プロパティ受け渡し用変数
  BOOL _showFace; ///< プロパティ受け渡し用変数
  BOOL _showNumber; ///< プロパティ受け渡し用変数
	BOOL _isHighLighted; ///< プロパティ受け渡し用変数
	BOOL _isFaceDisplayed; ///< プロパティ受け渡し用変数
	BOOL _isHavingBranches; ///< プロパティ受け渡し用変数
	CGRect _originLocation; ///< プロパティ受け渡し用変数
	CGRect _startLocation; ///< プロパティ受け渡し用変数
  int _real_x; ///< プロパティ受け渡し用変数
  int _real_y; ///< プロパティ受け渡し用変数
  GameRecords* _record; ///< プロパティ受け渡し用変数
	
  NSTimer* _menuTimer; ///<2秒押し続けたときにメニューを表示するためのタイマー
  int draggingCanon; ///<ドラッグ状態か
}
@property int displayMode; ///<表示モード
@property int move; ///<手数
@property int faceId; ///<BOB顔ID
@property int stoneColorId; ///<碁石の色ID。0:Black, 1:White
@property int real_x; ///<碁石のX座標（pixel)
@property int real_y; ///<碁石のY座標（pixel)
@property BOOL showFace; ///<BOB顔が表示されているか
@property BOOL showNumber; ///<手数が表示されているか
@property BOOL isHighLighted; ///<ハイライトされているか
@property BOOL isFaceDisplayed; ///<BOB顔が表示されているか
@property BOOL isHavingBranches; ///<分岐を持っているか
@property (nonatomic, assign) float stoneOpacity; ///<碁石の透明度
@property (nonatomic, assign) CGRect originLocation; ///<ドラッグ前の碁石の位置
@property (nonatomic, assign) CGRect startLocation; ///<ドラッグを開始した時点の碁石の位置
@property (nonatomic, assign) GameRecords* record; ///<碁石情報
@property (nonatomic, assign) id<GoStoneViewDelegate> delegate; ///< デリゲートオブジェクト 

/**
 棋譜からViewを生成する。手番と、顔IDを設定する。
 @param record 棋譜
 @return GoStoneViewオブジェクト
 */
-(id)initWithGameRecords:(GameRecords*)record;

/**
 石のコンテキストメニューを表示するためのデリゲートメソッドを呼び出す
 @selector(touchForMenu:withEvent:withGoStoneView:)
 */
-(void)invokeTouchForMenu;
/**
 *コンテキストメニューを表示する
 */
- (void)showContextMenu:(UIView*)targetView; 
/**
 *碁石を緑でハイライトする
 */
- (void)drawGreenCircle;
/**
 *碁石を赤でハイライトする
 */
- (void)drawRedCircle;
/**
 *手数を描画する
 */
- (void)drawNumber;
/**
 *BOB顔を描画する
 */
- (void)drawFace;
/**
 *碁石を塗りつぶす
 */
- (void)drawNone;
@end
