    //
//  RecordRegistViewController.m
//  GoClinic
//
//  Created by 猪子 徹 on 10/08/15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NormalRegistViewController.h"
#import "NormalShowViewController.h"
#import "TsumegoRegistViewController.h"
#import "QuestionRegistViewController.h"
#import "FacesView.h"
#import "Comments.h"
#import "CommentView.h"
#import "CommentAddViewCell.h"
#import "CommentViewCellController.h"
#import "CommentAddViewCellController.h"
#import "DatePickerAlertViewController.h"
#import "DatePickerAlertView.h"
#import "FacesViewCellController.h"
#import "CommentViewCell.h"
#import "FacesViewCell.h"
#import "ImageManager.h"
#import "Games.h"
#import "GameRecords.h"
#import "GoClinicAppDelegate.h"
#import "TextAlertView.h"
#import "GoStoneView.h"
#import "Global.h"
#import "Util.h"
#import "SaveGameAlertViewController.h"

@implementation RecordRegistViewController


#define FREE_FALL_ANIMATION_DURATION 0.30

- (void)viewDidLoad {
	[super viewDidLoad];
    
    //現在のゲームが存在しない場合は、新しいゲームを始める
    if (_currentGame != nil) {
        [_currentGame restore];
        //全ての碁石のデリゲート先を表示画面に変更する
        NSEnumerator* items = [_currentGame.game_records objectEnumerator];
        GameRecords* item;
        while((item = (GameRecords*)[items nextObject])){
            item.view.delegate = _boardView;
        }
    }else {
        [self startNewGame];
    }
    
    [self changeShowFaceMode:_stoneFaceSwitch.on];
    [self changeShowNumberMode:_stoneNumberSwitch.on];
}




- (void)deleteGameRecord:(GameRecords*)record{
    [_currentGame setStoneArrayXY:[record.x intValue] y:[record.y intValue] stone:nil];
	NSLog(@"stone will be deleted. stone's move : %d , x : %d , y : %d at %@", [record.move intValue], [record.x intValue], [record.y intValue], self);	
	[record.view removeFromSuperview];
	[_currentGame deleteGameRecord:record];
}


- (void)showSaveTextAlertView{
	TextAlertView *alert = [[TextAlertView alloc] initWithTitle:@"情報" 
														message:@"ゲーム名を入力して下さい" 
													   delegate:self cancelButtonTitle:@"キャンセル"
											  otherButtonTitles:@"OK", nil];
	alert.textField.keyboardType = UIKeyboardTypeNumberPad;
	alert.tag = SHOW_GAME_SAVE_TEXT_TAG;
	alert.isAccessibilityElement = YES;
	[alert show];
}


- (void)showShowViewWithGame:(Games*)game{}

-(void)initGameInfoControl{
	[super initGameInfoControl];
	_dateTextField.text = [Util convertDateToString:_currentGame.save_date];
}


/***************************************************************************************
 コンテキストメニュー 関連：
 ***************************************************************************************/


- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(commentGoStoneMenu:)) {
        return YES;
    }else if (action == @selector(clinicGoStoneMenu:)) {
		return YES;
	}else if (action == @selector(faceRegistGoStoneMenu:)) {
		return YES;
	}else if (action == @selector(deleteGoStoneMenu:)){
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

- (void)faceRegistGoStoneMenu:(id)sender {
	[self showFacesView:YES];
}

- (void)deleteGoStoneMenu:(id)sender {
    //現在の石以降に石が存在する場合、AlertViewを表示し、削除を促す
    if(_currentGame.current_record.next_game_records != nil){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"情報" 
                                                            message:@"これ以降の全ての手が削除されます。よろしいですか？" 
                                                           delegate:self cancelButtonTitle:@"キャンセル"
                                                  otherButtonTitles:@"OK", nil];
        alert.tag = DELETE_GAMERECORD_VIEW_TAG;
        [alert show];
        
    }else{
        NSLog(@"current_record.x : %d, y : %d", [_currentGame.current_record.x intValue], [_currentGame.current_record.y intValue]);
        
        [self deleteGameRecord:_currentGame.current_record];
        //全ての石を表示する
        GameRecords* item;
        for (int i=0; i < [_currentGame.recordStack count]; i++) {
            item = (GameRecords*)[_currentGame.recordStack objectAtIndex:i];
            item.view.stoneOpacity = NORMAL_OPACITY;
            [self insertGoStoneView:item.view aboveView:_boardView];
        }
        //全ての石を評価し、抜き石を行う. 抜き石は非表示にする
        [self putOffEnclosedStonesFromStack];
        [self selectStone:_currentGame.current_record];
    }
}

