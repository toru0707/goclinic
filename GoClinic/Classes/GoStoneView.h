//
//  GoStoneView.h
//  GoClinic
//
//  Created by 猪子 徹 on 10/08/15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define STONE_FONT_SIZE 18;
#define GOSTONE_VIEW_WHITE_COLOR_ID 0
#define GOSTONE_VIEW_BLACK_COLOR_ID 1

@class GoStoneView;
@class GameRecords;

@protocol GoStoneViewDelegate
-(void) touchEndGoStone:(NSSet *)theTouch withEvent:(UIEvent *)event withGoStoneView:(GoStoneView *)stoneView;
-(void) touchBeganGoStone:(NSSet *)theTouch withEvent:(UIEvent *)event withGoStoneView:(GoStoneView *)stoneView;
-(void) touchCancelledGoStone:(NSSet *)theTouch withEvent:(UIEvent *)event withGoStoneView:(GoStoneView *)stoneView;
-(void) touchForMenu:(NSSet *)theTouch withEvent:(UIEvent*)event withGoStoneView:(GoStoneView *)stoneView;
-(void) touchForMenuCancel:(GoStoneView*)stoneView;
@end

/**
 石を表示するView
 @author inoko
 */
@interface GoStoneView : UIView{
	id<GoStoneViewDelegate> _delegate;
	UIImageView* _faceView;
	int _displayMode;
	int _move;
	int _faceId;
	//0:Black, 1:White
	int _stoneColorId;
	float _stoneOpacity;
    BOOL _showFace;
    BOOL _showNumber;
	BOOL _isHighLighted;
	BOOL _isFaceDisplayed;
	BOOL _isHavingBranches;
	int draggingCanon;
	CGRect _originLocation;
	CGRect _startLocation;
	//2秒押し続けたときにメニューを表示するためのタイマー
	NSTimer* _menuTimer;
    
    int _real_x;
    int _real_y;
    
    GameRecords* _record;
}
@property int move;
@property int faceId;
@property int displayMode;
@property BOOL showFace;
@property BOOL showNumber;
@property BOOL isHighLighted;
@property BOOL isFaceDisplayed;
@property BOOL isHavingBranches;
@property int real_x;
@property int real_y;
@property int stoneColorId;
@property (nonatomic, assign) CGRect originLocation;
@property (nonatomic, assign) CGRect startLocation;
@property (nonatomic, assign) float stoneOpacity;
@property (nonatomic, assign) id<GoStoneViewDelegate> delegate;
@property (nonatomic, retain) GameRecords* record;

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

-(void)showContextMenu:(UIView*)targetView;

-(void)drawGreenCircle;
-(void)drawRedCircle;
-(void)drawNumber;
-(void)drawFace;
-(void)drawNone;
@end
