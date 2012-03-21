//
//  QuestionRegistAlertView.m
//  GoClinic
//
//  Created by 猪子 徹 on 11/04/22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "QuestionRegistAlertView.h"
#define kTablePadding 8.0f
#define kUITextFieldHeight 100.0
#define kUITextFieldWidth 362.0
#define kUITextFieldXPadding 12.0
#define kUITextFieldYPadding 10.0
#define kUIAlertOffset 10.0

#define PICKERVIEW_HEIGHT 200.0

@interface UIAlertView (private)
- (void)layoutAnimated:(BOOL)fp8;
@end

@implementation QuestionRegistAlertView
@synthesize pickerView = _pickerView;
@synthesize textView = _textView;

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate dataSource:(id)dataSource cancelButtonTitle:(NSString *)cancelButtonTitle okButtonTitle:(NSString *)okayButtonTitle
{
	
    if ((self = [super initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:okayButtonTitle, nil]))
    {		
		tableExtHeight = PICKERVIEW_HEIGHT + 2 * kTablePadding;
        UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(kUITextFieldXPadding, 10 * kTablePadding + kUITextFieldWidth, kUITextFieldWidth, tableHeight)];
		picker.delegate = delegate;
		self.delegate = delegate;
		[self addSubview:picker];
		_pickerView = picker;
        
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(kUITextFieldXPadding * 2, 10 * kTablePadding, kUITextFieldWidth - kUITextFieldXPadding, kUITextFieldHeight)];
        [self addSubview:_textView];
    }
    return self;
}

- (void)layoutAnimated:(BOOL)fp8 {
	[super layoutAnimated:fp8];
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, kUITextFieldWidth + kUITextFieldXPadding * 2, self.frame.size.height + tableExtHeight + kUITextFieldHeight)];
	
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
	
	// TODO: calculate this value
	
	_pickerView.frame = CGRectMake(kUITextFieldXPadding * 2, 10 * kTablePadding + kUITextFieldHeight + kUITextFieldYPadding, kUITextFieldWidth - kUITextFieldXPadding * 2, tableHeight);
    _textView.frame = CGRectMake(kUITextFieldXPadding * 2, 10 * kTablePadding, kUITextFieldWidth - kUITextFieldXPadding * 2, kUITextFieldHeight);
	
	for (UIView *sv in self.subviews) {
		// Move all Controls down
		if ([sv isKindOfClass:[UIControl class]]) {
			sv.frame = CGRectMake(sv.frame.origin.x + (sv.frame.size.width / 2), sv.frame.origin.y + tableExtHeight + kUITextFieldHeight - kUITextFieldYPadding,
                                  sv.frame.size.width, sv.frame.size.height);
		}
	}
}	
@end