/***************************************************************************************
 SubView 関連：
 ***************************************************************************************/

//左側のButtonViewを表示させるために、FacesViewを表示させるとともに、必要に応じてBoardViewを左にスライドさせる
- (void)showFacesView:(BOOL)animated{
    FacesViewController* controller = [[FacesViewController alloc] initWithNibName:@"FacesViewController" bundle:nil];
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


- (void)hideFacesView:(BOOL)animated{
    FacesView* view = (FacesView*)[_boardView viewWithTag:FACES_VIEW_CONTROLLER_TAG];
    if(view){
        int facesViewWidth = view.frame.size.width;
        SEL sel = @selector(removeFromSuperview);
        [view startAnimation:CGRectMake(view.frame.origin.x - facesViewWidth, view.frame.origin.y, 
                                                 view.frame.size.width, view.frame.size.height) sender:view finishedEvent:sel];
    }
}

//コメントViewを表示させるために、コメント用のViewを表示させるとともに、必要に応じてBoardViewを左にスライドさせる
- (void)showCommentView:(BOOL)animated{
    CommentViewController* controller = [[CommentViewController alloc] initWithNibName:@"CommentViewController" bundle:nil mode:0];
    
    controller.comments = [[NSMutableArray alloc] initWithArray:[_currentGame.current_record.comments allObjects]];

    NSLog(@"count is %d", [controller.comments count]);
    controller.view.frame = CGRectMake(DISPLAY_WIDTH,0, controller.view.frame.size.width, _boardView.frame.size.height);
    controller.delegate = self;
    [_boardView addSubview:controller.view];

	[((CommentView*)controller.view) reloadData];
	int commentViewWidth = (int)controller.view.frame.size.width;
	[((CommentView*)controller.view) startAnimation:CGRectMake((int)controller.view.frame.origin.x - commentViewWidth, (int)controller.view.frame.origin.y, 
																		   (int)controller.view.frame.size.width, (int)controller.view.frame.size.height) sender:self finishedEvent:nil];
}


- (void)hideCommentView:(BOOL)animated{
    CommentView* view = (CommentView*)[_boardView viewWithTag:COMMENT_VIEW_CONTROLLER_TAG];
    if(view){
        int viewWidth = view.frame.size.width;
        SEL sel = @selector(removeFromSuperview);
        [view startAnimation:CGRectMake(view.frame.origin.x + viewWidth, view.frame.origin.y, 
                                        view.frame.size.width, view.frame.size.height) sender:view finishedEvent:sel];
        [view.commentAddViewCell.commentTextView resignFirstResponder];
    }
    
}

- (void)saveCurrentGameWithSaveAlertView:(UIViewController*)viewController{
	[self.popoverView dismissPopoverAnimated:YES];
    if ([_currentGame.is_updated boolValue]) {
		//現在のゲームをセーブ
        SaveGameAlertViewController* controller = [[SaveGameAlertViewController alloc] initWithClass:viewController];
        controller.delegate = self;
        [controller showAlertView];
	}else{
        NSLog(@"current game is_inserted : %d", [_currentGame.is_tmp_game intValue]);
        //一度も保存されていないゲームの場合、削除する
        if ([_currentGame.is_tmp_game boolValue]) {
            [_currentGame delete];
        }
		[self showShowViewWithGame:nil];
	}
}

/***************************************************************************************
 IBAction 関連：
 ***************************************************************************************/
-(IBAction)touchNavRightButton:(id)sender{}

-(IBAction)touchPointTextField:(id)sender{}


-(IBAction)touchCategoryTextField:(id)sender{}

-(IBAction)touchDateTextField:(id)sender{
	DatePickerAlertViewController *controller;
	controller = [[DatePickerAlertViewController alloc] initWithTitle:@"情報" message:@"保存日を選択して下さい" cancelButtonTitle:@"キャンセル" okButtonTitle:@"OK"];
	controller.delegate = self;
	[(DatePickerAlertView*)controller.view show];
}



/***************************************************************************************
 UIAlertViewDelegate 関連：
 ***************************************************************************************/

- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex { 
	
	//Gameの名前を付けるためのAlertViewの表示
	if (alertView.tag == SHOW_GAME_SAVE_TEXT_TAG) {
		switch (buttonIndex) {
				//0:キャンセル, 1:保存する, 2:Saveしない,
			case 0:
				if (_prevAlertViewTag == DID_ROTATE_TAG) {
					[self startNewGame];
				}
				return;
			case 1:
				//ファイル名付けてを保存
				if ([((TextAlertView*)alertView).textField.text isEqualToString:@""]) {
					_currentGame.title = @"none";
				}else {
					_currentGame.title = ((TextAlertView*)alertView).textField.text;
				}
				//tmpゲームでは無い
				_currentGame.is_tmp_game = [NSNumber numberWithBool:NO];
				[self saveCurrentGame];
				switch (_prevAlertViewTag) {
					case START_NEW_GAME_TAG:
						[self startNewGame];
						break;
					case START_EXISTED_GAME_TAG:
						[self showSelectExsistedGamesAlertView];
						break;
					case FLIP_TO_SHOW_VIEW_TAG:
						[self showShowViewWithGame:_currentGame];
						break;
					case DID_ROTATE_TAG:
						[self startNewGame];
						break;
					case SHOW_GAME_SAVE_TEXT_TAG:
						[self showTsumegoShowMode];
						break;

					default:
						break;
				}
				return;
			default:
				return;
		}
	}
    
    //GameRecordの複数削除
    if(alertView.tag == DELETE_GAMERECORD_VIEW_TAG){
        switch (buttonIndex) {
				//0:キャンセル, 1:削除
			case 0:
				return;
			case 1:
                [_currentGame deleteGameRecordCyclic:_currentGame.current_record];
        }
    }
	
    //Gameの保存関連
    switch (buttonIndex) {
		//0:キャンセル, 1:保存する, 2:保存しない,
		case 0:
			if (alertView.tag == DID_ROTATE_TAG) {
				//石をもとに戻す
				[self showAllRecords:GOSTONE_VIEW_MOVE_DISPLAY_MODE];
			}
			break;
		case 1:
			_prevAlertViewTag = alertView.tag;
			//既存のゲームであり、tmpゲームでない場合は、同名ファイルを上書きする
			if (!_currentGame.isInserted && _currentGame.isUpdated && ![_currentGame.is_tmp_game boolValue]) {
				[self saveCurrentGame];
				switch (_prevAlertViewTag) {
					case START_NEW_GAME_TAG:
						[self startNewGame];
						break;
					case START_EXISTED_GAME_TAG:
						[self showSelectExsistedGamesAlertView];
						break;
					case FLIP_TO_SHOW_VIEW_TAG:
						[self showShowViewWithGame:_currentGame];
						break;
					case DID_ROTATE_TAG:
						[self startNewGame];
						break;
					case SHOW_GAME_SAVE_TEXT_TAG:
						[self showTsumegoShowMode];
						break;
					default:
						break;
				}
			}else {
				[self showSaveTextAlertView];
			}
			
			break;
		case 2:
			if (_currentGame.isInserted) {
				NSLog(@"current_game is added.");
				[self clearBoard];
				[_currentGame delete];
			}else {
                //TODO deleteでよい？
				[_currentGame delete];
                _currentGame = nil;
			}

			switch (alertView.tag) {
				case START_NEW_GAME_TAG:
					[self startNewGame];
					break;
				case START_EXISTED_GAME_TAG:
					[self showSelectExsistedGamesAlertView];
					break;
				case FLIP_TO_SHOW_VIEW_TAG:
					[self showShowViewWithGame:_currentGame];
					break;
				case FLIP_TO_TSUMEGO_VIEW_TAG:
					[self showTsumegoShowMode];
					break;
				case DID_ROTATE_TAG:
					[self startNewGame];
					break;
				default:
					break;
			}
			break;
		default:
			break;
	}
}  


/***************************************************************************************
 RegistGameAlertViewControllerDelegate 関連：
 ***************************************************************************************/
-(void)touchRegistNewGameButton:(UIViewController*)viewControllerClass{
    //既存のゲームが編集されている場合か、新規のゲームが作成され、一手打たれた場合、保存する
    if ((!_currentGame.isInserted && _currentGame.isUpdated && ![_currentGame.is_tmp_game boolValue]) || 
            (_currentGame.is_updated && [_currentGame.is_tmp_game boolValue])) {
        SaveGameAlertViewController* controlelr = [[SaveGameAlertViewController alloc] initWithClass:viewControllerClass];
        controlelr.delegate = self;
        [controlelr showAlertView];
    }else {
        //他のモードへの遷移
        viewControllerClass.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentModalViewController:viewControllerClass animated:YES];
    }
}

