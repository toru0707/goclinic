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
-(void)selectDate:(id)sender selectedDate:(NSDate*)date;
@end

/**
 日付選択用のPickerAlertViewController（ハイライト有り）
 @auther inoko
 */
@interface DatePickerAlertViewController : UIViewController <  UIAlertViewDelegate>{
	id<DatePickerAlertViewControllerDelegate> _delegate;
	DatePickerAlertView* _alertView;
	UIView* _oldView;
	UIView* _selectedView;
}
@property (nonatomic, assign)id<DatePickerAlertViewControllerDelegate> delegate;
@property (nonatomic, retain)DatePickerAlertView* alertView;

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
