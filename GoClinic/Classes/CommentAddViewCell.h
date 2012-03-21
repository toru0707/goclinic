//
//  CommentAddViewCell.h
//  GoClinic
//
//  Created by 猪子 徹 on 10/09/27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 コメント追加用のVieCell
 @auther inoko
 */
@interface CommentAddViewCell : UITableViewCell{
	IBOutlet UITextField* categoryTextField;
	IBOutlet UITextField* pointTextField;
	IBOutlet UITextView* commentTextView;
	IBOutlet UIButton* addButton;
}

@property(nonatomic, retain) UITextField* categoryTextField;
@property(nonatomic, retain) UITextField* pointTextField;
@property(nonatomic, retain) UITextView* commentTextView;
@property(nonatomic, retain) UIButton* addButton;


@end


