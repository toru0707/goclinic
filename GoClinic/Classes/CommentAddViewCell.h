//
//  CommentAddViewCell.h
//  GoClinic
//
//  Created by 猪子 徹 on 10/09/27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 コメント追加用のViewCell
 @auther inoko
 */
@interface CommentAddViewCell : UITableViewCell{
  IBOutlet UITextField* categoryTextField;  ///< プロパティ受け渡し用変数
  IBOutlet UITextField* pointTextField; ///< プロパティ受け渡し用変数
  IBOutlet UITextView* commentTextView;  ///< プロパティ受け渡し用変数
  IBOutlet UIButton* addButton; ///< プロパティ受け渡し用変数
}
@property(nonatomic, retain) UITextField* categoryTextField; ///<カテゴリ入力用TextFieldのアウトレットオブジェクト
@property(nonatomic, retain) UITextField* pointTextField; ///<ポイント入力用TextFieldのアウトレットオブジェクト
@property(nonatomic, retain) UITextView* commentTextView; ///<コメント入力用TextFieldのアウトレットオブジェクト
@property(nonatomic, retain) UIButton* addButton; ///<追加ボタンのアウトレットオブジェクト
@end


