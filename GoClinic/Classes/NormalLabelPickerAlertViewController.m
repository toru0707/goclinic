//
//  NormalLabelPickerAlertViewController.m
//  GoClinic
//
//  Created by 猪子 徹 on 11/05/03.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NormalLabelPickerAlertViewController.h"


@implementation NormalLabelPickerAlertViewController
@synthesize delegate = _delegate;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
			sel = @selector(selectedLabelPickerIndex:index:label:);
			id delegate = self.delegate;
			if(delegate && [delegate respondsToSelector:sel]){
				[delegate selectedLabelPickerIndex:self index:_selectedIndex label:(NSString*)[_pickerList objectAtIndex:_selectedIndex]];
			}
			break;
		default:
			break;
	}
}  

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