-(void)touchRegistExistedGameButton:(UIViewController*)viewControllerClass{
    NSArray* games = nil;
    if ([viewControllerClass isKindOfClass:[NormalRegistViewController class]]) {
        games = [(GoClinicAppDelegate*)[UIApplication sharedApplication].delegate getNormalGames];
    }else if([viewControllerClass isKindOfClass:[TsumegoRegistViewController class]]){
        games = [(GoClinicAppDelegate*)[UIApplication sharedApplication].delegate getTsumegoGames];
    }else if([viewControllerClass isKindOfClass:[QuestionRegistViewController class]]){
        games = [(GoClinicAppDelegate*)[UIApplication sharedApplication].delegate getQuestionGames];
        
    }
    GamesPickerAlertViewController* controller = [[GamesPickerAlertViewController alloc] initWithTitle:[[NSMutableArray alloc] initWithArray:games] viewController:viewControllerClass];
    controller.delegate = self;
    [controller showAlertView];
}

-(void)touchCancelButton:(UIViewController*)viewControllerClass{
    
}


/***************************************************************************************
 SaveGameAlertViewControllerDelegate 関連：
 ***************************************************************************************/
-(void)touchSaveGameButton:(UIViewController*)viewController{
    //既存のゲームであり、tmpゲームでない場合は、同名ファイルを上書きする
    
    if (!_currentGame.isInserted && _currentGame.is_updated && ![_currentGame.is_tmp_game boolValue]) {
        [self saveCurrentGame];
        
        if (viewController == [self class]) {
            [self startNewGame];
        }else if(viewController == [GamesPickerAlertViewController class]){
            [self showSelectExsistedGamesAlertView];
        }else{
            //他のモードへの遷移
            viewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self presentModalViewController:viewController animated:YES];
        }    
    }else {
        InputGameNameAlertViewController* controller = [[InputGameNameAlertViewController alloc] initWithClass:viewController];
        controller.delegate = self;
        [controller showAlertView];
    }
}

