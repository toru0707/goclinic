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
-(void)touchCategoryTextField:(id)sender;
-(void)touchPointTextField:(id)sender;
-(void)touchAddButton:(id)sender comment:(Comments*)comment;
@end

/**
 コメント登録用のViewCellController
 @auther inoko
 */
@interface CommentAddViewCellController : UIViewController <UITextFieldDelegate, PointPickerAlertViewControllerDelegate, CategoryPickerAlertViewControllerDelegate>{
	id<CommentAddViewCellControllerDelegate> _delegate;
	IBOutlet CommentAddViewCell* _cell;
    
	NSMutableArray* _categories;
}
@property(nonatomic, assign) id<CommentAddViewCellControllerDelegate> delegate;
@property(nonatomic, retain) CommentAddViewCell* cell;

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
