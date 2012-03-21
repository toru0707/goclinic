    //
//  DatePickerAlertViewController.m
//  GoClinic
//
//  Created by 猪子 徹 on 11/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DatePickerAlertViewController.h"
#import "DatePickerAlertView.h"

@implementation DatePickerAlertViewController
@synthesize delegate = _delegate;
@synthesize alertView = _alertView;

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle okButtonTitle:(NSString *)okayButtonTitle{
	if((self = [super init])){
		DatePickerAlertView* picker = [[DatePickerAlertView alloc] initWithTitle:title
																 message:message delegate:self dataSource:self cancelButtonTitle:cancelButtonTitle okButtonTitle:okayButtonTitle];		
		self.view = picker;
		[picker release];
	}
	return self;
}


/***************************************************************************************
 UIAlertViewDelegate 関連：
 ***************************************************************************************/

- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {  
	SEL sel;
    switch (buttonIndex) {
			//0:キャンセル, 1:OK
		case 0:
			break;
		case 1:
			sel = @selector(selectDate:selectedDate:);
			id delegate = self.delegate;
			if(delegate && [delegate respondsToSelector:sel]){
				UIDatePicker* picker = (UIDatePicker*)(((DatePickerAlertView*)alertView).pickerView);
				[delegate selectDate:self selectedDate:picker.date];
			}
			break;
		default:
			break;
	}
}  



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}

- (void)dealloc {
    [_alertView release];
    [_oldView release];
    [_selectedView release];
    [super dealloc];
}


@end
