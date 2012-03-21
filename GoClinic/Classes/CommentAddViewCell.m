//
//  CommentAddViewCell.m
//  GoClinic
//
//  Created by 猪子 徹 on 10/09/27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CommentAddViewCell.h"

@implementation CommentAddViewCell

@synthesize categoryTextField;
@synthesize pointTextField;
@synthesize commentTextView;
@synthesize addButton;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

- (void)dealloc {
	[categoryTextField setDelegate:nil];	[categoryTextField release];
	[pointTextField setDelegate:nil];	[pointTextField release];
	[commentTextView setDelegate:nil];	[commentTextView release];
	[addButton release];
    [super dealloc];
}


@end
