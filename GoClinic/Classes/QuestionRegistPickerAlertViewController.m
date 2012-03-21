//
//  QuestionRegistPickerAlertViewController.m
//  GoClinic
//
//  Created by 猪子 徹 on 11/04/24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "QuestionRegistPickerAlertViewController.h"

#define ROW_HEIGHT 50
#define LABEL_WIDTH 200

#define CANCEL_BUTTON_INDEX 0
#define OK_BUTTON_INDEX 1

@implementation QuestionRegistPickerAlertViewController
@synthesize delegate = _delegate;
@synthesize alertView = _alertView;

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle okButtonTitle:(NSString *)okayButtonTitle facesList:(NSMutableArray*)facesList facesCategoriesList:(NSMutableArray*)facesCategoriesList{
    if((self = [super init])){
        self.view.tag = QUESTION_REGIST_PICKER_ALERT_VIEW_TAG;
		QuestionRegistAlertView* picker = [[QuestionRegistAlertView alloc] initWithTitle:title
                                                                                 message:message delegate:self dataSource:self cancelButtonTitle:cancelButtonTitle okButtonTitle:okayButtonTitle];
		self.view = picker;
		[picker release];
        _facesList = [[NSMutableArray alloc] initWithArray:facesList];
        _facesCategoriesList = [[NSMutableArray alloc] initWithArray:facesCategoriesList];
        [_facesCategoriesList retain];
	}
	return self;
    
}

- (void)didPresentAlertView:(UIAlertView *)alertView {
    [super viewDidLoad];
	//一番初めに表示されているViewをセレクトする
	[self pickerView:((QuestionRegistAlertView*)self.view).pickerView didSelectRow:0 inComponent:0];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Override to allow orientations other than the default portrait orientation.
    return YES;
}

- (void)showAlertView{
    [(PickerAlertView*)self.view show];
}

/***************************************************************************************
 *	PickerViewDelegate, PickerViewDatasource 関連；
 ***************************************************************************************/
- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {  
    return 1;  
}  

- (NSInteger) pickerView: (UIPickerView*)pView numberOfRowsInComponent:(NSInteger) component {  
    // セクションの情報を取得する
	return [_facesCategoriesList count];
}  

- (UIView *)pickerView:(UIPickerView *)picker viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{	
    UIView *cell = (UIView *)view;
    
    cell = [[UIView alloc] init];
    cell.frame = CGRectMake(0, 0, picker.frame.size.width, ROW_HEIGHT);//260, 60);
    cell.backgroundColor = [UIColor clearColor];
    
    UILabel* label = [[UILabel alloc] init];
    label.frame = CGRectMake(ROW_HEIGHT + ROW_HEIGHT /2 + 10,0, picker.frame.size.width - ROW_HEIGHT, ROW_HEIGHT);
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = UITextAlignmentLeft;
    label.textColor = [UIColor blackColor];
    label.text = [_facesCategoriesList objectAtIndex:row];
    [cell addSubview:label];
  
    //image
    UIImageView* image = [[UIImageView alloc] initWithImage:[_facesList objectAtIndex:row]];
    image.frame = CGRectMake(ROW_HEIGHT/2, 0, ROW_HEIGHT, ROW_HEIGHT);
    [cell addSubview:image];
 
 
    return cell;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return ROW_HEIGHT;
}

- (void)pickerView: (UIPickerView*)pView didSelectRow:(NSInteger)row  inComponent:(NSInteger)component {  
	if (_oldView != nil){
        _oldView.backgroundColor = [UIColor clearColor];
    }
	
	_selectedView = [pView viewForRow:row forComponent:component];
	_selectedView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
	[_selectedView setNeedsDisplay];
	_oldView = _selectedView;
    
    _selectedIndex = row;
}

/***************************************************************************************
 UIAlertViewDelegate 関連：
 ***************************************************************************************/

- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {  
	SEL sel;
    switch (buttonIndex) {
        //0:キャンセル, 1:OK
		case CANCEL_BUTTON_INDEX:
			break;
		case OK_BUTTON_INDEX:
			sel = @selector(selectedPickerIndex:index:faceList:facesCategoriesList:comment:);
			id delegate = self.delegate;
			if(delegate && [delegate respondsToSelector:sel]){
				[delegate selectedPickerIndex:self index:_selectedIndex faceList:_facesList facesCategoriesList:_facesCategoriesList comment:_alertView.textView.text];
			}
			break;
		default:
			break;
	}
}  

- (void)dealloc{
    [_alertView release];
    [_facesList release];
    [_facesCategoriesList release];
    [_oldView release];
    [_selectedView release];
    [super dealloc];
}


@end
