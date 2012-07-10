    //
//  NormalShowViewController.m
//  GoClinic
//
//  Created by 猪子 徹 on 11/02/15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NormalShowViewController.h"
#import "TsumegoShowViewController.h"
#import "GoClinicAppDelegate.h"
#import "StringUtil.h"
#import "GamesPickerAlertViewController.h"
#import "NormalGames.h"

@implementation NormalShowViewController

- (void)viewDidLoad {
    //現在のゲームが存在する場合は、棋譜を表示する
	if (_currentGame != nil && [_currentGame isKindOfClass:[NormalGames class]]) {
        
	}else{
        _currentGame = nil;
    }
    [super viewDidLoad];

	//ゲームの日付を表示
	_dateLabel.text = [StringUtil convertDateToString:_currentGame.save_date];
	//一手打つためのフラグを立てる
	_isStonePut = NO;
}

-(void)showSelectExsistedGamesAlertView{
    NSMutableArray* games = [NSMutableArray arrayWithArray:[(GoClinicAppDelegate*)[UIApplication sharedApplication].delegate getNormalGames]];
    [games retain];
    
    if([games count] <= 0){
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"情報" message:@"保存されたゲームが有りません。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alertView show];
		[alertView release];
		return;
    }
    
	GamesPickerAlertViewController *controller;
    controller = [[GamesPickerAlertViewController alloc] initWithTitle:games viewController:nil];
    //controller = [[GamesPickerAlertViewController alloc] initWithTitle:@"情報" message:@"既存のゲームを選んで下さい。" cancelButtonTitle:@"キャンセル" okButtonTitle:@"OK" pickerList:games];
	controller.delegate = self;
	[controller showAlertView];
}


-(void)setGoStoneViewDispSetting:(GoStoneView *)view{
    view.stoneColorId = [[_currentGame getCurrentUserId] intValue];
    view.displayMode = _stoneDispMode;
}


/***************************************************************************************
 BoardViewDelegate 関連：
 ***************************************************************************************/
//棋譜表示の場合はなにもしない
-(void) putGoStone:(GoStoneView *)stoneView x:(int)x y:(int)y{
}

/***************************************************************************************
 MenuPopOverViewControllerDelegate 関連：
 ***************************************************************************************/

-(void)showMenu:(id)sender delegate:(id)delegate{
	if (self.popoverView == nil) {
        MenuPopOverViewController *menues = 
		[[MenuPopOverViewController alloc] 
		 initWithNibName:@"MenuPopOverViewController" 
		 bundle:[NSBundle mainBundle] menuList:[[NSMutableArray alloc] initWithObjects:@"既存のゲームを開始", @"詰碁モードを開始", @"問題モードを開始", 
                                                @"保存して終了",@"保存しないで終了", nil]]; 
		
		//表示画面モードにする
		menues.delegate = delegate;
        UIPopoverController *popover = 
		[[UIPopoverController alloc] initWithContentViewController:menues]; 
		
        [menues release];
		
        self.popoverView = popover;
        [popover release];
    }
	
    [self.popoverView 
	 presentPopoverFromBarButtonItem:sender 
	 permittedArrowDirections:UIPopoverArrowDirectionAny 
	 animated:YES];
}


-(void)touchMenuItem:(id)menuItem menuId:(int)menuId{
	//0:新規ゲーム作成, 1:既存のゲームを開始
	
	switch (menuId) {
		case 0:
			[self showSelectExsistedGamesAlertView];
			break;
		case 1:
            [self showTsumegoShowMode];
			break;
        case 2:
			[self showQuestionShowMode];
            break;
		default:
			break;
	}
	[self.popoverView dismissPopoverAnimated:YES];
}



/***************************************************************************************
 IBAction 表示関連：
 ***************************************************************************************/
-(IBAction)touchNavRightButton:(id)sender{
    [self.popoverView dismissPopoverAnimated:YES];
    [self showNormalRegistMode];
}

-(IBAction)touchNavLeftButton:(id)sender{}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}

- (void)dealloc {
    [super dealloc];
}


@end
