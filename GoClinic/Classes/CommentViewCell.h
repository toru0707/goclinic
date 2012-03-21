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
	IBOutlet UITextView* _commentTextView;
	IBOutlet UILabel* _pointLabel;
	IBOutlet UILabel* _categoryLabel;
}

@property(nonatomic, retain) UITextView* commentTextView;
@property(nonatomic, retain) UILabel* pointLabel;
@property(nonatomic, retain) UILabel* categoryLabel;
@end
