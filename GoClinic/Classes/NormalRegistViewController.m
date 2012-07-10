    //
//  NormalRegistViewController.m
//  GoClinic
//
//  Created by 猪子 徹 on 11/02/15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NormalRegistViewController.h"
#import "NormalShowViewController.h"
#import "TsumegoRegistViewController.h"
#import "QuestionRegistViewController.h"
#import "NormalGames.h"
#import "GoClinicAppDelegate.h"
#import "StringUtil.h"

@interface NormalRegistViewController(private)
/**
 置石を登録する
 @param record 登録する置石
 */
-(void)putOkiishi:(GameRecords*)record;
@end

@implementation NormalRegistViewController


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
-(void)viewDidLoad {
    //現在のゲームが存在する場合は、棋譜を表示する
	if (_currentGame != nil && [_currentGame isKindOfClass:[NormalGames class]]) {
        
	}else{
        _currentGame = nil;
    }
    [super viewDidLoad];
    
    //初手を表示
    [self selectStone:_currentGame.first_record];

    //ゲームの日付を表示
    _dateLabel.text = [StringUtil convertDateToString:_currentGame.save_date];
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
	controller.delegate = self;
	[controller showAlertView];
}


-(Games*)createGame{
    return [[NormalGames alloc] initGames];
}

/**
 新規のゲームを開始する
 */
-(void)startNewGameNoResetBoard{
	[_currentGame clearStoneBoard];
	_currentGame = [[NormalGames alloc] initGames];
	_currentGame.current_user = _currentGame.first_user;
	_currentGame.boardView = _boardView;
	
	//初期ビュー設定
	_gameTitleLabel.text = @"";
}

- (void)showShowViewWithGame:(Games*)game{
    _currentGame = game;
    [self showNormalShowMode];
}

-(void)setGoStoneViewDispSetting:(GoStoneView *)view{
    view.stoneColorId = [[_currentGame getCurrentUserId] intValue];
    view.displayMode = _stoneDispMode;
}


/***************************************************************************************
 RegistGameAlertViewControllerDelegate 関連：
 ***************************************************************************************/


/***************************************************************************************
 GamesPickerAlertViewControllerDelegate 関連：
 ***************************************************************************************/


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
	//0:新規ゲーム作成, 1:既存のゲームを開始
    RegistGameAlertViewController* controller;
    NormalRegistViewController* nController = [[NormalRegistViewController alloc] initWithNibNameAndGame:@"NormalRegistViewController" bundle:nil game:nil];
    TsumegoRegistViewController* tController = [[TsumegoRegistViewController alloc] initWithNibNameAndGame:@"TsumegoRegistViewController" bundle:nil game:nil];
    QuestionRegistViewController* qController = [[QuestionRegistViewController alloc] initWithNibNameAndGame:@"QuestionRegistViewController" bundle:nil game:nil]
    ;
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


