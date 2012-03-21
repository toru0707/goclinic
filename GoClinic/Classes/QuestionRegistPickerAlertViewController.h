//
//  QuestionRegistPickerAlertViewController.h
//  GoClinic
//
//  Created by 猪子 徹 on 11/04/24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionRegistAlertView.h"
#import "QuestionRegistPickerAlertViewController.h"

#define QUESTION_REGIST_PICKER_ALERT_VIEW_TAG 300

@protocol QuestionRegistPickerAlertViewControllerDelegate
-(void)selectedPickerIndex:(id)sender index:(int)index faceList:(NSMutableArray*)faceList facesCategoriesList:(NSMutableArray*)facesCategoriesList comment:(NSString*)comment;
@end


/**
 問題登録用のPickerAlertViewController
 @auther inoko
 */
@interface QuestionRegistPickerAlertViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UIAlertViewDelegate>  {
    id<QuestionRegistPickerAlertViewControllerDelegate> _delegate;
	QuestionRegistAlertView* _alertView;
    int _selectedIndex;
    NSMutableArray* _facesList;
    NSMutableArray* _facesCategoriesList;
    
    UIView* _oldView;
	UIView* _selectedView;
}

@property (nonatomic, assign)id<QuestionRegistPickerAlertViewControllerDelegate> delegate;
@property (nonatomic, retain)QuestionRegistAlertView* alertView;

/**
 コンストラクタ
 @param title タイトル
 @param message メッサージ
 @param cancelButtonTitle キャンセルボタンのタイトル
 @param okayButtonTitle OKボタンのタイトル
 @param facesList PickerViewに表示されるBOB顔のリスト
 @param facesCategoriesList PickerViewに表示されるBOB顔カテゴリのリスト
 @return QuestionRegistPickerAlertViewControllerオブジェクト
 */
- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle okButtonTitle:(NSString *)okayButtonTitle facesList:(NSArray*)facesList facesCategoriesList:(NSArray*)facesCategoriesList;

/**
 AlertViewを表示する
 */
- (void)showAlertView;

@end
