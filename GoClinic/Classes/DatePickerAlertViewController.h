//
//  DatePickerAlertViewController.h
//  GoClinic
//
//  Created by 猪子 徹 on 11/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatePickerAlertView.h"

@protocol DatePickerAlertViewControllerDelegate
/**
Rowが選択されたときに呼び出されるメソッド
*/
-(void)selectDate:(id)sender selectedDate:(NSDate*)date;
@end

/**
 日付選択用のAlertViewController（ハイライト有り）

 @auther inoko
 */
@interface DatePickerAlertViewController : UIViewController <  UIAlertViewDelegate>{
	id<DatePickerAlertViewControllerDelegate> _delegate; ///< プロパティ受け渡し用変数
	DatePickerAlertView* _alertView; ///< プロパティ受け渡し用変数
	UIView* _oldView; ///< 一つ前に選択されたRowのView
	UIView* _selectedView; ///< 現在選択されているRowのVieｗ
}
@property (nonatomic, assign)id<DatePickerAlertViewControllerDelegate> delegate; ///< デリゲートオブジェクト
@property (nonatomic, retain)DatePickerAlertView* alertView; ///< アラートVieｗ

/**
 コンストラクタ
 @param title タイトル
 @param message メッサージ
 @param cancelButtonTitle キャンセルボタンのタイトル
 @param okayButtonTitle OKボタンのタイトル
 @return DatePickerAlertViewControllerオブジェクト
 */
- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle okButtonTitle:(NSString *)okayButtonTitle;

@end
