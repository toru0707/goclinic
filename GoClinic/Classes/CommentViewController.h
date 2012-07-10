//
//  CommentViewController.h
//  GoClinic
//
//  Created by 猪子 徹 on 10/10/30.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentViewCellController.h"
#import "CommentAddViewCellController.h"

#define COMMENT_VIEW_CONTROLLER_TAG 501 ///< ViewControllerを識別するためのタグ

@protocol CommentViewControllerDelegate
/**
 追加ボタンを押下した時に呼び出されるメソッド
*/
-(void)touchAddButton:(id)sender comment:(Comments*)comment;
@end

/**
 コメント表示用のViewController
 @auther inoko
 */
@interface CommentViewController : UITableViewController <CommentAddViewCellControllerDelegate>{
	id<CommentViewControllerDelegate> _delegate; ///< プロパティ受け渡し用変数
	NSMutableArray* _comments; ///< プロパティ受け渡し用変数
	NSMutableArray* _categories; ///< カテゴリが格納される配列
	CommentViewCellController* _commentViewCellController; ///< プロパティ受け渡し用変数
	CommentAddViewCellController* _commentAddViewCellController; ///< プロパティ受け渡し用変数
    
  int _insertMode; ///< 追加モードか否か
}
@property (nonatomic, assign) id<CommentViewControllerDelegate> delegate; ///< デリゲートオブジェクト
@property (nonatomic, retain) CommentViewCellController* commentViewCellController; ///< コメント表示用ViewCellControllerオブジェクト
@property (nonatomic, retain) CommentAddViewCellController* commentAddViewCellController; ///< コメント追加用ViewCellControllerオブジェクト
@property (nonatomic, retain) NSMutableArray* comments; ///< コメント配列

/**
 コンストラクタ
 */
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil mode:(int)mode;

@end
