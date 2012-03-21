//
//  QuestionPickerAlertViewController.h
//  GoClinic
//
//  Created by 猪子 徹 on 11/04/21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NormalPickerAlertViewController.h"


/**
 文字列選択の際、ハイライト機能を追加したPickerAlertViewController
 @auther inoko
 */
@interface BaseLabelPickerAlertViewController : NormalPickerAlertViewController {
    UIView* _oldView;
	UIView* _selectedView;
}

@end
