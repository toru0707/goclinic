//
//  TsumegoShowViewController.h
//  GoClinic
//
//  Created by 猪子 徹 on 11/01/27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordShowViewController.h"
#import "TsumegoGameState.h"

/**
 詰碁表示画面のViewController
 @auther inoko
 */
@interface TsumegoShowViewController : RecordShowViewController {
	IBOutlet UIButton* _showAnswerButton; ///< 回答表示ボタンのアウトレットオブジェクト
  IBOutlet UILabel* _questionLabel; ///< 問題ラベルのアウトレットオブジェクト
  TsumegoGameState* _state; ///< 状態オブジェクト
}


/**
 解答表示ボタンがタッチされた
 @param sender 解答表示ボタンオブジェクト
 */
-(IBAction) touchShowAnswerButton:(id)sender;

/**
 ヒントボタンがタッチされた
 @param sender ヒントボタンオブジェクト
 */

-(IBAction) touchHintButton:(id)sender;

/**
 ギブアップボタンがタッチされた
 @param sender ギブアップボタンオブジェクト
 */
-(IBAction) touchGiveUpButton:(id)sender;


@end
