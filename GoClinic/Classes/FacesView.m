//
//  RightButtonView.m
//  GoClinic
//
//  Created by 猪子 徹 on 10/09/27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FacesView.h"
#import "FacesViewCell.h"

@implementation FacesView

@synthesize cell = _cell;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

- (void)dealloc {
	[_cell release];
    [super dealloc];
}


@end
