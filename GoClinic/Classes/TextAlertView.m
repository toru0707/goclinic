//
//  TextAlertView.m
//  GoClinic
//
//  Created by 猪子 徹 on 11/01/05.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TextAlertView.h"
#import "Global.h"

@interface UIAlertView (private)
- (void)layoutAnimated:(BOOL)fp8;
@end
@implementation TextAlertView
@synthesize textField;

/*
 *	Initialize view with maximum of two buttons
 */
- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate 
  cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
	self = [super initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle
			  otherButtonTitles:otherButtonTitles, nil];
	if (self) {
		// Create and add UITextField to UIAlertView
		UITextField *myTextField = [[[UITextField alloc] initWithFrame:CGRectZero] retain];
		myTextField.autocorrectionType = UITextAutocorrectionTypeNo;
		myTextField.alpha = 0.75;
		myTextField.borderStyle = UITextBorderStyleRoundedRect;
		myTextField.keyboardType = UIKeyboardTypeDefault;
		myTextField.delegate = delegate;
		myTextField.tag = GAME_SAVE_TEXTFIELD;
		[self setTextField:myTextField];
		// insert UITextField before first button
		BOOL inserted = NO;
		for( UIView *view in self.subviews ){
			if(!inserted && ![view isKindOfClass:[UILabel class]])
				[self insertSubview:myTextField aboveSubview:view];
		}
		
		//[self addSubview:myTextField];
		// ensure that layout for views is done once
		layoutDone = NO;
		
		// add a transform to move the UIAlertView above the keyboard
		CGAffineTransform myTransform = CGAffineTransformMakeTranslation(0.0, kUIAlertOffset);
		[self setTransform:myTransform];
	}
	return self;
}

/*
 *	Show alert view and make keyboard visible
 */
- (void) show {
	[super show];
	[[self textField] becomeFirstResponder];
}



- (void)layoutAnimated:(BOOL)fp8 {
	[super layoutAnimated:fp8];
	[self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height + kUITextFieldHeight)];
	
	// We get the lowest non-control view (i.e. Labels) so we can place the table view just below
	UIView *lowestView = [self.subviews objectAtIndex:0];
	int i = 0;
	while (![[self.subviews objectAtIndex:i] isKindOfClass:[UIControl class]]) {
		UIView *v = [self.subviews objectAtIndex:i];
		if (lowestView.frame.origin.y + lowestView.frame.size.height < v.frame.origin.y + v.frame.size.height) {
			lowestView = v;
		}
		
		i++;
	}
	
	
	textField.frame = CGRectMake(11.0f, 10 * kUITextFieldYPadding - 2 * kUITextFieldHeight, kUITextFieldWidth, kUITextFieldHeight);
	
	for (UIView *sv in self.subviews) {
		// Move all Controls down
		if ([sv isKindOfClass:[UIControl class]]) {
			sv.frame = CGRectMake(sv.frame.origin.x, sv.frame.origin.y + kUITextFieldHeight, sv.frame.size.width, sv.frame.size.height);
		}
	}
}	

-(void)dealloc{
	[textField release];
	[super dealloc];
}

@end
