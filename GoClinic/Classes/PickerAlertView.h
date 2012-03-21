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
	UIPickerView *_pickerView;
	int tableHeight;
	int tableExtHeight;
	
	Games* _selectedGame;
    int _selectedIndex;
	NSArray* _games;
}

@property (nonatomic, retain)Games* selectedGame;
@property int selectedIndex;
@property (nonatomic, retain)NSArray* games;
@property (nonatomic, retain) UIPickerView *pickerView;

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
