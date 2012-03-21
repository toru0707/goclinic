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
	IBOutlet CommentViewCell* commentViewCell;
	IBOutlet CommentAddViewCell* commentAddViewCell;
}

@property(nonatomic, retain) CommentViewCell* commentViewCell;
@property(nonatomic, retain) CommentAddViewCell* commentAddViewCell;


@end
