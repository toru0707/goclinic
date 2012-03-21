//
//  CategoryPickerAlertViewController.h
//  GoClinic
//
//  Created by 猪子 徹 on 11/04/20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseLabelPickerAlertViewController.h"

@protocol CategoryPickerAlertViewControllerDelegate
-(void)selectCategory:(id)sender selectedIndex:(int)selectedIndex category:(NSString*)category;
@end

/**
 コメントカテゴリ選択用のPickerAlertViewController（ハイライト有り）
 @auther inoko
 */
@interface CategoryPickerAlertViewController : BaseLabelPickerAlertViewController  {
    id<CategoryPickerAlertViewControllerDelegate> _delegate;
}
@property (nonatomic, assign)id<CategoryPickerAlertViewControllerDelegate> delegate;

@end
