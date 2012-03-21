    //
//  TsumegoShowViewController.m
//  GoClinic
//
//  Created by 猪子 徹 on 11/01/27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Global.h"
#import "TsumegoShowViewController.h"
#import "TsumegoRegistViewController.h"
#import "NormalShowViewController.h"
#import "CommentViewController.h"
#import "TsumegoGames.h"
#import "GoClinicAppDelegate.h"

@interface TsumegoShowViewController(private)
/**
 状態を保存し、詰碁モードを終了する
 */
-(void)quitTsumegoModeWithSaveState;
@end

@implementation TsumegoShowViewController

- (void)viewDidLoad {
    //現在のゲームが存在する場合は、棋譜を表示する
	if (_currentGame != nil && [_currentGame isKindOfClass:[TsumegoGames class]]) {
		((TsumegoGames*)_currentGame).isChallengeRegistMode = YES;	
        //問題文を表示
        _questionLabel.text = ((TsumegoGames*)_currentGame).questionCategory;
	}else{
        _currentGame = nil;
    }
	[super viewDidLoad];	
    
    //置石を表示する
    if(_currentGame != nil){
        NSEnumerator* e = [_currentGame.game_records objectEnumerator];
        GameRecords* item;
        while (((item = (GameRecords*)[e nextObject]) != nil) && [item.is_okiishi boolValue]) {
            [self insertGoStoneView:item.view aboveView:_commentView];
        }
    }

    ((TsumegoGames*)_currentGame).isOkiishiMode = NO;
    _state = [[TsumegoGameState alloc] initWithViewController:self];
}

-(void)initBoardView{
    [super initBoardView];
    _boardView.xSize = BOARD_SIZE13;
    _boardView.ySize = BOARD_SIZE13;
}

/**
 既存のゲームを開始する
 */
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



- (void)showRegistView:(id)sender{
	[self.popoverView dismissPopoverAnimated:YES];
    [self showTsumegoRegistMode];
}

-(BOOL)isStonePuttable{
    return YES;
}

-(void) putGoStone:(GoStoneView *)stoneView x:(int)x y:(int)y{
    //サブビューが表示されている場合は、全てのサブビューを隠して終了
	if ([self hideSubViews:YES]) {
		return;
	}
    
    [self checkCurrentNextRecordPuttable:x y:y];
    
    //ゲームが開始されていない場合は石を置くことが出来ない
	if (_currentGame != nil) {
		[self unSelectStone:_currentGame.current_record];
        GameRecords* newRecord = [_currentGame createNewRecord:x y:y goStoneView:stoneView];
        
		NSLog(@"stack count is %d", [_currentGame.recordStack count]);
        if(newRecord.next_game_records != nil){
            NSLog(@"next_record move : %d, x : %d, y : %d", [newRecord.next_game_records.move intValue], [newRecord.next_game_records.x intValue], [newRecord.next_game_records.y intValue]);
        }
        
        //recordのViewの設定
        newRecord.view = stoneView;
        newRecord.view.showFace = _currentGame.isShowFaceMode;
        newRecord.view.showNumber = _currentGame.isShowNumberMode;
        newRecord.view.move = [newRecord.move intValue];
        stoneView.record = newRecord;
        NSLog(@"New move is %d", [newRecord.move intValue]);
        
		//現在のレコードに関して各ボタンのOn/Offをチェックする
        [self checkButtonActivate];
		
        //石の表示方法を指定する（色等）
        [self setGoStoneViewDispSetting:newRecord.view];
        
        //石を表示する
        [self showGoStoneViewAfterPutGoStone:newRecord];
        
        [self selectStone:newRecord];
		//全ての石を評価し、抜き石を行う. 抜き石は非表示にする
		[self putOffEnclosedStonesFromStack];
	}else{
		UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"情報" message:@"ゲームを開始して下さい" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alertView show];
	}
    
    [_currentGame save];
    
}


/***************************************************************************************
 BoardViewDelegate 関連：
 ***************************************************************************************/

-(int)  checkPutGoStone:(NSSet *)theTouch withEvent:(UIEvent *)event withGoStoneView:(GoStoneView *)stoneView{
	return [_currentGame checkRecordPuttable:stoneView.record];
}

