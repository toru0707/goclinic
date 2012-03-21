//
//  TsumegoViewController.h
//  GoClinic
//
//  Created by 猪子 徹 on 11/01/22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordRegistViewController.h"
#import "QuestionRegistPickerAlertViewController.h"
#import "TsumegoGameState.h"

/**
 詰碁登録画面のViewController
 @auther inoko
 */
@interface TsumegoRegistViewController : RecordRegistViewController <QuestionRegistPickerAlertViewControllerDelegate>{
	IBOutlet UISegmentedControl* _userSegmentedControl;
	IBOutlet UIButton* _registAnswerButton;
    TsumegoGameState* _state;
}

@property (nonatomic, retain) UISegmentedControl* userSegmentedControl;
@property (nonatomic, retain) UIButton* registAnswerButton;

/**
 問題登録ボタンがタッチされた
 @param sender 問題登録ボタンオブジェクト
 */
-(IBAction)touchRegistQuestionStatementButton:(id)sender;

/**
 解答登録ボタンがタッチされた
 @param sender 解答登録ボタンオブジェクト
 */

-(IBAction)touchRegistAnswerButton:(id)sender;

/**
 黒白切り替えスイッチがタッチされた
 @param sender 黒白切り替えスイッチオブジェクト
 */
-(IBAction)touchChangeStoneColorSegmentedControl:(id)sender;
@end
