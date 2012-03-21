//
//  QuestionRegistViewController.h
//  GoClinic
//
//  Created by 猪子 徹 on 11/03/19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordRegistViewController.h"
#import "FacesWithNoLabelViewController.h"
#import "QuestionRegistPickerAlertViewController.h"
#import "QuestionViewControllerState.h"

/**
 問題登録画面のViewController
 @auther inoko
 */
@interface QuestionRegistViewController : RecordRegistViewController <FacesWithNoLabelViewControllerDelegate, QuestionRegistPickerAlertViewControllerDelegate>{
    IBOutlet UIButton* _registAnswerButton;
    QuestionViewControllerState* _state;
}


-(void)changeState:(QuestionViewControllerState*)state;

/**
 問題登録ボタンをタッチする
 @param sender 問題登録ボタンオブジェクト
 */
-(IBAction) touchRegistQuestionStatementButton:(id)sender;


/**
 解答登録ボタンをタッチする
 @param sender 解答登録ボタンオブジェクト
 */
-(IBAction) touchRegistAnswerButton:(id)sender;
@end
