//
//  CommentViewCell.m
//  GoClinic
//
//  Created by 猪子 徹 on 10/09/27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CommentViewCell.h"


@implementation CommentViewCell

@synthesize commentTextView = _commentTextView;
@synthesize categoryLabel = _categoryLabel;
@synthesize pointLabel = _pointLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (void)dealloc {
	[_commentTextView setDelegate:nil];	[_commentTextView release];
	[_categoryLabel release];
	[_pointLabel release];
    [super dealloc];
}


@end
