    //
//  RecordShowViewController.m
//  GoClinic
//
//  Created by 猪子 徹 on 10/08/15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Global.h"
#import "NormalShowViewController.h"
#import "NormalRegistViewController.h"
#import "TsumegoShowViewController.h"
#import "CommentAddViewCellController.h"
#import "Comments.h"
#import "GoClinicAppDelegate.h"
#import "BoardView.h"


@implementation RecordShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	_isFaceShownByClinic = NO;
	//現在のゲームが存在する場合は、棋譜を表示する
	if (_currentGame != nil) {
		[self clearBoard];
		[self selectStone:_currentGame.first_record];
		
		//全ての碁石のデリゲート先を表示画面に変更する
		NSEnumerator* items = [_currentGame.game_records objectEnumerator];
		GameRecords* item;
		while((item = (GameRecords*)[items nextObject])){
			item.view.delegate = nil;
		}
	}
    
    [self changeShowFaceMode:_stoneFaceSwitch.on];
    [self changeShowNumberMode:_stoneNumberSwitch.on];
}

-(void)recordRegistViewControllerDidFinish:(NormalRegistViewController *)controller{
	[self dismissModalViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return NO;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(commentGoStoneMenu:)) {
        return YES;
    }
    return NO;
}

- (void)deleteGoStoneMenu:(id)sender {
	[_currentGame.current_record.view removeFromSuperview];
	[_currentGame deleteGameRecord:_currentGame.current_record];
}

-(BOOL)isStonePuttable{
    return !_isStonePut;
}

-(BOOL)hideSubViews:(BOOL)animated{
    return NO;
}

/***************************************************************************************
 *	IBAction 関連；
 ***************************************************************************************/


- (IBAction)touchCompareClinicButton:(id)sender{
	
	//クリニックボタンを押した時、条件により以下の３つの動作が存在する
	//1.currentRecordに分岐レコードが存在する場合、分岐レコードを表示する
	//2.currentRecordに分岐レコードが存在せず、顔表示状態になっている場合、表示されている石の顔を消去する
	//3.currentRecordに分岐レコードが存在せず、顔表示状態になっていない場合、全ての石の顔を表示する
	
	if (_currentGame.current_record.branch_records != nil) {
		//1.currentRecordに分岐レコードが存在する場合、分岐レコードを表示する
		[self startClinic];
	}else {
		[self clearBoard];
		GameRecords* record;
		for (int i =0; i < [_currentGame.recordStack count]; i++) {
			//クリニックボタンで顔尾を表示するのは、分岐レコードが存在するのものだけ
			record = (GameRecords*)[_currentGame.recordStack objectAtIndex:i];
			if (!record.view.isFaceDisplayed && (record.branch_records != nil) && _isFaceShownByClinic) {
				//3.currentRecordに分岐レコードが存在せず、顔表示状態になっていない場合、全ての石の顔を表示する
				record.view.displayMode = GOSTONE_VIEW_FACE_DISPLAY_MODE;
				record.view.isFaceDisplayed = YES;
			}else {
				//2.currentRecordに分岐レコードが存在せず、顔表示状態になっている場合、表示されている石の顔を消去する
				record.view.displayMode = GOSTONE_VIEW_MOVE_DISPLAY_MODE;
				record.view.isFaceDisplayed = NO;
			}
			record.view.stoneOpacity = NORMAL_OPACITY;
			[self insertGoStoneView:record.view aboveView:nil];
			
		}
		_isFaceShownByClinic = !_isFaceShownByClinic;
	}
}


-(IBAction)touchMoveToNextRecordButton{
	GameRecords* record;
	//0:ノーマルの棋譜を入力する. 1:ブランチの棋譜を入力する
	//0手目の場合
	if (_currentGame.current_record == nil) {
		_currentGame.current_record = _currentGame.first_record;
        _currentGame.current_record.view.stoneOpacity = NORMAL_OPACITY;
		[self insertGoStoneView:_currentGame.current_record.view aboveView:_commentViewController.view];
		[self selectStone:_currentGame.current_record];
		//分岐レコードがある場合は分岐ボタンをアクティブにする
		[self checkBranchRecord];
		return;
	}
	if(_currentGame.current_record.next_game_records == nil){
		return;	
	}
	[self unSelectStone:_currentGame.current_record];
	record = [_currentGame moveToNextRecord];
	//半透明表示されている場合があるので、透明度を設定し直す
	if (record != nil) {
        record.view.stoneOpacity = NORMAL_OPACITY;
		[self insertGoStoneView:record.view aboveView:_commentViewController.view];
		[self selectStone:record];
	}
	//分岐レコードがある場合は分岐ボタンをアクティブにする
	[self checkBranchRecord];
	
	NSLog(@"current_move is %d",[_currentGame.current_record.move intValue]);
}


