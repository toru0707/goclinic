//
//  TsumegoViewController.m
//  GoClinic
//
//  Created by 猪子 徹 on 11/01/22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TsumegoRegistViewController.h"
#import "TsumegoShowViewController.h"
#import "BoardView.h"
#import "Global.h"
#import "TsumegoGames.h"
#import "GoClinicAppDelegate.h"
#import "GamesPickerAlertViewController.h"

@implementation TsumegoRegistViewController

@synthesize userSegmentedControl = _userSegmentedControl;
@synthesize registAnswerButton = _registAnswerButton;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    //現在のゲームが存在する場合は、棋譜を表示する
	if (_currentGame != nil && [_currentGame isKindOfClass:[TsumegoGames class]]) {
        ((TsumegoGames*)_currentGame).isAnswerRegisterMode = NO;
	}else{
        _currentGame = nil;
    }
	[super viewDidLoad];

    _state = [[TsumegoGameState alloc] initWithViewController:self];
    //黒白を変更する
    _currentGame.currentUserId = (_userSegmentedControl.selectedSegmentIndex  + 1 )% 2 ;
    ((TsumegoGames*)_currentGame).isOkiishiMode = YES;
    ((TsumegoGames*)_currentGame).okiishiUserId = (_userSegmentedControl.selectedSegmentIndex  + 1 )% 2 ;
}

-(void)initBoardView{
    [super initBoardView];
    _boardView.xSize = BOARD_SIZE13;
    _boardView.ySize = BOARD_SIZE13;
}

-(void)showSelectExsistedGamesAlertView{
    NSMutableArray* games = [NSMutableArray arrayWithArray:[(GoClinicAppDelegate*)[UIApplication sharedApplication].delegate getTsumegoGames]];
    
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

-(Games*)createGame{
    return [[TsumegoGames alloc] initGames];
}

/**
 指定されたGoStoneから、指定された手数まで棋譜を再帰的に表示する
 尚、最後のレコードを返す
 */
-(GameRecords* )insertGoStoneViewCyclick:(GameRecords*)record toMove:(int)toMove opacity:(float)opacity{
	NSLog(@"current record move is %d.", [record.move intValue]);
	//GameRecordがNULLの場合は終了する
	if((record == nil) || ([record.move intValue] > toMove)){
		return record.prev_game_records;
	}
	record.view.stoneColorId = [record.user_id intValue];
    record.view.stoneOpacity = opacity;
	record.view.isHighLighted = NO;
	
    record.view.stoneOpacity = NORMAL_OPACITY;
	[self insertGoStoneView:record.view aboveView:_commentViewController.view];
	
	if (record.next_game_records == nil) {
		return record;
	}else {
		return [self insertGoStoneViewCyclick:record.next_game_records toMove:toMove  opacity:opacity];
	}
}


-(void)setGoStoneViewDispSetting:(GoStoneView *)view{
    //先攻後攻で石の色を変える
    if (((TsumegoGames*)_currentGame).isAnswerRegisterMode) {
        view.stoneColorId = [_currentGame checkUser:((TsumegoGames*)_currentGame).answerMove];
    }else if(((TsumegoGames*)_currentGame).isOkiishiMode){
        view.stoneColorId = [[_currentGame getCurrentUserId] intValue];
    }else{
        view.stoneColorId = [[_currentGame getCurrentUserId] intValue];
        NSLog(@"stoneColorId is %d", view.stoneColorId);
        view.displayMode = _stoneDispMode;
        
    }
}


-(void)showShowViewWithGame:(Games*)game{
    _currentGame = game;
    [self showTsumegoShowMode];
}

/**
 新規のゲームを開始する
 */
-(void)startNewGameNoResetBoard{
	
	[_currentGame clearStoneBoard];
	_currentGame = [[TsumegoGames alloc] initGames];
	_currentGame.current_user = _currentGame.first_user;
	_currentGame.boardView = _boardView;
	
	//初期ビュー設定
	_gameTitleLabel.text = @"";
}

-(void)putGoStone:(GoStoneView *)stoneView x:(int)x y:(int)y{
	//サブビューが表示されている場合は、全てのサブビューを隠して終了
	if ([self hideSubViews:YES]) {
		return;
	}
    
    [self checkCurrentNextRecordPuttable:x y:y];
    
    //ゲームが開始されていない場合は石を置くことが出来ない
	if (_currentGame != nil) {
		[self unSelectStone:_currentGame.current_record];
        
        GameRecords* newRecord = [_currentGame createOkiishiRecord:x y:y goStoneView:stoneView];
        
        //recordのViewの設定
        newRecord.view = stoneView;
        newRecord.view.showFace = _currentGame.isShowFaceMode;
        newRecord.view.showNumber = _currentGame.isShowNumberMode;
        newRecord.view.move = [newRecord.move intValue];
        stoneView.record = newRecord;
        
		//現在のレコードに関して各ボタンのOn/Offをチェックする
        [self checkButtonActivate];
		
        //石の表示方法を指定する（色等）
        [self setGoStoneViewDispSetting:newRecord.view];
        
        //石を表示する
        [self showGoStoneViewAfterPutGoStone:newRecord];
        
        [self selectStone:newRecord];
	}else{
		UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"情報" message:@"ゲームを開始して下さい" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alertView show];
	}
    
    [_currentGame save];
    
}