-(void)selectNumOfOkiishi:(id)sender selectedNum:(int)selectedNum{
    //置石を盤面及び、Stackから取り除く
    
	_okiishiNum = selectedNum;
	_okiishiTextField.text = [NSString stringWithFormat:@"%d", selectedNum];
    
    if(!_okiishiArray){
        _okiishiArray = [[NSMutableArray alloc] initWithCapacity:9];
        [_okiishiArray addObject:[_boardView createGameRecords:4 y:4]];
        [_okiishiArray addObject:[_boardView createGameRecords:10 y:4]];
        [_okiishiArray addObject:[_boardView createGameRecords:16 y:4]];
        [_okiishiArray addObject:[_boardView createGameRecords:4 y:10]];
        [_okiishiArray addObject:[_boardView createGameRecords:10 y:10]];
        [_okiishiArray addObject:[_boardView createGameRecords:16 y:10]];
        [_okiishiArray addObject:[_boardView createGameRecords:4 y:16]];
        [_okiishiArray addObject:[_boardView createGameRecords:10 y:16]];
        [_okiishiArray addObject:[_boardView createGameRecords:16 y:16]];
    }
    //置石を設定する処理
    switch (_okiishiNum) {
        case 2:
            //[16,4], [4,16]
            [self putOkiishi:(GameRecords*)[_okiishiArray objectAtIndex:2]];
            [self putOkiishi:(GameRecords*)[_okiishiArray objectAtIndex:6]];
            break;
        case 3:
            //[16,4], [4,16], [16,16]
            [self putOkiishi:(GameRecords*)[_okiishiArray objectAtIndex:2]];
            [self putOkiishi:(GameRecords*)[_okiishiArray objectAtIndex:6]];
            [self putOkiishi:(GameRecords*)[_okiishiArray objectAtIndex:8]];
            break;
        case 4:
            //[16,4], [4,16], [16,16], [4,4]
            [self putOkiishi:(GameRecords*)[_okiishiArray objectAtIndex:0]];
            [self putOkiishi:(GameRecords*)[_okiishiArray objectAtIndex:2]];
            [self putOkiishi:(GameRecords*)[_okiishiArray objectAtIndex:6]];
            [self putOkiishi:(GameRecords*)[_okiishiArray objectAtIndex:8]];
            break;
        case 5:
            //[16,4], [4,16], [16,16], [4,4], [10, 10]
            [self putOkiishi:(GameRecords*)[_okiishiArray objectAtIndex:0]];
            [self putOkiishi:(GameRecords*)[_okiishiArray objectAtIndex:2]];
            [self putOkiishi:(GameRecords*)[_okiishiArray objectAtIndex:4]];
            [self putOkiishi:(GameRecords*)[_okiishiArray objectAtIndex:6]];
            [self putOkiishi:(GameRecords*)[_okiishiArray objectAtIndex:8]];
            break;
        case 6:
            //[16,4], [4,16], [16,16], [4,4], [4, 10], [16, 10]
            [self putOkiishi:(GameRecords*)[_okiishiArray objectAtIndex:0]];
            [self putOkiishi:(GameRecords*)[_okiishiArray objectAtIndex:2]];
            [self putOkiishi:(GameRecords*)[_okiishiArray objectAtIndex:3]];
            [self putOkiishi:(GameRecords*)[_okiishiArray objectAtIndex:5]];
            [self putOkiishi:(GameRecords*)[_okiishiArray objectAtIndex:6]];
            [self putOkiishi:(GameRecords*)[_okiishiArray objectAtIndex:8]];
            break;
        case 7:
            //[16,4], [4,16], [16,16], [4,4], [4, 10], [16, 10], [10, 10]
            [self putOkiishi:(GameRecords*)[_okiishiArray objectAtIndex:0]];
            [self putOkiishi:(GameRecords*)[_okiishiArray objectAtIndex:2]];
            [self putOkiishi:(GameRecords*)[_okiishiArray objectAtIndex:3]];
            [self putOkiishi:(GameRecords*)[_okiishiArray objectAtIndex:4]];
            [self putOkiishi:(GameRecords*)[_okiishiArray objectAtIndex:5]];
            [self putOkiishi:(GameRecords*)[_okiishiArray objectAtIndex:6]];
            [self putOkiishi:(GameRecords*)[_okiishiArray objectAtIndex:8]];
            break;
        case 8:
            //[16,4], [4,16], [16,16], [4,4], [4, 10], [16, 10], [10, 4], [10, 16]
            [self putOkiishi:(GameRecords*)[_okiishiArray objectAtIndex:0]];
            [self putOkiishi:(GameRecords*)[_okiishiArray objectAtIndex:1]];
            [self putOkiishi:(GameRecords*)[_okiishiArray objectAtIndex:2]];
            [self putOkiishi:(GameRecords*)[_okiishiArray objectAtIndex:3]];
            [self putOkiishi:(GameRecords*)[_okiishiArray objectAtIndex:5]];
            [self putOkiishi:(GameRecords*)[_okiishiArray objectAtIndex:6]];
            [self putOkiishi:(GameRecords*)[_okiishiArray objectAtIndex:7]];
            [self putOkiishi:(GameRecords*)[_okiishiArray objectAtIndex:8]];
            break;
        case 9:
            //[16,4], [4,16], [16,16], [4,4], [4, 10], [16, 10], [10, 4], [10, 16], [10, 10]
            [self putOkiishi:(GameRecords*)[_okiishiArray objectAtIndex:0]];
            [self putOkiishi:(GameRecords*)[_okiishiArray objectAtIndex:1]];
            [self putOkiishi:(GameRecords*)[_okiishiArray objectAtIndex:2]];
            [self putOkiishi:(GameRecords*)[_okiishiArray objectAtIndex:3]];
            [self putOkiishi:(GameRecords*)[_okiishiArray objectAtIndex:4]];
            [self putOkiishi:(GameRecords*)[_okiishiArray objectAtIndex:5]];
            [self putOkiishi:(GameRecords*)[_okiishiArray objectAtIndex:6]];
            [self putOkiishi:(GameRecords*)[_okiishiArray objectAtIndex:7]];
            [self putOkiishi:(GameRecords*)[_okiishiArray objectAtIndex:8]];
            break;
        default:
            break;
    }
}


/***************************************************************************************
 IBAction 表示関連：
 ***************************************************************************************/
-(IBAction)touchNavRightButton:(id)sender{
    NormalShowViewController* controller  = [[NormalShowViewController alloc] initWithNibNameAndGame:@"NormalShowViewController" bundle:nil game:_currentGame];
    [self saveCurrentGameWithSaveAlertView:controller];
}

-(IBAction)touchNavLeftButton:(id)sender{}

-(IBAction)touchOkiishiTextField:(id)sender{
    NSMutableArray* okiishiArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < OKIISHI_MAX; i++) {
        [okiishiArray addObject:(i == 0) ? [NSString stringWithFormat:@"%d", i] : [NSString stringWithFormat:@"%d", i + 1]];
    }
    
	OkiishiPickerAlertViewController *controller;
	controller = [[OkiishiPickerAlertViewController alloc] initWithTitle:@"情報" message:@"置石を選択して下さい" cancelButtonTitle:@"キャンセル" okButtonTitle:@"OK" pickerList:okiishiArray];
	controller.delegate = self;
    [controller showAlertView];
}

/***************************************************************************************
 Private：
 ***************************************************************************************/

-(void)putOkiishi:(GameRecords*)record{
    //サブビューが表示されている場合は、消去する
	[self hideSubViews:YES];
   
    [self checkCurrentNextRecordPuttable:[record.x intValue] y:[record.y intValue]];
	
	if (_currentGame != nil) {
        //盤面、及びStackの最初に追加
        GameRecords* newRecord = [_currentGame createOkiishiRecord:[record.x intValue] y:[record.y intValue] goStoneView:record.view];
        
        //recordのViewの設定
        newRecord.view.showFace = _currentGame.isShowFaceMode;
        newRecord.view.showNumber = _currentGame.isShowNumberMode;
        newRecord.view.move = [newRecord.move intValue];
    
        //石の表示方法を指定する（色等）
        newRecord.view.displayMode = _stoneDispMode;
        
        //石を表示する
        [self showGoStoneViewAfterPutGoStone:newRecord];
        
		//全ての石を評価し、抜き石を行う. 抜き石は非表示にする
		//[self putOffEnclosedStonesFromStack];
	}else{
		UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"情報" message:@"ゲームを開始して下さい" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alertView show];
	}
    
    [_currentGame save];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}

- (void)dealloc {
    [super dealloc];
}


@end
