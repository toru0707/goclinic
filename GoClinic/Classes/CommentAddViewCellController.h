//
//  CommentAddViewCellController.h
//  GoClinic
//
//  Created by 猪子 徹 on 10/09/30.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryPickerAlertViewController.h"
#import "PointPickerAlertViewController.h"

@class CommentAddViewCell;
@class Comments;

@protocol CommentAddViewCellControllerDelegate
/**
 カテゴリ入力TextFieldをタッチしたときに呼び出されるメソッド
*/
-(void)touchCategoryTextField:(id)sender;

/**
 ポイントTextFieldをタッチしたときに呼び出されるメソッド
*/
-(void)touchPointTextField:(id)sender;

/**
 追加ボタンを押下した時に呼び出されるメソッド
*/
-(void)touchAddButton:(id)sender comment:(Comments*)comment;
@end

/**
 コメント登録用のViewCellController
 @auther inoko
 */
@interface CommentAddViewCellController : UIViewController <UITextFieldDelegate, PointPickerAlertViewControllerDelegate, CategoryPickerAlertViewControllerDelegate>{
	id<CommentAddViewCellControllerDelegate> _delegate; ///< プロパティ受け渡し用変数
	IBOutlet CommentAddViewCell* _cell; ///< プロパティ受け渡し用変数
    
	NSMutableArray* _categories; ///< カテゴリを格納する配列
}
@property(nonatomic, assign) id<CommentAddViewCellControllerDelegate> delegate; ///< デリゲートオブジェクト
@property(nonatomic, retain) CommentAddViewCell* cell; ///< TableViewCellのアウトレットオブジェクト

/**
 追加ボタンをタッチした
 @param sender 追加ボタンオブジェクト
 */
-(IBAction)touchAddButton:(id)sender;

/**
 点数テキストフィールドをタッチした
 @param sender 点数テキストフィールドオブジェクト
 */
-(IBAction)touchPointTextField:(id)sender;

/**
 カテゴリテキストフィールドをタッチした
 @param sender カテゴリテキストフィールドオブジェクト
 */
-(IBAction)touchCategoryTextField:(id)sender;
@end
