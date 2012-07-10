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
/**
 指定された座標に碁石を配置したときに呼び出されるメソッド
 */
-(void) putGoStone:(GoStoneView *)stoneView x:(int)x y:(int)y;

/**
 盤面をタッチしたときに呼び出されるメソッド
 */
-(void) touchBoard:(UITouch *)theTouch withView:(UIView *)view;

/**
 碁石をタッチした後に呼び出されるメソッド
 */
-(void) touchBeganBoardWithStone:(UITouch *)theTouch withEvent:(UIEvent *)event withGoStoneView:(GoStoneView *)stoneView;

/**
 碁石をタッチした後に指を離した時に呼び出されるメソッド
 */
-(void) touchEndedBoardWithStone:(UITouch *)theTouch withEvent:(UIEvent *)event withGoStoneView:(GoStoneView *)stoneView;

/**
 指定した場所に碁石が配置可能か判定した後に呼び出されるメソッド
 */
-(int)  checkPutGoStone:(NSSet *)theTouch withEvent:(UIEvent *)event withGoStoneView:(GoStoneView *)stoneView;

/**
 碁石を移動させた後に呼び出されるメソッド
 */
-(void) moveGoStone:(GoStoneView *)stoneView toRect:(CGRect)toRect;

/**
 碁石のコンテキストメニューをタッチしたときに呼び出されるメソッド
 */
-(void) touchForMenuWithStone:(UITouch *)theTouch withEvent:(UIEvent*)event withGoStoneView:(GoStoneView *)stoneView;

/**
 碁石のコンテキストメニューのタッチをキャンセルされたときに呼び出されるメソッド
 */
-(void) touchForMenuCancelWithStone:(GoStoneView*)stoneView;
@end

/**
 盤面のView
 @auther inoko
 */
@interface BoardView : AnimationView <GoStoneViewDelegate>{
	id<BoardViewDelegate> _delegate; ///< プロパティ受け渡し用変数
	BOOL _isStarDrawn; ///< プロパティ受け渡し用変数
	BOOL _isXYScaleDrawn; ///< プロパティ受け渡し用変数
	BOOL _isStoneMobed; ///< プロパティ受け渡し用変数
	int _xSize; ///< プロパティ受け渡し用変数
	int _ySize; ///< プロパティ受け渡し用変数
  Boolean _redrawBoard; ///<盤面を再描画したか
  GameRecords* _currentSelection; ///<現在選択されている碁石
}
@property (nonatomic, assign) id<BoardViewDelegate> delegate ; ///<デリゲートオブジェクト
@property BOOL isStarDrawn; ///<星が描画されているか
@property BOOL isXYScaleDrawn; ///<XYの数字が描画されているか
@property int xSize; ///<X座標の目数
@property int ySize; ///<Y座標の目数
@property (nonatomic, retain) NSMutableArray* stones; ///<碁石を格納している配列

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


