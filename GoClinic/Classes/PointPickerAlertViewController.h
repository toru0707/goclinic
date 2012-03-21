//
//  PointPickerAlertViewController.h
//  GoClinic
//
//  Created by 猪子 徹 on 11/04/20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseLabelPickerAlertViewController.h"

#define DEFAULT_POINT_DISTANCE 5
#define DEFAULT_POINT_MAX 100

@protocol PointPickerAlertViewControllerDelegate
-(void)selectPoint:(id)sender selectedIndex:(int)selectedIndex point:(int)point;
@end

/**
 点数選択用のPickerAlertViewController（ハイライト有り）
 @auther inoko
 */
@interface PointPickerAlertViewController :  BaseLabelPickerAlertViewController {
    id<PointPickerAlertViewControllerDelegate> _delegate;
}
@property (nonatomic, assign)id<PointPickerAlertViewControllerDelegate> delegate;

@end
