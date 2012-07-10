//
//  SaveGameAlertViewController.h
//  GoClinic
//
//  Created by 猪子 徹 on 11/05/31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SaveGameAlertViewControllerDelegate
/**
Saveボタンを押下した時に呼び出されるメソッド
*/
-(void)touchSaveGameButton:(UIViewController*)viewController;
/**
保存しないボタンを押下した時に呼び出されるメソッド
*/
-(void)touchNotSaveGameButton:(UIViewController*)viewController;
/**
キャンセルボタンを押下した時に呼び出されるメソッド
*/
-(void)touchCancelSaveGameButton:(UIViewController*)viewController;
@end

/**
 Game保存時のAlertViewController
 
 @auther inoko
 */
@interface SaveGameAlertViewController : UIViewController <UIAlertViewDelegate>{
    id<SaveGameAlertViewControllerDelegate> _delegate; ///< プロパティ受け渡し用変数
    UIViewController* _viewController; ///< ViewControllerオブジェクト
    UIAlertView* _alertView; ///< プロパティ受け渡し用変数
}
@property(nonatomic, retain) UIAlertView* alertView; ///< AlertViewオブジェクト
@property(nonatomic, assign) id<SaveGameAlertViewControllerDelegate> delegate; ///< デリゲートオブジェクト

/**
 *コンストラクタ
 */
-(id)initWithClass:(UIViewController*)viewClass;
/**
 *alertビューを表示する
 */
-(void)showAlertView;
@end
