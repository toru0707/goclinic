//
//  CommentViewCell.h
//  GoClinic
//
//  Created by 猪子 徹 on 10/09/27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 コメント表示用のViewCell
 @auther inoko
 */
@interface CommentViewCell : UITableViewCell {
	IBOutlet UITextView* _commentTextView; ///< プロパティ受け渡し用変数
	IBOutlet UILabel* _pointLabel; ///< プロパティ受け渡し用変数
	IBOutlet UILabel* _categoryLabel; ///< プロパティ受け渡し用変数
}

@property(nonatomic, retain) UITextView* commentTextView; ///< コメント表示Viewのアウトレットオブジェクト
@property(nonatomic, retain) UILabel* pointLabel; ///< ポイントラベルのアウトレットオブジェクト
@property(nonatomic, retain) UILabel* categoryLabel; ///< カテゴリラベルのアウトレットオブジェクト
@end
