//
//  CommentViewCellController.h
//  GoClinic
//
//  Created by 猪子 徹 on 10/09/30.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CommentViewCell;

/**
 コメント表示用のViewCellController
 @auther inoko
 */
@interface CommentViewCellController : UIViewController {
	IBOutlet CommentViewCell* cell;
}
@property(nonatomic, retain) CommentViewCell* cell;

@end
