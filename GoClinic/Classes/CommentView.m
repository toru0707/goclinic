//
//  CommentView.m
//  GoClinic
//
//  Created by 猪子 徹 on 10/09/27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CommentView.h"
#import "CommentAddViewCell.h"

@implementation CommentView
@synthesize commentViewCell;
@synthesize commentAddViewCell;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

- (void)dealloc {
	[commentViewCell release];
	[commentAddViewCell release];
    [super dealloc];
}


@end
