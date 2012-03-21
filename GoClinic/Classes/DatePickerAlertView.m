//
//  DatePickerAlertView.m
//  GoClinic
//
//  Created by 猪子 徹 on 11/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DatePickerAlertView.h"
#define kTablePadding 8.0f

@interface UIAlertView (private)
- (void)layoutAnimated:(BOOL)fp8;
@end

@implementation DatePickerAlertView
@synthesize pickerView = _pickerView;
@synthesize selectedDate = _selectedDate;


- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate dataSource:(id)dataSource cancelButtonTitle:(NSString *)cancelButtonTitle okButtonTitle:(NSString *)okayButtonTitle
{
	
    if ((self = [super initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:okayButtonTitle, nil]))
    {		
		tableHeight = 150;
		tableExtHeight = tableHeight + 2 * kTablePadding;
        UIDatePicker *picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, tableHeight)];
		//picker.delegate = delegate;
		picker.datePickerMode = UIDatePickerModeDate;
		self.delegate = delegate;
		[picker setBackgroundColor:[UIColor whiteColor]];
		[self addSubview:picker];
		_pickerView = picker;
	}
	return self;
}

- (void)layoutAnimated:(BOOL)fp8 {
	[super layoutAnimated:fp8];
	[self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height + tableExtHeight)];
	
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
	CGFloat tableWidth = 262.0f;
	
	_pickerView.frame = CGRectMake(11.0f, -100, tableWidth, tableHeight);
	
	for (UIView *sv in self.subviews) {
		// Move all Controls down
		if ([sv isKindOfClass:[UIControl class]]) {
			sv.frame = CGRectMake(sv.frame.origin.x, sv.frame.origin.y + tableExtHeight, sv.frame.size.width, sv.frame.size.height);
		}
	}
}	


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc {
	[_pickerView release];
	[_selectedDate release];
    [super dealloc];
}


@end
