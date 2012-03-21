//
//  SaveGameAlertViewController.h
//  GoClinic
//
//  Created by 猪子 徹 on 11/05/31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SaveGameAlertViewControllerDelegate
-(void)touchSaveGameButton:(UIViewController*)viewController;
-(void)touchNotSaveGameButton:(UIViewController*)viewController;
-(void)touchCancelSaveGameButton:(UIViewController*)viewController;
@end

@interface SaveGameAlertViewController : UIViewController <UIAlertViewDelegate>{
    id<SaveGameAlertViewControllerDelegate> _delegate;
    UIViewController* _viewController;
    UIAlertView* _alertView;
}
@property(nonatomic, retain) UIAlertView* alertView;
@property(nonatomic, assign) id<SaveGameAlertViewControllerDelegate> delegate;
- (id)initWithClass:(UIViewController*)viewClass;
-(void)showAlertView;
@end
