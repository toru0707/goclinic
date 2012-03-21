//
//  QuestionPickerAlertViewController.m
//  GoClinic
//
//  Created by 猪子 徹 on 11/04/21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BaseLabelPickerAlertViewController.h"


@implementation BaseLabelPickerAlertViewController

/***************************************************************************************
 *	PickerViewDelegate, PickerViewDatasource 関連；
 ***************************************************************************************/
- (NSString*)pickerView: (UIPickerView*) pView titleForRow:(NSInteger) row forComponent:(NSInteger)component {  
    return (NSString*)[_pickerList objectAtIndex:row];
} 

- (UIView *)pickerView:(UIPickerView *)picker viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{	
    UILabel *label = (UILabel *)view;

    label = [[UILabel alloc] init];
    label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, self.view.frame.size.width, 30);
    label.backgroundColor = [UIColor clearColor];
	label.textAlignment = UITextAlignmentCenter;
	label.textColor = [UIColor lightGrayColor];
    label.text = [_pickerList objectAtIndex:row];
 
    return label;
}

- (void)pickerView: (UIPickerView*)pView didSelectRow:(NSInteger)row  inComponent:(NSInteger)component {  
	if (_oldView != nil){
        ((UILabel*)_oldView).textColor = [UIColor lightGrayColor];
        ((UILabel*)_oldView).backgroundColor = [UIColor clearColor];
    }
	
	_selectedView = [pView viewForRow:row forComponent:component];
	_selectedView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
	((UILabel*)_selectedView).textColor = [UIColor redColor];
	((UILabel*)_selectedView).highlighted = YES;
	[_selectedView setNeedsDisplay];
	_oldView = _selectedView;
    
    _selectedIndex = row;
}

-(void)dealloc{
    [_oldView release];
    [_selectedView release];
    [super dealloc];
}

@end
