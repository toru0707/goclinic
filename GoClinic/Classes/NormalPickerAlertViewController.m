//
//  NormalPickerAlertViewController.m
//  GoClinic
//
//  Created by 猪子 徹 on 11/04/21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NormalPickerAlertViewController.h"

@implementation NormalPickerAlertViewController
@synthesize alertView = _alertView;

#pragma mark -
#pragma mark View lifecycle

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle okButtonTitle:(NSString *)okayButtonTitle pickerList:(NSMutableArray *)pickerList{
	if((self = [super init])){
		PickerAlertView* picker = [[PickerAlertView alloc] initWithTitle:title
																 message:message delegate:self dataSource:self cancelButtonTitle:cancelButtonTitle okButtonTitle:okayButtonTitle];
     
		self.view = picker;
		[picker release];
        _pickerList = pickerList;
	}
	return self;
}

- (void)didPresentAlertView:(UIAlertView *)alertView {
    [super viewDidLoad];
	//一番初めに表示されているViewをセレクトする
	[self pickerView:((PickerAlertView*)self.view).pickerView didSelectRow:0 inComponent:0];
}

- (void)showAlertView{
    [(PickerAlertView*)self.view show];
}


/***************************************************************************************
 *	PickerViewDelegate, PickerViewDatasource 関連；
 ***************************************************************************************/
- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {  
    return PICKER_ALERT_VIEW_COMPONENT_NUM;  
}  

- (NSInteger) pickerView: (UIPickerView*)pView numberOfRowsInComponent:(NSInteger) component {  
    // セクションの情報を取得する
	return [_pickerList count];
}  


- (NSString*)pickerView: (UIPickerView*) pView titleForRow:(NSInteger) row forComponent:(NSInteger)component {  
    return (NSString*)[_pickerList objectAtIndex:row];
} 



- (void)pickerView: (UIPickerView*)pView didSelectRow:(NSInteger)row  inComponent:(NSInteger)component {  
    _selectedIndex = row;
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Override to allow orientations other than the default portrait orientation.
    return YES;
}

- (void)dealloc {
    [_alertView release];
    [_pickerList release];
    [super dealloc];
}

@end
