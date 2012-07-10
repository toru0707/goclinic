//
//  PickerAlertView.h
//  GoClinic
//
//  Created by 猪子 徹 on 10/11/14.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Games;

/**
 PickerViewが中に表示されているAlertView
 @auther inoko
 */
@interface PickerAlertView : UIAlertView {
	int tableHeight; ///<PickerViewの高さ
  int tableExtHeight; ///<PickerViewの高さ調整

	UIPickerView *_pickerView; ///< プロパティ受け渡し用変数
	Games* _selectedGame; ///< プロパティ受け渡し用変数
  int _selectedIndex; ///< プロパティ受け渡し用変数
	NSArray* _games; ///< プロパティ受け渡し用変数
}
@property (nonatomic, retain) UIPickerView *pickerView;///<PickerViewオブジェクト 
@property (nonatomic, retain)Games* selectedGame;///<PickerVieで選択されたGame
@property int selectedIndex;///<PickerViewで選択されたRowIndex
@property (nonatomic, retain)NSArray* games; ///<PickerViewに表示するGame配列

/**
 コンストラクタ
 @param title タイトル
 @param message メッサージ
 @param delegate デリゲート先
 @param dataSource データソース先
 @param cancelButtonTitle キャンセルボタンのタイトル
 @param okayButtonTitle OKボタンのタイトル
 @return PickerAlertViewオブジェクト
 */
- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate dataSource:(id)dataSource cancelButtonTitle:(NSString *)cancelButtonTitle okButtonTitle:(NSString *)okayButtonTitle;

@end
