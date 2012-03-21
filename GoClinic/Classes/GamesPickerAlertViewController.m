//
//  GamesPickerAlertViewController.m
//  GoClinic
//
//  Created by 猪子 徹 on 11/05/03.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GamesPickerAlertViewController.h"

#define CANCEL_BUTTON_INDEX 0
#define OK_BUTTON_INDEX 1

@implementation GamesPickerAlertViewController
@synthesize delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithTitle:(NSMutableArray *)pickerList viewController:(UIViewController*)viewController{
    NSMutableArray* titleList = [[NSMutableArray alloc] init];
    if(pickerList){
        NSEnumerator* e = [pickerList objectEnumerator];
        Games* game;
        while((game = (Games*)[e nextObject]) != nil){
            NSLog(@"cur move is %d", [game.current_move intValue]);
            if(game.title != nil){
                NSLog(@"%@", game.title);
                [titleList addObject:game.title];
            }
        }
        _viewController = viewController;
    }
    if((self = [super initWithTitle:@"情報" message:@"既存のゲームを選んで下さい。" cancelButtonTitle:@"キャンセル" okButtonTitle:@"OK"  pickerList:titleList])){
        _games = pickerList;
        
    }
    return self;
    
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle okButtonTitle:(NSString *)okayButtonTitle pickerList:(NSMutableArray *)pickerList viewController:(UIViewController *)viewController{
    NSMutableArray* titleList = [[NSMutableArray alloc] init];
    if(pickerList){
        NSEnumerator* e = [pickerList objectEnumerator];
        Games* game;
        while((game = (Games*)[e nextObject]) != nil){
            NSLog(@"cur move is %d", [game.current_move intValue]);
            if(game.title != nil){
            NSLog(@"%@", game.title);
            [titleList addObject:game.title];
            }
        }
        _viewController = viewController;
    }
    if((self = [super initWithTitle:title message:message cancelButtonTitle:cancelButtonTitle okButtonTitle:okayButtonTitle pickerList:titleList])){
        _games = pickerList;
        
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
		case CANCEL_BUTTON_INDEX:
			break;
		case OK_BUTTON_INDEX:
			sel = @selector(selectedGamePickerIndex:index:game:viewController:);
			id delegate = self.delegate;
			if(delegate && [delegate respondsToSelector:sel]){
				[delegate selectedGamePickerIndex:self index:_selectedIndex game:(Games*)[_games objectAtIndex:_selectedIndex] viewController:_viewController];
			}
			break;
		default:
			break;
	}
}  

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)dealloc
{
    [super dealloc];
}

@end