/*****************************************************
 * QuestionRegistPickerAlertViewControllerDelegate
 *****************************************************/
-(void)selectedPickerIndex:(id)sender index:(int)index faceList:(NSMutableArray *)faceList facesCategoriesList:(NSMutableArray *)facesCategoriesList comment:(NSString *)comment{
}



/*****************************************************
 * IBAction系
 *****************************************************/


-(IBAction)touchNavRightButton:(id)sender{
    TsumegoShowViewController* controller  = [[TsumegoShowViewController alloc] initWithNibNameAndGame:@"TsumegoShowViewController" bundle:nil game:_currentGame];
    [self saveCurrentGameWithSaveAlertView:controller];
}

-(IBAction)touchMenuButton:(id)sender{
    [super touchMenuButton:sender];
}


-(IBAction)touchRegistQuestionStatementButton:(id)sender{
    //問題文を格納
    NSMutableArray* questionCategory = [[NSMutableArray alloc] initWithObjects:@"黒先",@"黒先死",@"黒先生き",@"黒先コウ",@"白先",@"白先死",@"白先生き",@"白先コウ", nil];
    
	QuestionRegistPickerAlertViewController *controller;
	controller = [[QuestionRegistPickerAlertViewController alloc] initWithTitle:@"情報" message:@"" cancelButtonTitle:@"キャンセル" okButtonTitle:@"OK" facesList:nil facesCategoriesList:questionCategory];
                                                                    
	controller.delegate = self;
    [controller showAlertView];
    
}

/**
 * ユーザを切り替えるボタンのデリゲートメソッド
 */
-(IBAction)touchChangeStoneColorSegmentedControl:(id)sender{
	UISegmentedControl* control = (UISegmentedControl*)sender;
	NSLog(@"segmentedControlChanged. current user is %d", control.selectedSegmentIndex);
	((TsumegoGames*)_currentGame).okiishiUserId = (_userSegmentedControl.selectedSegmentIndex  + 1 )% 2 ;
}

/**
 * 回答登録ボタンが押された場合
 */
-(IBAction)touchRegistAnswerButton:(id)sender{
	//解答登録モードの切替を行う
	
	//モード終了
	if (((TsumegoGames*)_currentGame).isAnswerRegisterMode) {
		((TsumegoGames*)_currentGame).isAnswerRegisterMode = NO;
		_userSegmentedControl.enabled = YES;
		[_registAnswerButton setTitle:@"解答登録" forState:UIControlStateNormal];
		[_state clearAnswerStones];
		//[_gameState clearAnswerStones];
	}else {
		//モード開始
		((TsumegoGames*)_currentGame).isAnswerRegisterMode = YES;
		_userSegmentedControl.enabled = NO;
		[_registAnswerButton setTitle:@"解答終了" forState:UIControlStateNormal];
		[_state showAnswerStones];
		//[_gameState showAnswerStones];
	}
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
                                                @"詰碁を登録",@"問題を登録", @"上書き保存する", 
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
	//0:新規ゲーム作成, 1:既存のゲームを開始
	switch (menuId) {
		case 0:
			//クリニックを登録
			break;
		case 1:
			//問題を登録
			break;
		case 2:
			//詰碁を登録
			break;
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
			[self prepareExitGame:QUIT_TSUMEGO_VIEW_TAG];
			break;
		default:
			break;
	}
	[self.popoverView dismissPopoverAnimated:YES];
}


/***************************************************************************************/

/**
 新規のゲームを作成する準備をする。
 もし、既存のゲームが存在したら、保存を促す。
 */
-(void)prepareExitGame:(int)gameType{
	
	NSLog(@"game_records put size is %d", [_currentGame.game_records count]);
	if([_currentGame.is_updated boolValue]){
		[self showSaveAlertView:gameType];
	}else {
		[_currentGame delete];
		//0:新規ゲームの開始, 1:既存のゲームを開始
		switch (gameType) {
			case 0:
				[self startNewGame];
				break;
			case 1:
				[self showSelectExsistedGamesAlertView];
				break;
			case QUIT_TSUMEGO_VIEW_TAG:
				[self showTsumegoShowMode];
				break;
			default:
				break;
		}
	}
}



#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

