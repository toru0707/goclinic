//
//  TextAlertView.h
//  GoClinic
//
//  Created by 猪子 徹 on 11/01/05.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kUITextFieldHeight 30.0
#define kUITextFieldWidth 260.0
#define kUITextFieldXPadding 12.0
#define kUITextFieldYPadding 10.0
#define kUIAlertOffset 10.0

/**
 TextFieldが表示されたAlertView
 @auther inoko
 */
@interface TextAlertView : UIAlertView {
	UITextField *textField;
	int tableExtHeight;
	BOOL layoutDone;
}

@property (nonatomic, retain) UITextField *textField;

/**
 コンストラクタ
 @param title タイトル
 @param message メッサージ
 @param delegate デリゲート先
 @param cancelButtonTitle キャンセルボタンのタイトル
 @param otherButtonTitles 他のボタンのタイトル
 @return TextAlertViewオブジェクト
 */
- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate 
  cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;

@end