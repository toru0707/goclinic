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
    id<GamePickerAlertViewControllerDelegate> _delegate;
	IBOutlet UITextField* _firstPlayerTextField;
	IBOutlet UITextField* _secondPlayerTextField;
	IBOutlet UILabel* _dateLabel;
}

@end
