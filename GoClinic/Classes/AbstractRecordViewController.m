    //
//  AbstractRecordViewController.m
//  GoClinic
//
//  Created by 猪子 徹 on 10/09/01.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AbstractRecordViewController.h"
#import "BoardView.h"
#import "Global.h"
#import "RecordShowViewController.h"
#import "RecordRegistViewController.h"
#import "NormalShowViewController.h"
#import "NormalRegistViewController.h"
#import "TsumegoShowViewController.h"
#import "TsumegoRegistViewController.h"
#import "QuestionShowViewController.h"
#import "QuestionRegistViewController.h"
#import "ImageManager.h"
#import "Comments.h"
#import "GoClinicAppDelegate.h"
#import "CommentAddViewCell.h"
#import "BranchFukidashiView.h"


@implementation AbstractRecordViewController

@synthesize boardView = _boardView;
@synthesize currentGame = _currentGame;
@synthesize popoverView = _popoverView;

-(id)initWithNibNameAndGame:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil game:(Games*)game{
    if((self = [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil])){
        _currentGame = game;
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initBoardView];
    [self.view addSubview:_boardView];
    
    if(_currentGame != nil){
        [self showGameTitle];
        _currentGame.is_updated = NO;
    }
    [self checkButtonActivate];
    
    //端末回転通知の開始
    [[UIDevice currentDevice] 
     beginGeneratingDeviceOrientationNotifications];
    SEL sel = @selector(didRotate:);
    if([self respondsToSelector:sel]){
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didRotate:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
    }
}


-(void)initBoardView{
    _boardView = [[BoardView alloc] initWithXYSizes:BOARD_SIZE ySize:BOARD_SIZE];
    _boardView.delegate = self;
}



-(BOOL)hideSubViews:(BOOL)animated{
    return YES;
}


//コメントViewを表示させるために、コメント用のViewを表示させるとともに、必要に応じてBoardViewを左にスライドさせる
- (void)showCommentView:(BOOL)animated{}



- (void)commentGoStoneMenu:(id)sender {
	[self showCommentView:YES];
}

- (void)hideCommentView:(BOOL)animated{}


-(void)clearBoard{
	NSEnumerator* e = [_currentGame.game_records objectEnumerator];
	GameRecords* item;
	while ((item = (GameRecords*)[e nextObject]) ) {
		[item.view removeFromSuperview];
	}
}

/**
 現在のゲームの碁石をすべて表示する(Origin)
 @param mode: 0:碁石に手数を表示する 1:碁石に顔を表示する
 */
-(void)showAllRecords:(int)mode{
	NSEnumerator *e = [_currentGame.game_records objectEnumerator];
	GameRecords* item;
	while ((item = [e nextObject]) != nil) {
		item.view.displayMode = mode;
		item.view.delegate = _boardView;
		item.view.stoneOpacity = NORMAL_OPACITY;
        
        NSLog(@"movevv33 is %d", item.view.stoneColorId);
		[self insertGoStoneView:item.view aboveView:_commentViewController.view];
		[_currentGame setStoneArrayXY:[item.x intValue] y:[item.y intValue] stone:item];
	}
    //現在の棋譜を選択状態にする
    [self selectStone:_currentGame.current_record];
}


-(void)showGameTitle{
	if(![_currentGame.title isEqualToString:@""]){
		//add a label to the navbar
		_gameTitleLabel.text = _currentGame.title;
		[_navBar setNeedsDisplay];
	}
}

/**
 ClinicModeを開始する
 既に分岐レコードがある場合は上書きする
 (一階層分岐を掘る) 
 */
