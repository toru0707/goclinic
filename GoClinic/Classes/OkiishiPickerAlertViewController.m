//
//  OkiishiPickerAlertViewController.m
//  GoClinic
//
//  Created by 猪子 徹 on 11/04/18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OkiishiPickerAlertViewController.h"


@implementation OkiishiPickerAlertViewController

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
			sel = @selector(selectNumOfOkiishi:selectedNum:);
			id delegate = self.delegate;
			if(delegate && [delegate respondsToSelector:sel]){
				[delegate selectNumOfOkiishi:self selectedNum:[(NSString*)[_pickerList objectAtIndex:_selectedIndex] intValue]];
			}
			break;
		default:
			break;
	}
}  


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}


@end
