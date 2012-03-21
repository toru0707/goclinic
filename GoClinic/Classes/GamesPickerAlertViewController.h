//
//  GamesPickerAlertViewController.h
//  GoClinic
//
//  Created by 猪子 徹 on 11/05/03.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseLabelPickerAlertViewController.h"
#import "Games.h"

@protocol GamePickerAlertViewControllerDelegate
-(void)selectedGamePickerIndex:(id)sender index:(int)index game:(Games*)game viewController:(UIViewController*)viewController;
@end


/**
 既存のゲーム選択用のPickerAlertViewController（選択時ハイライト有り）
 @auther inoko
 */
@interface GamesPickerAlertViewController : BaseLabelPickerAlertViewController {
    id<GamePickerAlertViewControllerDelegate> _delegate;    
    NSMutableArray* _games;
    UIViewController* _viewController;
}
@property (nonatomic, assign)id<GamePickerAlertViewControllerDelegate> delegate;

- (id)initWithTitle:(NSMutableArray *)pickerList viewController:(UIViewController*)viewController;

@end
