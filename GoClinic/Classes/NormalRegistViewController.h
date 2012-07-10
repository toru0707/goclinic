//
//  NormalRegistViewController.h
//  GoClinic
//
//  Created by 猪子 徹 on 11/02/15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordRegistViewController.h"
#import "NormalLabelPickerAlertViewController.h"
#import "OkiishiPickerAlertViewController.h"
#import "GameRecords.h"
#import "GamesPickerAlertViewController.h"
#import "RegistGameAlertViewController.h"
#import "SaveGameAlertViewController.h"
#import "InputGameNameAlertViewController.h"

/**
 クリニック登録画面のViewController
 @auther inoko
 */
@interface NormalRegistViewController : RecordRegistViewController <OkiishiPickerAlertViewControllerDelegate>{
  IBOutlet UITextField* _okiishiTextField; ///<置き石TextFieldのアウトレットオブジェクト
  IBOutlet UITextField* _firstPlayerTextField; ///<先手ユーザTextFieldのアウトレットオブジェクト
  IBOutlet UITextField* _secondPlayerTextField; ///<後手ユーザのTextFieldのアウトレットオブジェクト
  IBOutlet UITextField* _dateLabel; ///<日付ラベルのアウトレットオブジェクト
  NSMutableArray* _okiishiArray; ///<置き石が格納される配列
  
}


/**
 置石TextFieldがタッチされた
 @param sender 置石TextFieldオブジェクト
 */
-(IBAction)touchOkiishiTextField:(id)sender;
@end
