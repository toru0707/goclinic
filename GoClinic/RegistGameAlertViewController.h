//
//  RegistGameAlertViewController.h
//  GoClinic
//
//  Created by 猪子 徹 on 11/05/30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RegistGameAlertViewControllerDelegate
-(void)touchRegistNewGameButton:(UIViewController*)viewController;
-(void)touchRegistExistedGameButton:(UIViewController*)viewController;
-(void)touchCancelButton:(UIViewController*)viewController;
@end

@interface RegistGameAlertViewController : UIViewController <UIAlertViewDelegate>{
    id<RegistGameAlertViewControllerDelegate> _delegate;
    UIViewController* _viewControllerClass;
    UIAlertView* _alertView;
}
@property(nonatomic, retain) UIAlertView* alertView;
@property(nonatomic, assign) id<RegistGameAlertViewControllerDelegate> delegate;
- (id)initWithClass:(UIViewController*)viewClass;
-(void)showAlertView;
@end
