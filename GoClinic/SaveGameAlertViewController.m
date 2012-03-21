//
//  SaveGameAlertViewController.m
//  GoClinic
//
//  Created by 猪子 徹 on 11/05/31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SaveGameAlertViewController.h"
#define SAVE_GAME_BUTTON_INDEX 1
#define NOT_SAVE_GAME_BUTTON_INDEX 2
#define CANCEL_SAVE_GAME_BUTTON_INDEX 0

@implementation SaveGameAlertViewController
@synthesize alertView = _alertView;
@synthesize delegate = _delegate;

- (id)initWithClass:(UIViewController*)viewClass{
    if((self = [super init])){
        _viewController = viewClass;
        _alertView = [[UIAlertView alloc] initWithTitle:@"情報" message:@"既存のゲームを保存しますか？" delegate:self cancelButtonTitle:@"キャンセル" otherButtonTitles:@"保存", @"保存しない", nil];
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
        case SAVE_GAME_BUTTON_INDEX:
            if(delegate && [delegate respondsToSelector: @selector(touchRegistNewGameButton:)]){
                [delegate touchSaveGameButton:_viewController];
            }
            break;
        case NOT_SAVE_GAME_BUTTON_INDEX:
            if(delegate && [delegate respondsToSelector: @selector(touchRegistExistedGameButton:)]){
                [delegate touchNotSaveGameButton:_viewController];
            }
            break;
        case CANCEL_SAVE_GAME_BUTTON_INDEX:
            if(delegate && [delegate respondsToSelector: @selector(touchCancelButton:)]){
                [delegate touchCancelSaveGameButton:_viewController];
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
