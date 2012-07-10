//
//  QuestionRegistAlertView.h
//  GoClinic
//
//  Created by 猪子 徹 on 11/04/22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickerAlertView.h"

/**
 問題登録用AlertView
 @auther inoko
 */
@interface QuestionRegistAlertView : UIAlertView {
  int tableHeight; ///<AlertViewの高さ
  int tableExtHeight; ///<AlertViewの高さ調整
  Games* _selectedGame; ///<選択されたGames
  int _selectedIndex; ///<選択されたLowのIndex
  NSArray* _games; ///<表示するGames配列
    
	UIPickerView *_pickerView; ///< プロパティ受け渡し用変数
  UITextView* _textView; ///< プロパティ受け渡し用変数
}

@property (nonatomic, retain) UIPickerView* pickerView; ///<PickerViewのアウトレットオブジェクト
@property (nonatomic, retain) UITextView* textView; ///<TextViewのアウトレットオブジェクト
@end