-(void)createClinic{
	_currentGame.insertMode = 1;
	[self removeGoStoneViewCyclic:_currentGame.current_record];
	
	NSLog(@"startClinicMode current_record move is %d", [_currentGame.current_record.move intValue]);
	BOOL isFirstRecord = NO;
	if(_currentGame.current_record.prev_game_records == nil){
        //初手の場合
		_currentGame.current_branch_move = [NSNumber numberWithInt:[_currentGame.current_record.move intValue] - 1 ];
		//初手の場合は、stackの一番初めを取り除く
		if ([_currentGame.current_record.move intValue] == 1) {
			[_currentGame.recordStack removeObjectAtIndex:0];
		}
		isFirstRecord = YES;
	}
	
	[_currentGame changeToBranchRecord];
	
	if (!isFirstRecord) {
		_currentGame.current_branch_move = _currentGame.current_record.move;
	}
	
	//現在と同じ階層であり、CurrentMove以降の石をStack及びStonesArrayから取り除く
	[_currentGame popStackToMoveCyclic:_currentGame.current_record.move];

	GameRecords* item;
	for (int i=0; i < _currentGame.xSize; i++) {
		for(int j = 0;j < _currentGame.ySize; j++){
			item = [_currentGame getStoneArrayXY:i y:j];
			if ([item.move intValue] < 0) {
				continue;
			}
			
			if ([item.move intValue] >= [_currentGame.current_record.move intValue] && [item.depth intValue] == _currentGame.currentDepth) {
				[_currentGame setStoneArrayXY:i y:j stone:nil];
			}
		}
	}
	
	[_returnToAboveLevelButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
	[_compareClinicButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    _returnToAboveLevelButton.enabled = YES;
	_compareClinicButton.enabled = YES;
	//階層を一階層下に設定する
	_currentGame.currentDepth ++;
}

/**
 ClinicModeを開始する
 既に分岐レコードがあっても上書きしない
 (一階層分岐を掘る) 
 */
-(void)startClinic{
	_currentGame.insertMode = 1;
	[self removeGoStoneViewCyclic:_currentGame.current_record];
	
	NSLog(@"startClinicMode current_record move is %d", [_currentGame.current_record.move intValue]);
	BOOL isFirstRecord = NO;
	if ([_currentGame.current_record.move intValue] == 1) {
		_currentGame.current_branch_move = [NSNumber numberWithInt:-1];
		isFirstRecord = YES;
	}
	
	//現在と同じ階層であり、CurrentMove以降の石をStack及びStonesArrayから取り除く
	[_currentGame popStackToMoveCyclic:[NSNumber numberWithInt:[_currentGame.current_record.move intValue] - 1]];
	
	//既にブランチレコードが存在する場合は、表示する
	if (_currentGame.current_record.branch_records !=nil) {
        _currentGame.current_record.branch_records.view.stoneOpacity = NORMAL_OPACITY;
		[self insertGoStoneView:_currentGame.current_record.branch_records.view aboveView:_commentViewController.view];
	}
	//[_currentGame changeToBranchRecord];
	if(_currentGame.current_record.branch_records != nil){
		//self.current_record = self.current_record.branch_records;
		//分岐のレコードを再帰的にスタックに格納
		//[self pushRecordToStackCyclic:self.current_record.branch_records.next_game_records];
		[_currentGame pushRecordToStackCyclic:_currentGame.current_record.branch_records];
	
	}else{
		NSLog(@"current_branch_move is %d", [_currentGame.current_branch_move intValue]);
		[_currentGame moveToPrevRecord];
	}
	
	_currentGame.current_record = _currentGame.current_record.branch_records;
	[self selectStone:_currentGame.current_record];
	
	//スタックの最後のレコードをcurrent_branch_moveに設定
	_currentGame.current_branch_move = ((GameRecords*)[_currentGame.recordStack objectAtIndex:[_currentGame.recordStack count] - 1]).move;
	
	
	NSLog(@"moveToClinicMode current_branch_move is %d", [_currentGame.current_branch_move intValue]);
	NSLog(@"moveToClinicMode current_record move is %d", [_currentGame.current_record.move intValue]);
	_returnToAboveLevelButton.enabled = YES;
	_compareClinicButton.enabled = YES;
	
	//現在と同じ階層であり、CurrentMove以降の石をStack及びStonesArrayから取り除く
	GameRecords* item;
	for (int i=0; i < _currentGame.xSize; i++) {
		for(int j = 0;j < _currentGame.ySize; j++){
			item = [_currentGame getStoneArrayXY:i y:j];
			if ([item.move intValue] < 0) {
				continue;
			}
			
			if ([item.move intValue] >= [_currentGame.current_record.move intValue] && [item.depth intValue] == _currentGame.currentDepth) {
				[_currentGame setStoneArrayXY:i y:j stone:nil];
			}
		}
	}
	
	[_returnToAboveLevelButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
	[_compareClinicButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
	//階層を一階層下に設定する
	_currentGame.currentDepth ++;
	
	[_currentGame showStackLog];
}


/**
 ClinicMOdeを終了する
 (一階層分岐を戻る)
 */
-(void)quitClinic{
	if (_currentGame.current_record.root_record == nil) {
		NSLog(@"quit clinic mode. root record is nil");
	}else {
		NSLog(@"quit clinic mode. root record move is %d, x:%d, y:%d, depth:%d", [_currentGame.current_record.root_record.move intValue], 
		  [_currentGame.current_record.root_record.x intValue], [_currentGame.current_record.root_record.y intValue], [_currentGame.current_record.root_record.depth intValue]);
	}
	_currentGame.insertMode = 0;
	//分岐レコードをすべて消去し、現在のレコードをノーマルレコードに設定
	_currentGame.current_root_record = _currentGame.current_record.root_record;
	_currentGame.current_record = _currentGame.current_root_record;
	
	//現在の階層の石をStack及びStonesArrayから取り除く
	GameRecords* record;
	for (int i=[_currentGame.recordStack count] - 1; i >=0; i--) {
		record = [_currentGame.recordStack objectAtIndex:i];
		if ([record.depth intValue] == _currentGame.currentDepth) {
			[record.view removeFromSuperview];
			[_currentGame.recordStack pop];
		}else {
			break;
		}
	}
	GameRecords* item;
	for (int i=0; i < _currentGame.xSize; i++) {
		for(int j = 0;j < _currentGame.ySize; j++){
			item = [_currentGame getStoneArrayXY:i y:j];
			if ([item.move intValue] < 0) {
				continue;
			}
			if ([item.depth intValue] == _currentGame.currentDepth) {
				[_currentGame setStoneArrayXY:i y:j stone:nil];
			}
		}
	}	
	
	_compareClinicButton.enabled = NO;
	[_compareClinicButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
	//階層を一階層上に設定する
	_currentGame.currentDepth--;
	
	//階層をひとつ上がったとき、その階層の石をStack及びStonesArrayに挿入する
	NSMutableArray* tmpRecords = [[NSMutableArray alloc] initWithCapacity:[_currentGame.game_records count]];
	NSEnumerator* e = [_currentGame.game_records objectEnumerator];
	while ((record = (GameRecords*)[e nextObject]) != nil) {
		if([record.depth intValue] == _currentGame.currentDepth){
			[_currentGame setStoneArrayXY:[record.x intValue] y:[record.y intValue] stone:record];
			[tmpRecords addObject:record];
		}
	}
	//tmpRecordsをMove順にソートし、currentMove以降のRecordをStackにPushする
	for (int i=0; i < [tmpRecords count]; i++) {
		for (int j = 0; j < [tmpRecords count]; j++) {
			if([((GameRecords*)[tmpRecords objectAtIndex:i]).move intValue] < [((GameRecords*)[tmpRecords objectAtIndex:j]).move intValue]){
				GameRecords* tmpRecord;
				tmpRecord = (GameRecords*)[tmpRecords objectAtIndex:i];
				[tmpRecords replaceObjectAtIndex:i withObject:(GameRecords*)[tmpRecords objectAtIndex:j]];
				[tmpRecords replaceObjectAtIndex:j withObject:tmpRecord];
			}
		}
	}
	e = [tmpRecords objectEnumerator];
	while ((record = (GameRecords*)[e nextObject]) != nil) {
		if([record.move intValue] >= [_currentGame.current_record.move intValue]){
			[_currentGame.recordStack push:record];	
		}
	}
	
	[self insertGoStoneViewCyclick:_currentGame.current_record toMove:MAX_MOVE opacity:NORMAL_OPACITY isRemovedShow:NO];
	[self selectStone:_currentGame.current_record];
}



-(void)selectStone:(GameRecords*)record{
	NSLog(@"stone move:%d x:%d y:%d is selected." ,[record.move intValue], [record.x intValue], [record.y intValue]);
	
	if (record == nil) {
		_commentTextView.text = @"";
	}else{
		ImageManager* iManager = [ImageManager instance];
		
		if (([record.move intValue] + 1) % 2 == 0) {
			[_bobFaceView setImage:[iManager getBlackImage:[record.face_id intValue]]];
		}else {
			[_bobFaceView setImage:[iManager getWhiteImage:[record.face_id intValue]]];
		}

        [self showRecordComments:record];
	}
	[self unSelectStone:_currentGame.current_record];
	_currentGame.current_record = record;
    
    //ボタン使用の可否を設定
    [self checkButtonActivate];
    
	record.view.stoneOpacity = NORMAL_OPACITY;
	record.view.isHighLighted = YES;
	
	[self insertGoStoneView:record.view aboveView:_commentViewController.view];
	[record.view setNeedsDisplay];
	
}

-(void)showRecordComments:(GameRecords*)record{
    NSEnumerator* e = [record.comments objectEnumerator];
    Comments* comment;
    _commentTextView.text = @"";
    while ((comment = (Comments*)[e nextObject]) != nil) {
        if([_commentTextView.text isEqualToString:@""]){
            _commentTextView.text = comment.text;
        }else{
            _commentTextView.text = [NSString stringWithFormat:@"%@\n%@",_commentTextView.text , comment.text];
        }
    }
}

-(void)setGoStoneViewDispSetting:(GoStoneView*)view{}

-(void)removeFukidashiView:(GoStoneView*)view{
    NSEnumerator* e = [view.subviews objectEnumerator];
    UIView* subView;
    while((subView = (UIView*)[e nextObject]) != nil){
        if([subView isKindOfClass:BranchFukidashiView.class]){
            [subView removeFromSuperview];
        }
    }
}

-(void)unSelectStone:(GameRecords*)record{
	record.view.isHighLighted = NO;
    //分岐噴出しを削除
    [self removeFukidashiView:record.view];
	[record.view setNeedsDisplay];
}

/**
 現在のレコードに対し、各ボタンのOn/Offをチェックする。
 デフォルトでは、"分岐”、"比較"、"次へ"、"前へ"ボタンをチェック
 */
-(void)checkButtonActivate{
    [self checkBranchRecord];
    [self checkComparable];
    [self checkNextRecords];
    [self checkPrevRecords];
}

/**
 現在のレコードに分岐レコードがあるかチェックし、存在する場合は分岐ボタンをアクティブにする
 実戦譜以外の場合は、戻るボタンを有効にする
 */
-(void)checkBranchRecord{
	//分岐レコードが存在する場合
	if(_currentGame.current_record.branch_records == nil){
		_changeToClinicButton.enabled = NO;
		[_changeToClinicButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
	}else{
		_changeToClinicButton.enabled = YES;
		[_changeToClinicButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
	}
	//一番上の階層の場合
	if (_currentGame.current_record.root_record != nil) {
		_returnToAboveLevelButton.enabled = YES;
		[_returnToAboveLevelButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
	}else {
		_returnToAboveLevelButton.enabled = NO;
		[_returnToAboveLevelButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
	}
}

/**
 比較可能かどうかをチェックし、可能な場合は比較ボタンをアクティブにする
 */
-(void)checkComparable{
	if (_currentGame.current_record.root_record != nil) {
		_compareClinicButton.enabled = YES;
		[_compareClinicButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
	}else {
		_compareClinicButton.enabled = NO;
		[_compareClinicButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
	}
}

-(void)checkPrevRecords{
    NSLog(@"current_move is %d", [_currentGame.first_record.move intValue]);
    
    NSLog(@"currentDepth : %d", _currentGame.currentDepth);
    //Prevレコードがある場合、若しくは階層が深い場合
    if((_currentGame.current_record.prev_game_records != nil && [_currentGame.current_record.move intValue] > 0) ||
       (_currentGame.currentDepth > 0 )) {
        _moveToPrevRecordButton.enabled = YES;
		_moveToFirstRecordButton.enabled = YES;
		[_moveToFirstRecordButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    }else{
    //それ以外
		_moveToPrevRecordButton.enabled = NO;
		_moveToFirstRecordButton.enabled = NO;
		[_moveToFirstRecordButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
}

-(void)checkNextRecords{
    NSLog(@"current_move is %d", [_currentGame.first_record.move intValue]);
    if(_currentGame.current_record.next_game_records != nil || (_currentGame.current_record == nil && _currentGame.first_record != nil)){
		_moveToNextRecordButton.enabled = YES;
		_moveToLastRecordButton.enabled = YES;
		[_moveToLastRecordButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    }else{
		_moveToNextRecordButton.enabled = NO;
		_moveToLastRecordButton.enabled = NO;
		[_moveToLastRecordButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
}

/**
 碁石を表示する
 */
-(void)insertGoStoneView:(GoStoneView*)view aboveView:(UIView*)aboveView{
	NSLog(@"view move is %d", view.move);
	if(aboveView != nil){
		[_boardView insertSubview:view belowSubview:aboveView];
		[view setNeedsDisplay];
	}else{
		[_boardView addSubview:view];
		[view setNeedsDisplay];
	}
	[view becomeFirstResponder];	
}


/**
 指定されたGoStoneから、指定された手数まで棋譜を再帰的に表示する
 尚、最後のレコードを返す
 */
-(GameRecords* )insertGoStoneViewCyclick:(GameRecords*)record toMove:(int)toMove opacity:(float)opacity isRemovedShow:(BOOL)isRemovedShow{
	NSLog(@"current record move is %d, x : %d, y : %d", [record.move intValue], [record.x intValue], [record.y intValue]);
	//GameRecordがNULLの場合は終了する
	if((record == nil) || ([record.move intValue] > toMove)){
		return record.prev_game_records;
	}
	
	//record.view.stoneColorId = [_currentGame checkUser:([record.move intValue])];
	record.view.stoneOpacity = opacity;
	record.view.isHighLighted = NO;
	
	if (isRemovedShow || !record.isRemoved) {
		[self insertGoStoneView:record.view aboveView:_commentViewController.view];
	}
	
	if (record.next_game_records == nil) {
		return record;
	}else {
		return [self insertGoStoneViewCyclick:record.next_game_records toMove:toMove  opacity:opacity isRemovedShow:isRemovedShow];
	}
}



/**
 次のGameRecordがNullになるまでGoStoneViewを取り除く
 */
-(void)removeGoStoneViewCyclic:(GameRecords*)record{
	[record.view removeFromSuperview];
	
	NSLog(@"removed revord.move is %d, x:%d, y:%d",[record.move intValue], [record.x intValue], [record.y intValue]);
	if(record.next_game_records != nil){
		[self removeGoStoneViewCyclic:record.next_game_records];
	}
	if (record.branch_records != nil) {
		[self removeGoStoneViewCyclic:record.branch_records];
	}
}


/**
 新規のゲームを開始する
 */
-(void)startNewGame{
	[self clearBoard];
	_currentGame = [self createGame];
	[self initGameInfoControl];
}

-(Games*)createGame{return nil;}

-(void)initGameInfoControl{
	//初期ビュー設定
	_gameTitleLabel.text = @"";
	[self showGameTitle];
}


/**
 既存のゲームを開始する
 */
-(void)showSelectExsistedGamesAlertView{}

/**
 現在のゲームを保存し、全てのフラグをリセットする。
 */
-(void)saveCurrentGame{
	if(_currentGame.isInserted || _currentGame.isUpdated){
		//新規のゲームは新規作成する
		[_currentGame save];
	}
}

/**
 新規のゲームを作成する準備をする。
 もし、既存のゲームが存在したら、保存を促す。
 */
-(void)prepareExitGame:(int)menuId{
	if([_currentGame.is_updated boolValue]){
		[self showSaveAlertView:menuId];
	}else {
		[_currentGame delete];
		//0:新規ゲームの開始, 1:既存のゲームを開始
		switch (menuId) {
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


/**
 * Fromのレコードより前のレコードで、表示されているGoStoneViewを保持しているGameRecordの中で最も手番が多い物を返す
 */
-(GameRecords*)getLastShownGoStoneViewRecord:(GameRecords*)from{
	if (from == nil) {
		return nil;
	}
	if ([from.view isDescendantOfView:_boardView]) {
		NSLog(@"DescendantOfView move is %d", [from.move intValue]);
		return from;
	}
	if (from.prev_game_records != nil) {
		return [self getLastShownGoStoneViewRecord:from.prev_game_records];
	}else {
		return nil;
	}
}

-(void)changePractiveRecordTransparency{
    //実戦譜の半透明度を切り替える
    if(_isPractiveRecordTransparent){
        //実戦譜の表示
        [self insertGoStoneViewCyclick:_currentGame.current_record.root_record
                                toMove:MAX_MOVE opacity:1.0 isRemovedShow:NO];
        //クリニックの表示
        NSEnumerator* e = [_currentGame.recordStack objectEnumerator];
        GameRecords* item;
        while ((item = (GameRecords*)[e nextObject]) != nil) {
            item.view.stoneOpacity = TRANS_OPACITY;
            [self insertGoStoneView:item.view aboveView:_commentView];
        }
    }else{
        
        //クリニックの表示
        NSEnumerator* e = [_currentGame.recordStack objectEnumerator];
        GameRecords* item;
        while ((item = (GameRecords*)[e nextObject]) != nil) {
            item.view.stoneOpacity = NORMAL_OPACITY;
            [self insertGoStoneView:item.view aboveView:_commentView];
        }
        //実戦譜の表示
        [self insertGoStoneViewCyclick:_currentGame.current_record.root_record
                                toMove:MAX_MOVE opacity:0.5 isRemovedShow:NO];
    }
    _isPractiveRecordTransparent = !_isPractiveRecordTransparent;
	_currentGame.current_move = _currentGame.last_record.move;
}

-(int)getCurrentDispMode{
    if(_stoneFaceSwitch.on){
        return  GOSTONE_VIEW_FACE_DISPLAY_MODE;
    }else if(_stoneNumberSwitch.on){
        return GOSTONE_VIEW_MOVE_DISPLAY_MODE;
    }else{
        return GOSTONE_VIEW_NONE_DISPLAY_MODE;
    }
}

-(void)refreshAllGoStoneView{
    NSEnumerator* e = [_currentGame.game_records objectEnumerator];
	GameRecords* item;
	while ((item = (GameRecords*)[e nextObject]) != nil) {
		item.view.displayMode = _stoneDispMode;	
        item.view.showNumber = _stoneNumberSwitch.on;
        item.view.showFace = _stoneFaceSwitch.on;
		[item.view setNeedsDisplay];
	}
	[self selectStone:_currentGame.current_record];
}

-(void)showMenu:(id)sender delegate:(id)delegate{}

-(void)setShownViewToShowView:(BOOL)isStateSaved{
    NSEnumerator* e = [_currentGame.game_records objectEnumerator];
    GameRecords* item;
    while((item = [e nextObject]) != nil){
        if([item.view isDescendantOfView:_boardView]){
            item.is_shown_state = [NSNumber numberWithBool:isStateSaved];
        }else{
            item.is_shown_state = [NSNumber numberWithBool:NO];
        }
    }
}


-(void)checkCurrentNextRecordPuttable:(int)x y:(int)y{
    switch ([_currentGame checkCurrentNextRecordPuttable:x y:y]) {
            UIAlertView* alertView;
        case -1:
            //既に石が置かれていれば置けないようにする
            alertView = [[UIAlertView alloc] initWithTitle:@"情報" message:@"既に石が置かれています。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
            return;
        case -2:			
            //自殺手のため、アラートビューを表示して終了
            alertView = [[UIAlertView alloc] initWithTitle:@"情報" message:@"自殺手です。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
            return;
        default:
            break;
    }
}

-(void)showGoStoneViewAfterPutGoStone:(GameRecords*)record{
    
    //一手前の棋譜
    GameRecords* prev;
    //0:ノーマルの棋譜を入力する. 1:ブランチの棋譜を入力する
    switch (_currentGame.insertMode) {
        case 0:
            //一手前の棋譜を設定する
            prev = _currentGame.current_record;
            break;
        case 1:
            //一手前の棋譜を設定する
            prev = _currentGame.current_record.prev_game_records;
            break;
        default:
            break;
    }
    //Viewの設定
    record.view.stoneOpacity = NORMAL_OPACITY;
    [self insertGoStoneView:record.view aboveView:_commentViewController.view];
    [self insertGoStoneViewCyclick:[[self getLastShownGoStoneViewRecord:prev.prev_game_records] next_game_records] toMove:[record.move intValue] opacity:1.0 isRemovedShow:NO];
}

/***************************************************************************************
 ViewController 表示関連：
 ***************************************************************************************/

/**
 * 棋譜表示モードを開始する
 */
-(void)showNormalShowMode{
    NormalShowViewController* controller = [[NormalShowViewController alloc] initWithNibNameAndGame:@"NormalShowViewController" bundle:nil game:_currentGame];
	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:controller animated:YES];
}

/**
 * 棋譜表示モードを開始する
 */
-(void)showNormalRegistMode{
    NormalRegistViewController* controller = [[NormalRegistViewController alloc] initWithNibNameAndGame:@"NormalRegistViewController" bundle:nil game:_currentGame];
	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:controller animated:YES];
}

/**
 * 詰碁表示モードを開始する
 */
-(void)showTsumegoShowMode{
	TsumegoShowViewController* controller = [[TsumegoShowViewController alloc] initWithNibNameAndGame:@"TsumegoShowViewController" bundle:nil game:_currentGame];
	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:controller animated:YES];
}

/**
 * 詰碁表示モードを開始する
 */
-(void)showTsumegoRegistMode{
    TsumegoRegistViewController* controller = [[TsumegoRegistViewController alloc] initWithNibNameAndGame:@"TsumegoRegistViewController" bundle:nil game:_currentGame];
	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:controller animated:YES];
}

/**
 * 問題表示モードを開始する
 */
-(void)showQuestionShowMode{
    QuestionShowViewController* controller = [[QuestionShowViewController alloc] initWithNibName:@"QuestionShowViewController" bundle:nil];
	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:controller animated:YES];
}

/**
 * 問題登録モードを開始する
 */
-(void)showQuestionRegistMode{
    QuestionRegistViewController* controller = [[QuestionRegistViewController alloc] initWithNibName:@"QuestionRegistViewController" bundle:nil];
	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:controller animated:YES];
}


-(void)showSaveAlertView:(int)gameType{
	UIAlertView* saveAlertView = [[UIAlertView alloc] initWithTitle:@"情報" 
															message:@"現在のゲームを保存しますか？" delegate:self cancelButtonTitle:@"キャンセル" otherButtonTitles:@"保存", @"保存しない", nil];
	saveAlertView.tag = gameType;
	saveAlertView.isAccessibilityElement = YES;
	[saveAlertView show];
	
}

-(BOOL)moveToNextRecord{
    
    if(_currentGame.current_record.next_game_records == nil){
		return NO;	
	}
     
    
	[self unSelectStone:_currentGame.current_record];
	
	GameRecords* record;
	record = [_currentGame moveToNextRecord];
	//半透明表示されている場合があるので、透明度を設定し直す
	if (record == nil) {
        return NO;
    }
    
    record.view.stoneOpacity = NORMAL_OPACITY;
    [self insertGoStoneView:record.view aboveView:_commentViewController.view];
    [self selectStone:record];
	//分岐レコードがある場合は分岐ボタンをアクティブにする
	[self checkButtonActivate];
	
	[self putOffEnclosedStonesFromStack];
	NSLog(@"current_record.move is %d",[_currentGame.current_record.move intValue]);
	NSLog(@"current_move is %d",[_currentGame.current_move intValue]);
    return YES;
}

-(BOOL)moveToPrevRecord{
    
    if(_currentGame.current_record.prev_game_records == nil){
        //階層が深い場合は、分岐点へ戻るとボタンと同じ役割をはたす。
        if (_currentGame.currentDepth > 0) {
            [self quitClinic];
            return YES;
        }
		return NO;	
	}
    
	GameRecords* record;
	[self unSelectStone:_currentGame.current_record];
	record = [_currentGame moveToPrevRecord];
	//半透明表示されている場合があるので、透明度を設定し直す
	if (record == nil) {
        return NO;
	}	
    
    record.view.stoneOpacity = NORMAL_OPACITY;
    [self insertGoStoneView:record.view aboveView:_commentViewController.view];
    [self selectStone:record];
    //現在のレコードのひとつ後のレコードを消去する
    [self removeGoStoneViewCyclic:record.next_game_records];
	//分岐レコードがある場合は分岐ボタンをアクティブにする
	[self checkButtonActivate];
	
	[self putOffEnclosedStonesFromStack];
	NSLog(@"current_record.move is %d",[_currentGame.current_record.move intValue]);
	NSLog(@"current_move is %d",[_currentGame.current_move intValue]);
    return YES;
}

/***************************************************************************************
 IBAction 関連：
 ***************************************************************************************/


-(IBAction)touchNavRightButton:(id)sender{}

-(IBAction)touchMoveToNextRecordButton{
    [self moveToNextRecord];
}

-(IBAction)touchMoveToPrevRecordButton{
	[self moveToPrevRecord];
}

/**
 現在の分岐レコードのルートレコードから、現在の手数迄のノーマルレコードを表示する(一階層上)
 */
-(IBAction)touchCompareClinicButton:(id)sender{
	//ルートレコードがファーストレコードの場合
	NSLog(@"root_record.move is %d, last_record.move is %d",[_currentGame.current_record.root_record.move intValue],
		  [_currentGame.last_record.move intValue]);
    [self changePractiveRecordTransparency];
}

-(IBAction)touchMoveToFirstRecordButton{
    while ([self moveToPrevRecord]) {
        
    }
}

-(IBAction)touchMoveToLastRecordButton{
	while ([self moveToNextRecord]) {
        
    }
}

-(IBAction)touchClinicButton:(id)sender{
	[self startClinic];
}

-(IBAction)touchReturnToAboveLevelButton:(id)sender{
	[self quitClinic];
}

-(IBAction)touchMenuButton:(id)sender{
    if([self.popoverView isPopoverVisible]){
        [self.popoverView dismissPopoverAnimated:YES];
    }else{
        [self showMenu:sender delegate:self];
    }
}

-(IBAction)touchFaceDispSwitch:(id)sender{
    [self changeShowFaceMode:((UISwitch*)sender).on];
    [self refreshAllGoStoneView];
}

-(IBAction)touchMoveDispSwitch:(id)sender{
    [self changeShowNumberMode:((UISwitch*)sender).on];
    [self refreshAllGoStoneView];
}


/***************************************************************************************
 BoardViewDelegate 関連：
 ***************************************************************************************/

-(void) touchForMenuCancelWithStone:(GoStoneView*)stoneView{
	UIMenuController *theMenu = [UIMenuController sharedMenuController];
	if([theMenu isMenuVisible]){
		[theMenu setMenuVisible:NO animated:YES];
	}
}


-(void) moveGoStone:(GoStoneView *)stone toRect:(CGRect)toRect{
}


-(int) checkPutGoStone:(NSSet *)theTouch withEvent:(UIEvent *)event withGoStoneView:(GoStoneView *)stoneView{
	return [_currentGame checkRecordPuttable:stoneView.record];
}


-(void) touchBeganBoardWithStone:(UITouch *)theTouch withEvent:(UIEvent *)event withGoStoneView:(GoStoneView *)stoneView{
}

-(void) touchEndedBoardWithStone:(UITouch *)theTouch withEvent:(UIEvent *)event withGoStoneView:(GoStoneView *)stoneView{
    //TODO 分岐数を表示する
    if(stoneView.record.branch_records != nil){
        CGRect frame = CGRectMake(stoneView.frame.size.width * 3 / 4, -stoneView.frame.size.width * 3 / 4, 0, 0);
        
        //TODO 正常な分岐数を表示する
        //BranchFukidashiView* fukidashiView = [[BranchFukidashiView alloc] initWithBranchNum:frame branchNum:[_currentGame.current_record.branch_records count]];
        BranchFukidashiView* fukidashiView = [[BranchFukidashiView alloc] initWithBranchNum:frame branchNum:1];
        [stoneView addSubview:fukidashiView];
        [fukidashiView setNeedsDisplay];
    }
}


-(void) putGoStone:(GoStoneView *)stoneView x:(int)x y:(int)y{
}


-(void) touchBoard:(UITouch *)theTouch withView:(UIView *)view{
}

-(void) touchForMenuWithStone:(UITouch *)theTouch withEvent:(UIEvent*)event withGoStoneView:(GoStoneView *)stoneView{
}


/***************************************************************************************
 SaveGameAlertViewControllerDelegate 関連：
 ***************************************************************************************/
-(void)touchSaveGameButton:(UIViewController*)viewController{
}

-(void)touchNotSaveGameButton:(UIViewController*)viewController{
}

-(void)touchCancelSaveGameButton:(UIViewController*)viewControllerClass{
    
}

/***************************************************************************************
 GamesPickerAlertViewControllerDelegate 関連：
 ***************************************************************************************/
/**
 ゲーム選択画面で、既存のゲームが選択され、OKボタンが押下されたときに呼び出される
 */
-(void)selectedGamePickerIndex:(id)sender index:(int)index game:(Games*)game viewController:(UIViewController *)viewController{
    //ゲームの遷移先が無い場合
    if(viewController == nil){
        //現在の碁石を全て消去する
        [self clearBoard];
        _currentGame = game;
        _currentGame.current_record = nil;
        _currentGame.isShowFaceMode = _stoneFaceSwitch.on;
        _currentGame.isShowNumberMode = _stoneNumberSwitch.on;
        //ゲームの初期化をする
        [_currentGame restore];
        //ゲームの状態が保存されていた場合は、状態を復元する
        if([_currentGame.is_state_saved boolValue]){
            [self showAllShownStateRecord:GOSTONE_VIEW_MOVE_DISPLAY_MODE];
        }else{
            [self showAllRecords:GOSTONE_VIEW_MOVE_DISPLAY_MODE];
        }
        //ゲームと棋譜の状態保存情報をリセットする
        _currentGame.is_state_saved = [NSNumber numberWithBool:NO];
        [self setShownViewToShowView:NO];
        
        [self initGameInfoControl];
    }else{
        ((AbstractRecordViewController*)viewController).currentGame = game;
        //ゲームが保存されていない場合、SaveAlertViewControllerを表示する
        if (!_currentGame.isInserted && _currentGame.isUpdated && ![_currentGame.is_tmp_game boolValue]) {
            SaveGameAlertViewController* controlelr = [[SaveGameAlertViewController alloc] initWithClass:viewController];
            controlelr.delegate = self;
            [controlelr showAlertView];
            
        }else {
            //他のモードへの遷移
            viewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self presentModalViewController:viewController animated:YES];
        }
    }
}

/***************************************************************************************
 MenuPopOverViewControllerDelegate 関連：
 ***************************************************************************************/

-(void)touchMenuItem:(id)menuItem menuId:(int)menuId{}



-(void)putOffEnclosedStonesFromStack{
	NSMutableArray* enclosed = [_currentGame getEnclosedStonesFromStack:[_currentGame.current_move intValue]];
	NSEnumerator* e = [enclosed objectEnumerator];
	GameRecords* item;
	while ((item = (GameRecords*)[e nextObject])) {
		[item.view removeFromSuperview];
	}	
	[_currentGame showStackLog];
}


-(void)changeShowNumberMode:(BOOL)_bool{
    NSEnumerator* e = [_currentGame.game_records objectEnumerator];
    GameRecords* record;
    while((record = (GameRecords*)[e nextObject])){
        record.view.showNumber = _bool;
    }
    
    _currentGame.isShowNumberMode = _bool;
}

-(void)changeShowFaceMode:(BOOL)_bool{
    NSEnumerator* e = [_currentGame.game_records objectEnumerator];
    GameRecords* record;
    while((record = (GameRecords*)[e nextObject])){
        record.view.showFace = _bool;
    }
    
    _currentGame.isShowFaceMode = _bool;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}



- (void)dealloc {
	[_boardView release];
    [super dealloc];
}

/*
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)__scrollView {
    UIView *view = nil;
    if (_scrollView == __scrollView) {
        view = _scrollView;
    }
    return view;
}*/




@end
