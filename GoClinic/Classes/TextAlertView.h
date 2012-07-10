//
//  TextAlertView.h
//  GoClinic
//
//  Created by 猪子 徹 on 11/01/05.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kUITextFieldHeight 30.0 ///< Viewサイズ調整用パラメータ 
#define kUITextFieldWidth 260.0 ///< Viewサイズ調整用パラメータ 
#define kUITextFieldXPadding 12.0 ///< Viewサイズ調整用パラメータ 
#define kUITextFieldYPadding 10.0 ///< Viewサイズ調整用パラメータ 
#define kUIAlertOffset 10.0 ///< Viewサイズ調整用パラメータ 

/**
 TextFieldが表示されたAlertView
 
 @auther inoko
 */
@interface TextAlertView : UIAlertView {
	UITextField *textField;
	int tableExtHeight; ///< AlertViewの高さ調整
	BOOL layoutDone; ///< AlertViewのレイアウト描画が終了したか
}

@property (nonatomic, retain) UITextField *textField; ///< TextFieldのアウトレットオブジェクト

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
