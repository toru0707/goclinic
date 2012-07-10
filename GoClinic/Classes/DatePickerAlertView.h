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
	UIDatePicker *_pickerView; ///< プロパティ受け渡し用変数
	int tableHeight; ///< Pickerの高さ
	int tableExtHeight; ///< Pickerの高さ調整
	NSDate* _selectedDate; ///< プロパティ受け渡し用変数
}

@property (nonatomic, retain)NSDate* selectedDate; ///< 選択された日付
@property (nonatomic, retain) UIDatePicker *pickerView; ///< PickerのView

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
