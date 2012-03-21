//
//  InputGameNameAlertViewController.m
//  GoClinic
//
//  Created by 猪子 徹 on 11/05/31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InputGameNameAlertViewController.h"
#define SAVE_GAME_OK_BUTTON_INDEX 1
#define CANCEL_SAVE_GAME_BUTTON_INDEX 0

@implementation InputGameNameAlertViewController
@synthesize alertView = _alertView;
@synthesize delegate = _delegate;

- (id)initWithClass:(UIViewController*)viewController{
    if((self = [super init])){
        _viewController = viewController;
        _alertView = [[TextAlertView alloc] initWithTitle:@"情報" message:@"ゲーム名を入力して下さい。" delegate:self cancelButtonTitle:@"キャンセル" otherButtonTitles:@"OK", nil];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)showAlertView{
    [_alertView show];
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

/***************************************************************************************
 UIAlertViewDelegate 関連：
 ***************************************************************************************/

- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex { 
    id delegate = _delegate;
    switch (buttonIndex) {
        case SAVE_GAME_OK_BUTTON_INDEX:
            if(delegate && [delegate respondsToSelector: @selector(touchSaveOkButton:fileName:)]){
                [delegate touchSaveOkButton:_viewController fileName:_alertView.textField.text];
            }
            break;
        case CANCEL_SAVE_GAME_BUTTON_INDEX:
            if(delegate && [delegate respondsToSelector: @selector(touchCancelSaveButton:)]){
                [delegate touchCancelSaveButton:_viewController];
            }
            break;
        default:
            break;
    }
}

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
