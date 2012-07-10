//
//  QuestionRegistViewController.m
//  GoClinic
//
//  Created by 猪子 徹 on 11/03/19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "QuestionRegistViewController.h"
#import "QuestionShowViewController.h"
#import "QuestionGames.h"
#import "ImageManager.h"
#import "FacesView.h"
#import "GamesPickerAlertViewController.h"
#import "GoClinicAppDelegate.h"
#import "NormalRegistViewController.h"
#import "TsumegoRegistViewController.h"
#import "AnswerQuestionGameState.h"
#import "NormalQuestionGameState.h"
#import "RegistQuestionGameState.h"
#import "QuestionNormalViewControllerState.h"
#import "QuestionAnswerViewControllerState.h"

@interface QuestionRegistViewController(private)
  /**
   * 碁石登録モードへ変更する
   */
-(void)changeToNormalState;
  /**
   * 問題モードへ変更する
   */
-(void)changeToAnswerState;
@end

@implementation QuestionRegistViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    //現在のゲームが存在する場合は、棋譜を表示する
	if (_currentGame != nil && [_currentGame isKindOfClass:[QuestionGames class]]) {
	}else{
        _currentGame = nil;
    }
    [super viewDidLoad];
    [self changeToNormalState];

}

-(void)changeState:(QuestionViewControllerState*)state{
    [_state release];
    _state = [state retain];
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

/**
 新規のゲームを開始する
 */
-(void)startNewGameNoResetBoard{
	[_currentGame clearStoneBoard];
	_currentGame = [[QuestionGames alloc] initGames];
	_currentGame.current_user = _currentGame.first_user;
	_currentGame.boardView = _boardView;
	
	//初期ビュー設定
	_gameTitleLabel.text = @"";
}

-(Games*)createGame{
    return [[QuestionGames alloc] initGames];
}

/**
 表示画面に遷移する
 */
-(void)showShowViewWithGame:(Games*)game{
    _currentGame = game;
    [self showQuestionShowMode];
}

-(void)setGoStoneViewDispSetting:(GoStoneView *)view{
    view.stoneColorId = [[_currentGame getCurrentUserId] intValue];
    view.displayMode = _stoneDispMode;
}


-(void)showGoStoneViewAfterPutGoStone:(GameRecords*)record{
    [_state showGoStoneViewAfterPutGoStone:record];
}



/***************************************************************************************
 BoardViewDelegate 関連：
 ***************************************************************************************/
/*-(void)putGoStone:(GoStoneView *)stoneView x:(int)x y:(int)y{

}*/

/***************************************************************************************
 QuestionRegistAlertViewControllerDelegate 関連：
 ***************************************************************************************/

-(void)selectedPickerIndex:(id)sender index:(int)index faceList:(NSMutableArray*)faceList facesCategoriesList:(NSMutableArray*)facesCategoriesList comment:(NSString*)comment{
    
    
    
}

/***************************************************************************************
 FacesWithNoLabelViewControllerDelegate 関連：
 ***************************************************************************************/

-(void)touchFacesWithNoLabelTableViewCell:(id)sender faceNumber:(int)faceNumber{
    
}

/***************************************************************************************
 SubView 関連：
 ***************************************************************************************/
-(void)showFacesView:(BOOL)animated{
    FacesWithNoLabelViewController* controller = [[FacesWithNoLabelViewController alloc] initWithNibName:@"FacesViewController" bundle:nil];
    controller.view.frame = CGRectMake(-controller.view.frame.size.width, 0, controller.view.frame.size.width, 
                                       _boardView.frame.size.height);
    
    controller.delegate = self;
    [_boardView addSubview:controller.view];
    
    //アニメーション
	int facesViewWidth = controller.view.frame.size.width;
	//controller.buttonColorFlag = ([_currentGame.current_record.move intValue] + 1) % 2;
	controller.buttonColorFlag = _currentGame.current_record.view.stoneColorId;
    [((UITableView*)controller.view) reloadData];
	[(FacesView*)controller.view startAnimation:CGRectMake(controller.view.frame.origin.x + facesViewWidth, controller.view.frame.origin.y, 
                                                           controller.view.frame.size.width, controller.view.frame.size.height) sender:controller.view finishedEvent:nil];
}

-(void)hideFacesView:(BOOL)animated{
    FacesView* view = (FacesView*)[_boardView viewWithTag:FACES_WITH_NO_LABEL_VIEW_CONTROLLER_TAG];
    if(view){
        int facesViewWidth = view.frame.size.width;
        SEL sel = @selector(removeFromSuperview);
        [view startAnimation:CGRectMake(view.frame.origin.x - facesViewWidth, view.frame.origin.y, 
                                        view.frame.size.width, view.frame.size.height) sender:view finishedEvent:sel];
    }
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(commentGoStoneMenu:)) {
        return YES;
    }else if (action == @selector(clinicGoStoneMenu:)) {
		return YES;
	}else if (action == @selector(faceRegistGoStoneMenu:)) {
		return YES;
	}else if (action == @selector(deleteGoStoneMenu:)){
        return YES;
	}else if (action == @selector(henkazuGoStoneMenu:)){
        return YES;
    }
    return NO;
}



