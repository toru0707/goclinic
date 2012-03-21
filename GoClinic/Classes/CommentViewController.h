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

#define COMMENT_VIEW_CONTROLLER_TAG 501

@protocol CommentViewControllerDelegate
-(void)touchAddButton:(id)sender comment:(Comments*)comment;
@end

/**
 コメント表示用のViewController
 @auther inoko
 */
@interface CommentViewController : UITableViewController <CommentAddViewCellControllerDelegate>{
	id<CommentViewControllerDelegate> _delegate;
	NSMutableArray* _comments;
	NSMutableArray* _categories;
	CommentViewCellController* _commentViewCellController;
	CommentAddViewCellController* _commentAddViewCellController;
    
    int _insertMode;
}
@property (nonatomic, assign) id<CommentViewControllerDelegate> delegate;
@property (nonatomic, retain) CommentViewCellController* commentViewCellController;
@property (nonatomic, retain) CommentAddViewCellController* commentAddViewCellController;
@property (nonatomic, retain) NSMutableArray* comments;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil mode:(int)mode;

@end
