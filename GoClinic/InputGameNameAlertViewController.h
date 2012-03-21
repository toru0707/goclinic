//
//  InputGameNameAlertViewController.h
//  GoClinic
//
//  Created by 猪子 徹 on 11/05/31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextAlertView.h"

@protocol InputGameNameAlertViewControllerDelegate
-(void)touchSaveOkButton:(UIViewController*)viewController fileName:(NSString*)fileName;
-(void)touchCancelSaveButton:(UIViewController*)viewController;
@end

@interface InputGameNameAlertViewController : UIViewController<UIAlertViewDelegate> {
    id<InputGameNameAlertViewControllerDelegate> _delegate;
    UIViewController* _viewController;
    TextAlertView* _alertView;
}
@property(nonatomic, retain) TextAlertView* alertView;
@property(nonatomic, assign) id<InputGameNameAlertViewControllerDelegate> delegate;
- (id)initWithClass:(UIViewController*)viewController;
-(void)showAlertView;
@end