- (void)clinicGoStoneMenu:(id)sender {
	//Clinicのため、ひとつ手を戻す
	[self unSelectStone:_currentGame.current_record];
	[_currentGame.current_record.view removeFromSuperview];
	
	//新規に分岐レコードを挿入する旨のフラグを立てる
	_currentGame.isNewBranchRecord = YES;
	_currentGame.current_root_record = _currentGame.current_record;
	[self createClinic];
	
}

-(void)henkazuGoStoneMenu:(id)sender{
    NSLog(@"te");
}

/***************************************************************************************
 MenuPopOverViewControllerDelegate 関連：
 ***************************************************************************************/

-(void)showMenu:(id)sender delegate:(id)delegate{
	if (self.popoverView == nil) {
        
        MenuPopOverViewController *menues = 
		[[MenuPopOverViewController alloc] 
		 initWithNibName:@"MenuPopOverViewController" 
		 bundle:[NSBundle mainBundle] menuList:[[NSMutableArray alloc] initWithObjects:@"クリニックを登録", 
                                                @"詰碁を登録", @"問題を登録", @"上書き保存する", 
                                                @"別名で保存する",@"登録モード終了", nil]]; 
		
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
    
    RegistGameAlertViewController* controller;
    NormalRegistViewController* nController = [[NormalRegistViewController alloc] initWithNibNameAndGame:@"NormalRegistViewController" bundle:nil game:nil];
    TsumegoRegistViewController* tController = [[TsumegoRegistViewController alloc] initWithNibNameAndGame:@"TsumegoRegistViewController" bundle:nil game:nil];
    QuestionRegistViewController* qController = [[QuestionRegistViewController alloc] initWithNibNameAndGame:@"QuestionRegistViewController" bundle:nil game:nil]
    ;
    QuestionShowViewController* qShowController  = [[QuestionShowViewController alloc] initWithNibNameAndGame:@"QuestionShowViewController" bundle:nil game:_currentGame];
	switch (menuId) {
		case 0:
			//クリニックを登録
            controller = [[RegistGameAlertViewController alloc] initWithClass:nController];
            controller.delegate = self;
            [controller showAlertView];
			break;
		case 1:
			//詰碁を登録
            controller = [[RegistGameAlertViewController alloc] initWithClass:tController];
            controller.delegate = self;
            [controller showAlertView];
			break;
		case 2:
			//問題を登録
            controller = [[RegistGameAlertViewController alloc] initWithClass:qController];
            controller.delegate = self;
            [controller showAlertView];
        case 3:
			//上書き保存する
			[self prepareExitGame:menuId];
			break;
		case 4:
			//別名で保存する
			[self prepareExitGame:menuId];
			break;
		case 5:
			//登録モードを終了
			[self saveCurrentGameWithSaveAlertView:qShowController];
			break;
		default:
			break;
	}
	[self.popoverView dismissPopoverAnimated:YES];
}

/***************************************************************************************
 IBAction 関連：
 ***************************************************************************************/

-(IBAction)touchNavRightButton:(id)sender{
    QuestionShowViewController* controller  = [[QuestionShowViewController alloc] initWithNibNameAndGame:@"QuestionShowViewController" bundle:nil game:_currentGame];
    [self saveCurrentGameWithSaveAlertView:controller];
}


-(IBAction) touchRegistQuestionStatementButton:(id)sender{
    ImageManager* manager = [ImageManager instance];
    QuestionRegistPickerAlertViewController* controller = [[QuestionRegistPickerAlertViewController alloc] initWithTitle:@"情報" message:@"問題を登録して下さい" cancelButtonTitle:@"キャンセル" okButtonTitle:@"OK" facesList:manager.b_images facesCategoriesList:manager.faceTitles];
    controller.delegate = self;
    ((QuestionRegistAlertView*)controller.view).textView.text = @"さて次の一手は？黒番です。";
	[(PickerAlertView*)((QuestionRegistPickerAlertViewController*)controller).view show];
}


-(IBAction) touchRegistAnswerButton:(id)sender{
    QuestionGames* game = (QuestionGames*)_currentGame;
    //ViewControllerとGamesのStateを変更する
    if([game isAnswerState]){
        [self changeToNormalState];
    }else{
        [self changeToAnswerState];
    }
}

-(void) touchForMenuWithStone:(UITouch *)theTouch withEvent:(UIEvent*)event withGoStoneView:(GoStoneView *)stoneView{
    [stoneView showContextMenu:_boardView];
}

/***************************************************************************************
  UIAlertViewControllerDelegate 関連：
***************************************************************************************/
- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex { 
    
}

/***************************************************************************************
 private 関連：
 ***************************************************************************************/
-(void)changeToNormalState{
    QuestionViewControllerState* state = [[QuestionNormalViewControllerState alloc] initWithViewController:self];
    [self changeState:state];
    //GameのStateを変更
    QuestionGames* game = (QuestionGames*)_currentGame;
    [game changeToNormalState];
    [_registAnswerButton setTitle:@"解答登録" forState:UIControlStateNormal];
    [_registAnswerButton setNeedsDisplay];
}
-(void)changeToAnswerState{
    QuestionViewControllerState* state = [[QuestionAnswerViewControllerState alloc] initWithViewController:self];
    [self changeState:state];
    //GameのStateを変更
    QuestionGames* game = (QuestionGames*)_currentGame;
    [game changeToAnswerState];
    [_registAnswerButton setTitle:@"解答登録終了" forState:UIControlStateNormal];
    [_registAnswerButton setNeedsDisplay];
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
