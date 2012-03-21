//
//  QuestionShowViewController.h
//  GoClinic
//
//  Created by 猪子 徹 on 11/03/19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordShowViewController.h"


/**
 問題表示画面のViewController
 @auther inoko
 */
@interface QuestionShowViewController : RecordShowViewController {
}

/**
 問題まで戻るボタンをタッチした
 @param sender 問題まで戻るボタンオブジェクト
 */
-(IBAction) touchBackToQuestionButton:(id)sender;


/**
 変化図を表示ボタンをタッチした
 @param sender 変化図を表示ボタンオブジェクト
 */
-(IBAction) touchShowChangeChartButton:(id)sender;

/**
 比較ボタンをタッチした
 @param sender 比較ボタンオブジェクト
 */
-(IBAction) touchCompareButton:(id)sender;

/**
 ヒントボタンをタッチした
 @param sender 問題まで戻るボタンオブジェクト
 */
-(IBAction) touchHintButton:(id)sender;

/**
 問題まで戻るボタンをタッチした
 @param sender 問題まで戻るボタンオブジェクト
 */
-(IBAction) touchGiveUpButton:(id)sender;

@end
