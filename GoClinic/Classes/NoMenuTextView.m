//
//  NoMenuTextView.m
//  GoClinic
//
//  Created by 猪子 徹 on 10/12/19.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NoMenuTextView.h"

@implementation NoMenuTextView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
    return self;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender    
{    
	[UIMenuController sharedMenuController].menuVisible = NO;  //do not display the menu
	[self resignFirstResponder];                      //do not allow the user to selected anything
	return NO;
}

- (void)dealloc {
    [super dealloc];
}


@end
