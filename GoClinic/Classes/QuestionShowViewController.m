//
//  QuestionShowViewController.m
//  GoClinic
//
//  Created by 猪子 徹 on 11/03/19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "QuestionShowViewController.h"
#import "GoClinicAppDelegate.h"
#import "NormalShowViewController.h"
#import "GamesPickerAlertViewController.h"
#import "QuestionGames.h"

@interface QuestionShowViewController(private)
/**
 状態を保存し、問題￥モードを終了する
 */
-(void)quitQuestionModeWithSaveState;
@end


@implementation QuestionShowViewController

- (void)viewDidLoad
{
    //現在のゲームが存在する場合は、棋譜を表示する
	if (_currentGame != nil && [_currentGame isKindOfClass:[QuestionGames class]]) {
	}else{
        _currentGame = nil;
    }
    [super viewDidLoad];

}

/**
 既存のゲームを開始する
 */
-(void)showSelectExsistedGamesAlertView{
    NSMutableArray* games = [NSMutableArray arrayWithArray:[(GoClinicAppDelegate*)[UIApplication sharedApplication].delegate getQuestionGames]];
    
    [games retain];
    
    if([games count] <= 0){
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"情報" message:@"保存されたゲームが有りません。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alertView show];
		[alertView release];
		return;
    }
    
	GamesPickerAlertViewController* controller;
    controller = [[GamesPickerAlertViewController alloc] initWithTitle:games viewController:nil];
	controller.delegate = self;
	[controller showAlertView];
}

-(void)quitQuestionModeWithSaveState{
    [self showNormalShowMode];
}


/***************************************************************************************
 MenuPopOverViewControllerDelegate 関連：
 ***************************************************************************************/

-(void)showMenu:(id)sender delegate:(id)delegate{
	if (self.popoverView == nil) {
        MenuPopOverViewController *menues = 
		[[MenuPopOverViewController alloc] 
		 initWithNibName:@"MenuPopOverViewController" 
		 bundle:[NSBundle mainBundle] menuList:[[NSMutableArray alloc] initWithObjects:@"既存のゲームを開始", @"クリニックモードを開始", @"詰碁モードを開始", 
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
            [self showNormalShowMode];
			break;
        case 2:
			[self showTsumegoShowMode];
            break;
		default:
			break;
	}
	[self.popoverView dismissPopoverAnimated:YES];
}

/***************************************************************************************
 LabelPickerAlertViewControllerDelegate 関連：
 ***************************************************************************************/

-(void)selectedPickerIndex:(id)sender index:(int)index pickerList:(NSMutableArray*)pickerList{
    
}

/***************************************************************************************
 QuestionRegistAlertViewControllerDelegate 関連：
 ***************************************************************************************/

-(void)selectedPickerIndex:(id)sender index:(int)index faceList:(NSMutableArray*)faceList facesCategoriesList:(NSMutableArray*)facesCategoriesList comment:(NSString*)comment{
    
}

/***************************************************************************************
 IBAction 関連：
 ***************************************************************************************/

-(IBAction)touchNavRightButton:(id)sender{
    [self showQuestionRegistMode];
}

-(IBAction)touchGiveUpButton:(id)sender{
}

-(IBAction)touchHintButton:(id)sender{
}

-(IBAction)touchCompareButton:(id)sender{
    
}

-(IBAction)touchShowChangeChartButton:(id)sender{
}

-(IBAction)touchBackToQuestionButton:(id)sender{    
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
