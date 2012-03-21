//
//  NormalPickerAlertViewController.h
//  GoClinic
//
//  Created by 猪子 徹 on 11/04/21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickerAlertView.h"

#define PICKER_ALERT_VIEW_COMPONENT_NUM 1

/**
 文字列選択用のPickerAlertViewController
 @auther inoko
 */
@interface NormalPickerAlertViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UIAlertViewDelegate> {
	PickerAlertView* _alertView;
    int _selectedIndex;
    NSMutableArray* _pickerList;
}
@property (nonatomic, retain)PickerAlertView* alertView;

/**
 コンストラクタ
 @param title タイトル
 @param message メッサージ
 @param cancelButtonTitle キャンセルボタンのタイトル
 @param okayButtonTitle OKボタンのタイトル
 @param pickerList PickerViewに表示される文字列のリスト
 @return NormalPickerAlertViewControllerオブジェクト
 */
- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle okButtonTitle:(NSString *)okayButtonTitle pickerList:(NSMutableArray*)pickerList;

/**
 AlertViewを表示する
 */
- (void)showAlertView;
@end