-(void)touchNotSaveGameButton:(UIViewController*)viewController{
    if (_currentGame.isInserted) {
        NSLog(@"current_game is added.");
        [self clearBoard];
        [_currentGame delete];
    }else {
        //TODO deleteでよい？
        [_currentGame delete];
    }
    
    ((AbstractRecordViewController*)viewController).currentGame = nil;
    
    if (viewController == [self class]) {
        [self startNewGame];
    }else if(viewController == [GamesPickerAlertViewController class]){
        [self showSelectExsistedGamesAlertView];
    }else{
        //他のモードへの遷移
        viewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentModalViewController:viewController animated:YES];
    }    
}

-(void)touchCancelSaveGameButton:(UIViewController*)viewControllerClass{
    
}

/***************************************************************************************
 InputGameNameViewControllerDelegate 関連：
 ***************************************************************************************/
-(void)touchSaveOkButton:(UIViewController*)viewController fileName:(NSString*)fileName{
    //ファイル名付けてを保存
    if ([fileName isEqualToString:@""]) {
        _currentGame.title = @"none";
    }else {
        _currentGame.title = fileName;
    }
    //tmpゲームでは無い
    _currentGame.is_tmp_game = [NSNumber numberWithBool:NO];
    [self saveCurrentGame];
    
    if (viewController == [self class]) {
        [self startNewGame];
    }else if(viewController == [GamesPickerAlertViewController class]){
        [self showSelectExsistedGamesAlertView];
    }else{
        //他のモードへの遷移
        viewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentModalViewController:viewController animated:YES];
    }    
}

-(void)touchCancelSaveButton:(UIViewController*)viewControllerClass{
    //ローテーションした場合、新しいゲームを始める
    if (viewControllerClass != nil) {
        [self startNewGame];
    }
}


/***************************************************************************************
 *	CommentViewControllerDelegate 関連；
 ***************************************************************************************/


