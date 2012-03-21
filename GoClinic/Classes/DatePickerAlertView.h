//
//  DatePickerAlertView.h
//  GoClinic
//
//  Created by 猪子 徹 on 11/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 日付選択用のPickerAlertView
 @auther inoko
 */
@interface DatePickerAlertView : UIAlertView {
	UIDatePicker *_pickerView;
	int tableHeight;
	int tableExtHeight;
	
	NSDate* _selectedDate;
}

@property (nonatomic, retain)NSDate* selectedDate;
@property (nonatomic, retain) UIDatePicker *pickerView;

/**
 コンストラクタ
 @param title タイトル
 @param message メッサージ
 @param delegate デリゲート先
 @param dataSource データソース先
 @param cancelButtonTitle キャンセルボタンのタイトル
 @param okayButtonTitle OKボタンのタイトル
 @return DatePickerAlertViewオブジェクト
 */
- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate dataSource:(id)dataSource cancelButtonTitle:(NSString *)cancelButtonTitle okButtonTitle:(NSString *)okayButtonTitle;

@end
