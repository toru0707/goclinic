//
//  QustionViewControllerState.h
//  GoClinic
//
//  Created by 猪子 徹 on 11/06/12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecordRegistViewController.h"

/**
 問題画面のViewControllerのStateクラスの基底クラス
 
 @auther inoko
 */
@interface QuestionViewControllerState : NSObject {
  RecordRegistViewController* _controller; ///< 碁石登録用ViewControllerオブジェクト
}

/**
 *コンストラクタ
 */
-(id)initWithViewController:(RecordRegistViewController*)controller;
/**
 * 碁石を配置した後に碁石Viewを表示する
 */
-(void)showGoStoneViewAfterPutGoStone:(GameRecords*)record;
@end