-(void)touchAddButton:(id)sender comment:(Comments*)comment{
	NSLog(@"Comment's text is %@, category is %d, point is %d",comment.text, [comment.category intValue], [comment.point intValue]); 
	[_currentGame.current_record addCommentsObject:comment];
	//入力コメントをクリア
	((CommentAddViewCellController*)sender).cell.categoryTextField.text = @"";
	((CommentAddViewCellController*)sender).cell.pointTextField.text = @"";
	((CommentAddViewCellController*)sender).cell.commentTextView.text = @"";
	
	[self showRecordComments:_currentGame.current_record];
    [self hideCommentView:YES];
    
}

/***************************************************************************************
 *	FacesViewControllerDelegate 関連；
 ***************************************************************************************/

/**
 * 顔登録メニューで顔ボタンが押されたときに呼ばれるメソッド
 */
-(void)touchFacesTableViewCell:(id)sender faceNumber:(int)faceId comment:(NSString *)comment{
	NSLog(@"face_id is registered.  face_id is %d, move is %d", faceId, [_currentGame.current_record.move intValue]);
	//顔IDと顔IDが登録された手数を登録する
	_currentGame.current_record.face_id  = [NSNumber numberWithInt:faceId];
	_currentGame.current_record.view.faceId = faceId;
	_currentGame.current_record.move_on_face_registered = _currentGame.current_record.move;
   
    //既存のコメントを上書き
    Comments* addedComment = [[Comments alloc] initNewComment];
    addedComment.text = comment;
    _currentGame.current_record.comments = [[NSSet alloc] init];
    [_currentGame.current_record addCommentsObject:addedComment];
    [self showRecordComments:_currentGame.current_record];
	
	[self hideFacesView:YES];
	ImageManager* iManager = [ImageManager instance];
	if (([_currentGame.current_record.move intValue] + 1) % 2 == 0) {
		[_bobFaceView setImage:[iManager getBlackImage:[_currentGame.current_record.face_id intValue]]];
	}else {
		[_bobFaceView setImage:[iManager getWhiteImage:[_currentGame.current_record.face_id intValue]]];
	}
}


/***************************************************************************************
 *	BoardViewDelegate 関連；
 ***************************************************************************************/

-(void) touchBeganBoardWithStone:(UITouch *)theTouch withEvent:(UIEvent *)event withGoStoneView:(GoStoneView *)stoneView{
	[self hideSubViews:YES];
	[stoneView becomeFirstResponder];
	NSLog(@"touchGoStone is invoked. stone's x : %d , y : %d at %@", [stoneView.record.x intValue],  [stoneView.record.y intValue], self);

	NSLog(@"current_record move:%d, current_move:%d",[_currentGame.current_record.move intValue], [_currentGame.current_move intValue]);	

	[self selectStone:stoneView.record];
	[self checkButtonActivate];
}



/**
 * 碁石の移動が完了したときに呼び出されるメソッド
 */
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

-(void) touchBoard:(UITouch *)theTouch withView:(UIView *)view{}

/**
 メニューを表示する
 */
-(void) touchForMenuWithStone:(UITouch *)theTouch withEvent:(UIEvent*)event withGoStoneView:(GoStoneView *)stoneView{
	UIMenuController *theMenu = [UIMenuController sharedMenuController];
	if([theMenu isMenuVisible]){
		[theMenu setMenuVisible:NO animated:YES];
	}else{
		//_currentSelection = stoneView;
		[theMenu setTargetRect:stoneView.frame inView:_boardView];
		UIMenuItem *commentMenuItem = [[[UIMenuItem alloc] initWithTitle:@"コメント" action:@selector(commentGoStoneMenu:)] autorelease];
		UIMenuItem *clinicMenuItem = [[[UIMenuItem alloc] initWithTitle:@"クリニック" action:@selector(clinicGoStoneMenu:)] autorelease];
		UIMenuItem *faceRegistMenuItem = [[[UIMenuItem alloc] initWithTitle:@"顔登録" action:@selector(faceRegistGoStoneMenu:)] autorelease];
		UIMenuItem *deleteMenuItem = [[[UIMenuItem alloc] initWithTitle:@"削除" action:@selector(deleteGoStoneMenu:)] autorelease];
		theMenu.menuItems = [NSArray arrayWithObjects:commentMenuItem, clinicMenuItem, faceRegistMenuItem, deleteMenuItem, nil];
		[theMenu setMenuVisible:YES animated:YES];
	}
}

-(void) touchForMenuCancelWithStone:(GoStoneView*)stoneView{}

