//
//  QuestionGameState.h
//  GoClinic
//
//  Created by 猪子 徹 on 11/06/08.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuestionGames.h"
@class Games;
@class GoStoneView;
@class GameRecords;

/**
 問題モード用ViewControllerに共通した処理を提供するStateクラス
 @auther inoko
 */
@interface QuestionGameState : NSObject {
    QuestionGames* _game; ///< 現在のゲームオブジェクト
}

/**
 *コンストラクタ
 */
-(id)initWithGames:(Games*)game;
/**
 *指定されたXY座標で碁石を作成する
 */
-(GameRecords*)createNewRecord:(int)x y:(int)y goStoneView:(GoStoneView*)view;
@end
