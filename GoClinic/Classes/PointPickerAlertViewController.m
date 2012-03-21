//
//  PointPickerAlertViewController.m
//  GoClinic
//
//  Created by 猪子 徹 on 11/04/20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PointPickerAlertViewController.h"


@implementation PointPickerAlertViewController
@synthesize delegate = _delegate;


/***************************************************************************************
 UIAlertViewDelegate 関連：
 ***************************************************************************************/

- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {  
	SEL sel;
    switch (buttonIndex) {
		case 0:
			break;
		case 1:
			sel = @selector(selectPoint:selectedIndex:point:);
			id delegate = self.delegate;
			if(delegate && [delegate respondsToSelector:sel]){
				[delegate selectPoint:self selectedIndex:_selectedIndex point:[(NSString*)[_pickerList objectAtIndex:_selectedIndex] intValue]];
			}
			break;
		default:
			break;
	}
}  



@end
