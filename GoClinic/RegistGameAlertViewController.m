//
//  RegistGameAlertViewController.m
//  GoClinic
//
//  Created by 猪子 徹 on 11/05/30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RegistGameAlertViewController.h"
#define REGIST_NEW_GAME_INDEX 1
#define REGIST_EXISTED_GAME_INDEX 2
#define CANCEL_INDEX 0

@implementation RegistGameAlertViewController
@synthesize alertView = _alertView;
@synthesize delegate = _delegate;

- (id)initWithClass:(UIViewController*)viewClass{
    if((self = [super init])){
        _viewControllerClass = viewClass;
        _alertView = [[UIAlertView alloc] initWithTitle:@"情報" message:@"" delegate:self cancelButtonTitle:@"キャンセル" otherButtonTitles:@"新規のゲームを登録", @"既存のゲームを選択", nil];
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
        case REGIST_NEW_GAME_INDEX:
            if(delegate && [delegate respondsToSelector: @selector(touchRegistNewGameButton:)]){
                [delegate touchRegistNewGameButton:_viewControllerClass];
            }
            break;
        case REGIST_EXISTED_GAME_INDEX:
            if(delegate && [delegate respondsToSelector: @selector(touchRegistExistedGameButton:)]){
                [delegate touchRegistExistedGameButton:_viewControllerClass];
            }
            break;
        case CANCEL_INDEX:
            if(delegate && [delegate respondsToSelector: @selector(touchCancelButton:)]){
                [delegate touchCancelButton:_viewControllerClass];
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
