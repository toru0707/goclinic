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
/**
Saveボタンを押下した時に呼び出されるメソッド
*/
-(void)touchSaveOkButton:(UIViewController*)viewController fileName:(NSString*)fileName;

/**
キャンセルボタンを押下した時に呼び出されるメソッド
*/
-(void)touchCancelSaveButton:(UIViewController*)viewController;
@end

/**
 Game保存時にGame名を入力するAlertViewController
 
 @auther inoko
 */
@interface InputGameNameAlertViewController : UIViewController<UIAlertViewDelegate> {
  UIViewController* _viewController; ///< ViewControllerオブジェクト
  id<InputGameNameAlertViewControllerDelegate> _delegate; ///< プロパティ受け渡し用変数
  TextAlertView* _alertView; ///< プロパティ受け渡し用変数
}
@property(nonatomic, retain) TextAlertView* alertView; ///< AlertViewオブジェクト
@property(nonatomic, assign) id<InputGameNameAlertViewControllerDelegate> delegate; ///< デリゲートオブジェクト

/**
コンストラクタ
*/
- (id)initWithClass:(UIViewController*)viewController;

/**
alertビューを表示する
*/
-(void)showAlertView;
@end