-(BOOL)hideSubViews:(BOOL)animated{
    if([_boardView viewWithTag:COMMENT_VIEW_CONTROLLER_TAG] || [_boardView viewWithTag:FACES_VIEW_CONTROLLER_TAG]){
        [self hideCommentView:YES];
        [self hideFacesView:YES];
        return YES;
    }else{
        return NO;
    }
}

-(int)checkPutGoStone:(NSSet *)theTouch withEvent:(UIEvent *)event withGoStoneView:(GoStoneView *)stoneView{
	return [_currentGame checkRecordPuttable:stoneView.record];
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
        
        GameRecords* newRecord = [_currentGame createNewRecord:x y:y goStoneView:stoneView];
        
        //recordのViewの設定
        newRecord.view.showFace = _currentGame.isShowFaceMode;
        newRecord.view.showNumber = _currentGame.isShowNumberMode;
        newRecord.view.move = [newRecord.move intValue];
        
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
 DatePickerAlertViewControllerDelegate 関連：
 ***************************************************************************************/
-(void)selectDate:(id)sender selectedDate:(NSDate*)date{
	_currentGame.save_date = date;
	_dateTextField.text = [Util convertDateToString:date];
}


/***************************************************************************************
 MenuPopOverViewControllerDelegate 関連：
 ***************************************************************************************/

-(void)touchMenuItem:(id)menuItem menuId:(int)menuId{
	//0:新規ゲーム作成, 1:既存のゲームを開始
	switch (menuId) {
		case 0:
			//新規ゲームを作成
			[self prepareExitGame:menuId];
			break;
		case 1:
			//既存のゲームを開始
			[self prepareExitGame:menuId];
			break;
		case 2:
			//詰碁モードを開始
			[self prepareExitGame:FLIP_TO_TSUMEGO_VIEW_TAG];
			break;
		default:
			break;
	}
	[self.popoverView dismissPopoverAnimated:YES];
}

/**
 新規のゲームを作成する準備をする。
 もし、既存のゲームが存在したら、保存を促す。
 */
-(void)prepareExitGame:(int)gameType{
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
			case FLIP_TO_TSUMEGO_VIEW_TAG:
				[self showTsumegoShowMode];
				break;
			default:
				break;
		}
	}
}

/***************************************************************************************
 *	UITextFieldDelegate 関連；
 ***************************************************************************************/

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
	switch (textField.tag) {
		case GAME_DATE_TEXTFIELD:
			return NO;
        case OKIISHI_TEXTFIELD:
            return NO;
		case GAME_SAVE_TEXTFIELD:
			break;
		default:
			break;
	}
	return YES;	
}

/***************************************************************************************
 *	傾き 関連；
 ***************************************************************************************/
//端末の向きの取得
- (void)didRotate:(NSNotification*)notification {
    UIDeviceOrientation orientation=[[notification object] orientation];
	BOOL isRotated = FALSE;
    if (orientation==UIDeviceOrientationLandscapeLeft) {
        NSLog(@"横(左90度回転)");
		[_boardView animateStones:_currentGame.game_records orientation:orientation duration:FREE_FALL_ANIMATION_DURATION];
		isRotated = TRUE;
	} else if (orientation==UIDeviceOrientationLandscapeRight) {
        NSLog(@"横(右90度回転)");
		[_boardView animateStones:_currentGame.game_records orientation:orientation duration:FREE_FALL_ANIMATION_DURATION];
		isRotated = TRUE;
    } else if (orientation==UIDeviceOrientationPortraitUpsideDown) {
        NSLog(@"縦(上下逆)");
    } else if (orientation==UIDeviceOrientationPortrait) {
        NSLog(@"縦");
    } else if (orientation==UIDeviceOrientationFaceUp) {
        NSLog(@"画面が上向き");
    } else if (orientation==UIDeviceOrientationFaceDown) {
        NSLog(@"画面が下向き");
    } 
	
	if (isRotated) {
		UIAlertView* saveAlertView = [[UIAlertView alloc] initWithTitle:@"情報" 
																message:@"現在のゲームを保存しますか？" delegate:self cancelButtonTitle:@"キャンセル" otherButtonTitles:@"保存する", @"保存しない", nil];
		saveAlertView.tag = DID_ROTATE_TAG;
		saveAlertView.isAccessibilityElement = YES;
		[saveAlertView show];
	}
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return NO;
}


- (void)dealloc {
    [super dealloc];
}

@end



