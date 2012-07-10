//
//  NormalShowViewController.h
//  GoClinic
//
//  Created by 猪子 徹 on 11/02/15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordShowViewController.h"

/**
 クリニック表示画面のViewController
 @auther inoko
 */
@interface NormalShowViewController : RecordShowViewController{
  id<GamePickerAlertViewControllerDelegate> _delegate; ///< デリゲートオブジェクト

  IBOutlet UITextField* _firstPlayerTextField; ///<先手ユーザのTextFieldのアウトレットオブジェクト
  IBOutlet UITextField* _secondPlayerTextField; ///<後手ユーザのTextFieldのアウトレットオブジェクト
  IBOutlet UILabel* _dateLabel; ///<日付ラベルのアウトレットオブジェクト
}

@end