-(void) moveGoStone:(GoStoneView *)stoneView toRect:(CGRect)toRect{
	stoneView.frame = toRect;
	//現在の位置を保存する
	stoneView.originLocation = stoneView.frame;
	
	[_currentGame setStoneArrayXY:[stoneView.record.x intValue] y:[stoneView.record.y intValue] stone:stoneView.record];
	[_currentGame setStoneArrayXY:[stoneView.record.prevX intValue] y:[stoneView.record.prevY intValue] stone:nil];
	
	//全ての石の中で、移動した石に削除された石があったらそれを表示させる
	NSMutableArray* toBeInserted = [[NSMutableArray alloc] init];
	
	
	GameRecords* item;
	GameRecords* inserted;
	for (int i=0; i < [_currentGame.recordStack count]; i++) {
		item = (GameRecords*)[_currentGame.recordStack objectAtIndex:i];
		if ([item.removed_by containsObject:stoneView.record]) {
			[toBeInserted addObject:item];
		}
	}
	
	[_currentGame showStonesXYLog];
	
	NSMutableArray* toBeRemoved = [[NSMutableArray alloc] init];
	NSEnumerator* e = [toBeInserted objectEnumerator];
	while ((item = [e nextObject]) != nil) {
		//表示させる石の中で、既にその位置に石が表示されている場合、表示させない。その場合、手数が後の方の石を表示させる
		NSEnumerator* e2 = [toBeInserted objectEnumerator];
		while ((inserted = [e2 nextObject]) != nil) {
			if (([inserted.x intValue] == [item.x intValue]) && 
				([inserted.y intValue] == [item.y intValue]) && 
				([inserted.move intValue] < [item.move intValue])) {
                [toBeRemoved addObject:inserted];
			}
		}
		
		//石が置いてあり、削除されていない場合は表示候補から取り除く
		if (([[_currentGame getStoneArrayXY:[item.x intValue] y:[item.y intValue]].move intValue] != 0) &&
			![_currentGame getStoneArrayXY:[item.x intValue] y:[item.y intValue]].isRemoved ) {
			[toBeRemoved addObject:item];
			NSLog(@"toBeInserted is move : %d, x : %d, y : %d", [item.move intValue], [item.x intValue], [item.y intValue]);
		}
	}
	[toBeInserted removeObjectsInArray:toBeRemoved];
	
	//全ての石を評価し、抜き石を取得する
	NSMutableArray* enclosed = [_currentGame getEnclosedStonesFromRecord:stoneView.record];
	
	NSLog(@"moved finished. enclosed count is %d", [enclosed count]);
	
	//表示される石の中で、抜き石があったら表示させない
	e = [toBeInserted objectEnumerator];
	while ((item = [e nextObject]) != nil) {
		if ([enclosed containsObject:item]) {
			item.isRemoved = YES;
			[item.view removeFromSuperview];
		}else {
			item.isRemoved = NO;
            item.view.stoneOpacity = NORMAL_OPACITY;
			[self insertGoStoneView:item.view aboveView:_boardView];
		}
	}
	
	//抜き石を削除する
	e = [enclosed objectEnumerator];
	while ((item = [e nextObject]) != nil) {
		item.isRemoved = YES;
		[item.view removeFromSuperview];
	}
	
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
    [self showTsumegoRegistMode];
}


-(IBAction)touchGiveUpButton:(id)sender{
    
}

-(IBAction)touchHintButton:(id)sender{

}

/**
 * 
 */
-(IBAction)touchShowAnswerButton:(id)sender{
	if ([_showAnswerButton.titleLabel.text isEqualToString:@"解答消去"]) {
		//解答消去
		[_showAnswerButton setTitle:@"解答確認" forState:UIControlStateNormal];
		[_state clearAnswerStones];
	}else {
		//解答表示
		[_showAnswerButton setTitle:@"解答消去" forState:UIControlStateNormal];
		[_state showAnswerStones];
	}
}

-(void)quitTsumegoModeWithSaveState{
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
		 bundle:[NSBundle mainBundle] menuList:[[NSMutableArray alloc] initWithObjects:@"既存のゲームを開始", @"クリニックモードを開始", @"問題モードを開始", 
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
			[self showQuestionShowMode];
            break;
		default:
			break;
	}
	[self.popoverView dismissPopoverAnimated:YES];
}

-(void)setGoStoneViewDispSetting:(GoStoneView *)view{
    //先攻後攻で石の色を変える
    if (((TsumegoGames*)_currentGame).isAnswerRegisterMode) {
        view.stoneColorId = [_currentGame checkUser:((TsumegoGames*)_currentGame).answerMove];
		
    }else {
        view.stoneColorId = [[_currentGame getCurrentUserId] intValue];
        view.displayMode = _stoneDispMode;
        
    }
}
/**
 
 */
-(NSMutableArray*)putOffEnclosedStonesFromStackAndNotRemoveView{
	NSMutableArray* enclosed = [_currentGame getEnclosedStonesFromStack:[_currentGame.current_move intValue]];
	GameRecords* item;
	for (int i=0; i< [enclosed count]; i++) {
		item = [enclosed objectAtIndex:i];
		item.isRemoved = YES;
		NSLog(@"enclosed [%d] = move:%d, x:%d, y:%d", i, [item.move intValue],[item.x intValue], [item.y intValue]);
	}
	return enclosed;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}

- (void)dealloc {
    [_navBar release];
    [_commentView release]; 
    [_boardView release];
    [_gameTitleLabel release];
	[_returnToAboveLevelButton release];
	[_changeToClinicButton release];
	[_compareClinicButton release];
	[_moveToFirstRecordButton release];
	[_moveToLastRecordButton release];
	[_moveToNextRecordButton release];
	[_moveToPrevRecordButton release];
    [_stoneNumberSwitch release];
    [_stoneFaceSwitch release];
	[ _bobFaceView release];
	[_commentTextView release];    
	[_currentGame release];
	[_commentViewController release];
    [_popoverView release];
	[_showAnswerButton release];
    [super dealloc];
}


@end
