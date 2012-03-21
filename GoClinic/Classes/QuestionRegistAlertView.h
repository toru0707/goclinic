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
	UIPickerView *_pickerView;
	int tableHeight;
	int tableExtHeight;
	
	Games* _selectedGame;
    int _selectedIndex;
	NSArray* _games;
    
    UITextView* _textView;
}

@property (nonatomic, retain) UIPickerView *pickerView;
@property (nonatomic, retain) UITextView *textView;

@end
