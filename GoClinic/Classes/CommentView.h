//
//  CommentView.h
//  GoClinic
//
//  Created by 猪子 徹 on 10/09/27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnimationTableView.h"
@class CommentViewCell;
@class CommentAddViewCell;

/**
 コメント表示用のView
 @auther inoko
 */
@interface CommentView : AnimationTableView {
	IBOutlet CommentViewCell* commentViewCell; ///< プロパティ受け渡し用変数
	IBOutlet CommentAddViewCell* commentAddViewCell; ///< プロパティ受け渡し用変数
}

@property(nonatomic, retain) CommentViewCell* commentViewCell; ///< コメントTableViewCellのアウトレットオブジェクト
@property(nonatomic, retain) CommentAddViewCell* commentAddViewCell; ///< コメント追加TableViewCellのアウトレットオブジェクト


@end
