//
//  CategoryPickerAlertViewController.m
//  GoClinic
//
//  Created by 猪子 徹 on 11/04/20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CategoryPickerAlertViewController.h"


@implementation CategoryPickerAlertViewController

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
			sel = @selector(selectCategory:selectedIndex:category:);
			id delegate = self.delegate;
			if(delegate && [delegate respondsToSelector:sel]){
				[delegate selectCategory:self selectedIndex:_selectedIndex category:(NSString*)[_pickerList objectAtIndex:_selectedIndex]];
			}
			break;
		default:
			break;
	}
}  



@end
