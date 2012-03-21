//
//  BoardView.h
//  GoClinic
//
//  Created by 猪子 徹 on 10/08/15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnimationView.h"
#import "Global.h"
#import "GameRecords.h"
#import	"GoStoneView.h"

@protocol BoardViewDelegate
-(void) putGoStone:(GoStoneView *)stoneView x:(int)x y:(int)y;
-(void) touchBoard:(UITouch *)theTouch withView:(UIView *)view;
-(void) touchBeganBoardWithStone:(UITouch *)theTouch withEvent:(UIEvent *)event withGoStoneView:(GoStoneView *)stoneView;
-(void) touchEndedBoardWithStone:(UITouch *)theTouch withEvent:(UIEvent *)event withGoStoneView:(GoStoneView *)stoneView;
-(int)  checkPutGoStone:(NSSet *)theTouch withEvent:(UIEvent *)event withGoStoneView:(GoStoneView *)stoneView;
-(void) moveGoStone:(GoStoneView *)stoneView toRect:(CGRect)toRect;
-(void) touchForMenuWithStone:(UITouch *)theTouch withEvent:(UIEvent*)event withGoStoneView:(GoStoneView *)stoneView;
-(void) touchForMenuCancelWithStone:(GoStoneView*)stoneView;
@end

/**
 盤面のView
 @auther inoko
 */
@interface BoardView : AnimationView <GoStoneViewDelegate>{
	id<BoardViewDelegate> _delegate;
	Boolean _redrawBoard;
	BOOL _isStarDrawn;
	BOOL _isXYScaleDrawn;
	BOOL _isStoneMobed;
	int _xSize;
	int _ySize;
	
	GameRecords* _currentSelection;
}
@property (nonatomic, assign) id <BoardViewDelegate> delegate; 
@property BOOL isStarDrawn;
@property BOOL isXYScaleDrawn;
@property int xSize;
@property int ySize;
@property (nonatomic, retain) NSMutableArray *stones;

/**
 コンストラクタ
 @param xSize 盤面のX幅
 @param ySize 盤面のY幅
 @param BoardViewオブジェクト
 */
-(id)initWithXYSizes:(int)xSize ySize:(int)ySize;

/**
 x座標、y座標を指定し、棋譜を作成する
 @param x x座標
 @param y y座標
 @return 作成された棋譜
 */
-(GameRecords*)createGameRecords:(int)x y:(int)y;

/**
 指定された棋譜配列に対応する石Viewを、デバイスの傾き方向へアニメーションさせる
 @param recordArray アニメーションさせる石Viewに対応する棋譜配列
 @param orientation デバイスの傾き方向
 @param duration アニメーションにかかる時間
 */
-(void)animateStones:(NSMutableSet*)recordArray orientation:(UIDeviceOrientation)orientation duration:(float)duration;
@end


