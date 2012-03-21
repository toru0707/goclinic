//
//  RightButtonViewCell.m
//  GoClinic
//
//  Created by 猪子 徹 on 10/09/27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FacesViewCell.h"


@implementation FacesViewCell

@synthesize buttonImgView;
@synthesize buttonText;

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
	//画像はリリースしない
	[buttonImgView release]; 
	[buttonText release];
    [super dealloc];
}


@end
