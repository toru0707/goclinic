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

#define QUESTION_REGIST_PICKER_ALERT_VIEW_TAG 300 ///< ViewControllerを識別するためのタグ

@protocol QuestionRegistPickerAlertViewControllerDelegate
/**
PickerのRowが選択された時に呼び出されるメソッド
*/
-(void)selectedPickerIndex:(id)sender index:(int)index faceList:(NSMutableArray*)faceList facesCategoriesList:(NSMutableArray*)facesCategoriesList comment:(NSString*)comment;
@end


/**
 問題登録用のPickerAlertViewController
 @auther inoko
 */
@interface QuestionRegistPickerAlertViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UIAlertViewDelegate>  {
  id<QuestionRegistPickerAlertViewControllerDelegate> _delegate; ///< プロパティ受け渡し用変数
	QuestionRegistAlertView* _alertView; ///< プロパティ受け渡し用変数
  int _selectedIndex; ///<選択されたPickerのRowのIndex
  NSMutableArray* _facesList; ///<BOB顔の配列
  NSMutableArray* _facesCategoriesList; ///<BOB顔カテゴリの配列
  UIView* _oldView; ///<Pickerの一つ前に選択されたRowのView
  UIView* _selectedView; ///<Pickerの現在選択されているRowのView
}

@property (nonatomic, assign)id<QuestionRegistPickerAlertViewControllerDelegate> delegate; ///< デリゲートオブジェクト
@property (nonatomic, retain)QuestionRegistAlertView* alertView; ///< アラートView

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
