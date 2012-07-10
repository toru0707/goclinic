//
//  RegistGameAlertViewController.h
//  GoClinic
//
//  Created by 猪子 徹 on 11/05/30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RegistGameAlertViewControllerDelegate
/**
新規ゲーム登録ボタンを押下した時に呼び出されるメソッド
*/
-(void)touchRegistNewGameButton:(UIViewController*)viewController;
/**
既存のゲーム登録ボタンを押下した時に呼び出されるメソッド
*/
-(void)touchRegistExistedGameButton:(UIViewController*)viewController;
/**
キャンセルボタンを押下した時に呼び出されるメソッド
*/
-(void)touchCancelButton:(UIViewController*)viewController;
@end

/**
 Game保存時のAlertViewController
 
 @auther inoko
 */
@interface RegistGameAlertViewController : UIViewController <UIAlertViewDelegate>{
    id<RegistGameAlertViewControllerDelegate> _delegate; ///< プロパティ受け渡し用変数
    UIViewController* _viewControllerClass; ///< AlertViewのViewControllerオブジェクト
    UIAlertView* _alertView; ///< プロパティ受け渡し用変数
}
@property(nonatomic, retain) UIAlertView* alertView; ///< AlertViewオブジェクト
@property(nonatomic, assign) id<RegistGameAlertViewControllerDelegate> delegate; ///< デリゲートオブジェクト

/**
 *コンストラクタ
 */
-(id)initWithClass:(UIViewController*)viewClass;
/**
 *alertViewを表示する
 */
-(void)showAlertView;
@end