-(IBAction)touchMoveToPrevRecordButton{
	GameRecords* record;
	
	if(_currentGame.current_record.prev_game_records == nil){
		if(_currentGame.current_record.root_record == nil){
			//初手の場合
			[self removeGoStoneViewCyclic:_currentGame.current_record];
			_currentGame.current_record = nil;
			[self selectStone:_currentGame.current_record];
			return;
		}
		//分岐の初手の場合
		return;
	}
	[self unSelectStone:_currentGame.current_record];
	record = [_currentGame moveToPrevRecord];
	//半透明表示されている場合があるので、透明度を設定し直す
	if (record != nil) {
		[self selectStone:record];
		//現在のレコードのひとつ後のレコードを消去する
		[self removeGoStoneViewCyclic:record.next_game_records];
	}
	
	//分岐レコードがある場合は分岐ボタンをアクティブにする
	[self checkBranchRecord];
	
	NSLog(@"current_move is %d",[_currentGame.current_record.move intValue]);
	
}

-(IBAction)touchMoveToFirstRecordButton{
	[self clearBoard];
    _currentGame.current_move = [NSNumber numberWithInt:0];
	_currentGame.current_record = nil;
    [self checkButtonActivate];
}



/***************************************************************************************
 *	BoardViewDelegate 関連；
 ***************************************************************************************/
-(void) touchBeganBoardWithStone:(UITouch *)theTouch withEvent:(UIEvent *)event withGoStoneView:(GoStoneView *)stoneView{	
	[self hideSubViews:YES];
	
	//現在が分岐モードで、タッチした碁石がノーマルレコードの場合、分岐モードを解除する
	NSLog(@"touchGoStone is invoked. stone's x : %d , y : %d at %@", [stoneView.record.x intValue],  [stoneView.record.y intValue], self);
	
	[self unSelectStone:_currentGame.current_record];
	
	NSLog(@"current_record move:%d, current_move:%d",[_currentGame.current_record.move intValue], [_currentGame.current_move intValue]);	
	//現在が分岐モードで、タッチした碁石がノーマルレコードの場合、分岐モードを解除する
	switch(_currentGame.insertMode){
		case 0:
			[self selectStone:stoneView.record];
			[stoneView setNeedsDisplay];
			break;
		case 1:
			break;
		default:
			break;
	}
	
	//分岐レコードがある場合は分岐ボタンをアクティブにする
	[self checkBranchRecord];
}

//-(void) touchEndedBoardWithStone:(UITouch *)theTouch withEvent:(UIEvent *)event withGoStoneView:(GoStoneView *)stoneView{}

-(void) putGoStone:(GoStoneView *)stoneView x:(int)x y:(int)y{
	GameRecords* record = [[GameRecords alloc] initTmpRecord];
    
    if (![self isStonePuttable]) {
		UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"情報" message:@"既に一手置いています。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alertView show];
		[alertView release];
		return;
	}
	
	[_currentGame clearStoneBoard];
	//スタックの内容をx, y座標配列に格納する
	GameRecords* item;
	for (int i=0; i< [_currentGame.recordStack count]; i++) {
		item = [_currentGame.recordStack objectAtIndex:i];
		[_currentGame setStoneArrayXY:[item.x intValue] y:[item.y intValue] stone:item];
	}
    [_currentGame checkCurrentNextRecordPuttable:x y:y];
    
    //recordのViewの設定
    record.view = stoneView;
    stoneView.record = record;
    
	stoneView.move = [_currentGame.current_record.move intValue] + 1;
	record.move = [NSNumber numberWithInt:[_currentGame.current_record.move intValue] + 1];
	stoneView.stoneColorId = [_currentGame checkUser:[record.move intValue]];
    stoneView.displayMode = _stoneDispMode;
    record.user_id = [NSNumber numberWithInt:[_currentGame checkUser:[record.move intValue]]];
    record.depth = [NSNumber numberWithInt:_currentGame.currentDepth];
    record.view.stoneOpacity = NORMAL_OPACITY;
    
    
	[self insertGoStoneView:record.view aboveView:_commentViewController.view];
	[self unSelectStone:_currentGame.current_record];
	[self selectStone:record];
	//既に一手打ったフラグを立てる
	_isStonePut = YES;
}

-(void) touchBoard:(UITouch *)theTouch withView:(UIView *)view{
	[self hideSubViews:YES];
}

/**
 メニューを表示する
 */
-(void) touchForMenuWithStone:(UITouch *)theTouch withEvent:(UIEvent*)event withGoStoneView:(GoStoneView *)stoneView{
	UIMenuController *theMenu = [UIMenuController sharedMenuController];
	if([theMenu isMenuVisible]){
		[theMenu setMenuVisible:NO animated:YES];
	}else{
		[theMenu setTargetRect:stoneView.frame inView:_boardView];
		UIMenuItem *commentMenuItem = [[[UIMenuItem alloc] initWithTitle:@"コメント" action:@selector(commentGoStoneMenu:)] autorelease];
		theMenu.menuItems = [NSArray arrayWithObjects:commentMenuItem, nil];
		[theMenu setMenuVisible:YES animated:YES];
	}
}

-(void) moveGoStone:(GoStoneView *)stone toRect:(CGRect)toRect{
}

-(void) touchForMenuCancelWithStone:(GoStoneView*)stoneView{
}

-(int)  checkPutGoStone:(NSSet *)theTouch withEvent:(UIEvent *)event withGoStoneView:(GoStoneView *)stoneView{
	return -1;	
}




/***************************************************************************************
 *	UIObject 関連；
 ***************************************************************************************/

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)_scrollView {
    return _boardView;
}


- (void)dealloc {
    [super dealloc];
}

@end




