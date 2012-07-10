// 
//  Games.m
//  GoClinic
//
//  Created by 猪子 徹 on 10/10/11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Games.h"
#import "Global.h"
#import "GameRecordStack.h"

@interface Games (private)
/**
 * 自動セーブカウントをひとつ進め、設定された値に到達していたらセーブする
 */
-(void)checkAutoSave;

/**
 * 抜き石チェック時のチェック用の碁盤をクリア                                   
 */
-(void)clearCheckBoard;

/**
 ゲーム初期化時に、レコードに対応するGoStoneViewを再帰的に生成する
 */
-(void)createGoStoneViewCyclic:(GameRecords*)record;

/**
 *現在の碁石の次の手数を取得する
 */
-(NSNumber*)getCurrentNextRecodeMove;

/**
 * 碁石Stackから、指定された手数以後に抜き石された碁石集合を取得する
 */
-(NSMutableArray*)getEnclosedStonesFromStackWithStack:(int)fromMove stack:(NSMutableArray*)stack;

/**
 * 指定された手数から、対戦相手のユーザIDを取得する
 */
-(int)getOpponentUser:(int)move;

/**
 *指定された碁石を打ったユーザのユーザIDを取得する
 */
-(int)getRecordUserId:(GameRecords*)record;

/**
 * 指定された碁石が自殺手かどうかチェックする
 */
-(BOOL)checkSuicide:(GameRecords*)stone x:(int)x y:(int)y;

/**
 * 指定された碁石が自殺手かどうかチェックし、自殺手の場合、囲んでいる碁石集合を取得する
 */
-(NSMutableArray*)checkSuicideAndReturnStones:(GameRecords*)stone x:(int)x y:(int)y;

/**
 * 指定された場所に碁石を置いた場合、抜き石が存在するかチェックする
 */
-(BOOL)doCheckRemoveStone:(int)opponent x:(int)x y:(int)y;

/**
 * 指定された場所に碁石を置いた場合、抜き石が存在するかチェックし、抜き石が存在する場合、抜き石集合を取得する
 */
-(BOOL)doCheckRemoveStoneAndReturnStones:(int)opponent x:(int)x y:(int)y enclosed:(NSMutableArray*)enclosed enclosedBy:(NSMutableSet*)enclosedBy;

/**
 * チェック用基板の指定された場所にチェックする
 */
-(void)setCheckBoardXY:(int)x y:(int)y checked:(BOOL)checked;

/**
 * チェック用基板の指定された場所がチェックされているかどか取得する
 */
-(BOOL)getCheckBoardXY:(int)x y:(int)y;

@end

@implementation Games 

@synthesize boardView = _boardView;
@synthesize recordStack = _recordStack;
@synthesize insertMode = _insertMode;
@synthesize isShowNumberMode = _isShowNumberMode;
@synthesize isShowFaceMode = _isShowFaceMode;
@synthesize isNewBranchRecord = _isNewBranchRecord;
@synthesize currentUserId = _currentUserId;
@synthesize stoneArray = _stoneArray;
@synthesize checkBoard = _checkBoard;
@synthesize autoSaveEnable = _autoSaveEnable;
@synthesize autoSaveInterval = _autoSaveInterval;
@synthesize xSize = _xSize;
@synthesize ySize = _ySize;
@synthesize currentDepth = _currentDepth;

@dynamic title;
@dynamic current_move;
@dynamic current_branch_move;
@dynamic current_record;
@dynamic current_root_record;
@dynamic first_record;
@dynamic last_record;
@dynamic first_user_id;
@dynamic game_category;
@dynamic second_user_id;
@dynamic game_records;
@dynamic first_user;
@dynamic second_user;
@dynamic current_user;
@dynamic is_tmp_game;
@dynamic save_date;
@dynamic is_updated;
@dynamic is_state_saved;


-(id)initGames{
	if((self = [[Games alloc] initWithEntity:[NSEntityDescription entityForName:@"Games" inManagedObjectContext:managedObjectContextGlobal] 
			 insertIntoManagedObjectContext:managedObjectContextGlobal])){
		[self initGamesWithBoardSize:BOARD_SIZE ySize:BOARD_SIZE];
	}
	return self;
}

-(id)initGamesWithBoardSize:(int)xSize ySize:(int)ySize{
	self.current_move = [NSNumber numberWithInt:0];
	self.current_user = nil;
	self.first_user_id = [NSNumber numberWithInt:0];
	self.second_user_id = [NSNumber numberWithInt:0];
	self.game_records = [[NSMutableSet alloc] init];
	self.first_user = [[Users alloc] init];
	self.second_user = [[Users alloc] init];
	self.recordStack = [[NSMutableArray alloc] init];
	self.first_record = nil;
	self.last_record = nil;
	self.stoneArray = [NSMutableArray arrayWithCapacity:(xSize + 1) * (ySize + 1)];
	self.checkBoard = [NSMutableArray arrayWithCapacity:(xSize + 1) * (ySize + 1)];
	self.save_date = [NSDate date];
    self.is_updated = NO;
    self.title = [[NSString alloc] initWithFormat:@""];
	_xSize = xSize;
	_ySize = ySize;
	_autoSaveInterval = 0;
	_autoSaveEnable = NO;
	_currentDepth = 0;
    _okiishiArray = [[NSMutableArray alloc] init];
	for (int i=0; i < xSize+1; i++) {
		for (int j = 0; j < ySize + 1; j++) {
			[self.stoneArray addObject:[NSNumber numberWithBool:NO]];
			[self.checkBoard addObject:[NSNumber numberWithBool:NO]];
		}
	}
	return self;
}

/**
 ゲームをセーブする
 */
-(BOOL)save{
	NSError *error = nil;
	if([self.managedObjectContext save: &error ] == NO ){
		// エラー対策
		return NO;
	}
	return YES;
}


/**
 * ゲームを削除する
 */
-(BOOL)delete{
	[self.managedObjectContext deleteObject:self];
	NSError *error = nil;
	if([self.managedObjectContext save: &error ] == NO ){
		// エラー対策
		return NO;
	}
	return YES;
}

/**
 ゲームを保存せず、初期化する
 */
-(BOOL)reset{
	[self.managedObjectContext reset];
	return YES;
}


/**
 ゲームの初期化を行う。GameRecords, GameRecordsからGoStoneViewを作成し、CurrentRecordを設定する
 */
-(void)restore{
	int current_move = 0;
	if ((self.game_records != nil) && ([self.game_records count] > 0)) {
		NSEnumerator* items = [self.game_records objectEnumerator];
		GameRecords* item;
		while((item = (GameRecords*)[items nextObject])){
			item.view = [[GoStoneView alloc] initWithGameRecords:item];
            item.view.stoneColorId = [item.user_id intValue];//[self getRecordUserId:item];
            NSLog(@"movevv is %d", item.view.stoneColorId);
            item.view.showFace = _isShowFaceMode;
            item.view.showNumber = _isShowNumberMode;
			//分岐レコードがある場合は、そのViewも作成する
			if (item.branch_records != nil) {
				[self createGoStoneViewCyclic:item.branch_records];
			}
			//moveが最大のレコードをCurrentRecordとして設定する
			if([item.move intValue] > current_move){
				[self setNewCurrentRecord:item];
				current_move = [item.move intValue];
			}
		}
	}
	//スタックにレコードを昇順に格納
	if (self.first_record != nil) {
		[self pushRecordToStackCyclic:self.first_record];
	}
	self.current_move = [NSNumber numberWithInt:current_move];
	_boardView = [[BoardView alloc] init];
}



/**
 現在のレコードの次の手のレコードを作成する
 */
-(GameRecords*)createNewRecord:(int)x y:(int)y goStoneView:(GoStoneView*)view{
    GameRecords* newRecord = nil;
    //0:ノーマルの棋譜を入力する. 1:ブランチの棋譜を入力する
    switch (self.insertMode) {
        case 0:
            newRecord = [self createNewNormalRecord:x y:y];
            break;
        case 1:
            newRecord  = [self createNewBranchRecord:x y:y];
            break;
        default:
            break;
    }
    
    newRecord.depth = [NSNumber numberWithInt:self.currentDepth];
    newRecord.user_id = [self getCurrentUserId];
	newRecord.real_x = [NSNumber numberWithFloat:view.frame.origin.x];
    newRecord.real_y = [NSNumber numberWithFloat:view.frame.origin.y];
    newRecord.width = [NSNumber numberWithFloat:view.frame.size.width];
    newRecord.height = [NSNumber numberWithFloat:view.frame.size.height];
    newRecord.view = view;
    view.record = newRecord;
    
    [self setStoneArrayXY:x y:y stone:newRecord];
    self.is_updated = [NSNumber numberWithBool:YES];
    return newRecord;
}




-(NSNumber*)getCurrentUserId{
    return [NSNumber numberWithInt:[self checkUser:[self.current_record.move intValue]]];
}



/**
 現在の手が先行か後攻か判断する
 1:先行 0:後攻
 */
-(int)checkUser:(int)move{
	return 	move % 2;
}


/**
 現在のレコードの一手次のレコードに進める
 @return : 次のレコードのmove.-1の場合は、次の手が存在しないことを示す
 */
-(GameRecords *)moveToNextRecord{
	if(self.current_record.next_game_records != nil){
		[self setNewCurrentRecord:self.current_record.next_game_records];
		return self.current_record;
	}
	return nil;
}

/**
 現在のレコードの一手前のレコードに戻る
 @return : 前のレコードのmove. -1の場合は、次の手が存在しないことを示す。
 */
-(GameRecords *)moveToPrevRecord{
    
    [self setNewCurrentRecord:self.current_record.prev_game_records];
    return self.current_record;
}

/**
 打とうとしている石が、配置可能かどうかを判定する
 */
-(int)checkCurrentNextRecordPuttable:(int)x y:(int)y{
    GameRecords* tmpRecord = [[GameRecords alloc] initTmpRecord];
    
	//一手進める
    tmpRecord.move = [self getCurrentNextRecodeMove];
    //
    tmpRecord.user_id = [self getCurrentUserId];	
	
    NSLog(@"putStone move : %d, user_id : %d", [tmpRecord.move intValue], [tmpRecord.user_id intValue]);		
		
	//x,y座標配列をクリアする
	[self clearStoneBoard];
	//スタックの内容をx, y座標配列に格納する
	[self setStackToXYArray];
    
    //既に石が置かれていれば置けないようにする
    if([self getStoneArrayXY:x y:y] != nil){
        return -1;
    }
    //自殺手かどうか判断する
    if([self checkSuicide:tmpRecord x:x y:y]){
        return -2;
    }
    return 1;
}



-(void)deleteGameRecord:(GameRecords*)record{
	//手順を選択されたひとつ前の手順に戻す
	[self setNewCurrentRecord:record.prev_game_records];
	self.current_record.next_game_records = nil;
	self.current_move = [NSNumber numberWithInt:[record.move intValue] - 1];
	if (self.last_record == record) {
		self.last_record = record.prev_game_records;
	}
	//スタックからレコードを取り除く
	[self.recordStack removeObject:record];
	
    NSLog(@"gamerecords count:%d", [self.game_records count]);
    [self.game_records removeObject:record];
	[record release];
}

/**
 指定したRecord以降のRecordを全て削除する
 */
-(void)deleteGameRecordCyclic:(GameRecords *)record{
    GameRecords* next = record.next_game_records;
    GameRecords* branch = record.branch_records;
    //次のレコードがNilの場合は現在のレコードを削除する
    if(next != nil){
        [self deleteGameRecordCyclic:next];
    }
    if(branch != nil){
        [self deleteGameRecordCyclic:branch];
    }
    [self deleteGameRecord:record];
}



/**
 現在のレコードの一つ下の階層のレコードに移動する
 */
-(BOOL)changeToBranchRecord{
	if(self.current_record.branch_records != nil){
		//分岐のレコードを再帰的にスタックに格納
        [self popStackToMoveCyclic:self.current_record.branch_records.move];
        [_recordStack push:self.current_record.branch_records];
		[self pushRecordToStackCyclic:self.current_record.branch_records];
		return YES;
	}
    NSLog(@"current_branch_move is %d", [self.current_branch_move intValue]);
	[self moveToPrevRecord];
	return NO;
}

/**
 現在のレコードの一つ上の階層のレコードに移動する
 */
-(BOOL)changeToRootRecord{
	if(self.current_record.root_record != nil){
		self.current_record = self.current_record.root_record;
		NSLog(@"changeToNormalRecord current_record move is %d", [self.current_record.move intValue]);
		//一つ上の階層のレコードを再帰的にスタックに格納
        [self popStackToMoveCyclic:self.current_record.move];
        [_recordStack push:self.current_record];
		[self pushRecordToStackCyclic:self.current_record.next_game_records];		
		return YES;
	}
	return NO;
}



-(int)checkRecordPuttable:(GameRecords*)record{
	//既に石が置かれていれば置けないようにする
	if([self getStoneArrayXY:[record.x intValue] y:[record.y intValue]] != nil){
		return -1;
	}
	//自殺手かどうか判断する
	if([self checkSuicide:record x:[record.x intValue] y:[record.y intValue]]){
		return -2;
	}
	return 1;
}



/**
 指定されたレコードの手番迄スタックをpopする
 */
-(void)popStackToMoveCyclic:(NSNumber*)move{
    while ([_recordStack count] > 0) {
		GameRecords* last = (GameRecords*)[_recordStack pop];
		if ((last == nil) || ([last.move intValue] <= [move intValue])) {
            [_recordStack push:last];
			return;
		}
	}
}
		 
/**
 指定されたレコードのNextGameRecordが存在しなくなる迄、再帰的にレコードをスタックに挿入する
 */
 -(void)pushRecordToStackCyclic:(GameRecords*)record{
	 if (record == nil) {
		 return;
	 }	
	 [_recordStack push:record];
	 [self pushRecordToStackCyclic:record.next_game_records];
}



-(NSMutableArray*)getEnclosedStonesFromStack:(int)fromMove{
	return [self getEnclosedStonesFromStackWithStack:fromMove stack:_recordStack];
}


/**
 * 
 */
-(NSMutableArray*)getEnclosedStonesFromRecord:(GameRecords*)item{
	//囲まれた石を格納するリスト
	NSMutableArray* encloseds = [[NSMutableArray alloc] init];
	NSMutableArray* tmpEncloseds = [[NSMutableArray alloc] init];
	
	if ([self getStoneArrayXY:[item.x intValue]-1  y:[item.y intValue]] != nil){
		tmpEncloseds = [self checkSuicideAndReturnStones:[self getStoneArrayXY:[item.x intValue]-1  y:[item.y intValue]] 
													   x:[item.x intValue]-1 y:[item.y intValue]];
		NSLog(@"empEncloseds count is %d", [tmpEncloseds count]);
		if(tmpEncloseds != nil){
			//抜き石フラグを立て,x, y座標配列から取り除く
			NSEnumerator* e = [tmpEncloseds objectEnumerator];
			GameRecords* item;
			while ((item = [e nextObject]) != nil) {
				item.isRemoved = YES;
				[encloseds addObject:item];
			}
		}
	}
	
	
	if ([self getStoneArrayXY:[item.x intValue]+1  y:[item.y intValue]] != nil){
		tmpEncloseds = [self checkSuicideAndReturnStones:[self getStoneArrayXY:[item.x intValue]+1  y:[item.y intValue]] 
													   x:[item.x intValue]+1 y:[item.y intValue]];
		NSLog(@"empEncloseds count is %d", [tmpEncloseds count]);
		if(tmpEncloseds != nil){
			//抜き石フラグを立て,x, y座標配列から取り除く
			NSEnumerator* e = [tmpEncloseds objectEnumerator];
			GameRecords* item;
			while ((item = [e nextObject]) != nil) {
				item.isRemoved = YES;
				[encloseds addObject:item];
			}
		}
	}
	
	if ([self getStoneArrayXY:[item.x intValue]  y:[item.y intValue]-1] != nil){
		tmpEncloseds = [self checkSuicideAndReturnStones:[self getStoneArrayXY:[item.x intValue]  y:[item.y intValue]-1] 
													   x:[item.x intValue] y:[item.y intValue]-1];
		NSLog(@"empEncloseds count is %d", [tmpEncloseds count]);
		if(tmpEncloseds != nil){
			//抜き石フラグを立て,x, y座標配列から取り除く
			NSEnumerator* e = [tmpEncloseds objectEnumerator];
			GameRecords* item;
			while ((item = [e nextObject]) != nil) {
				item.isRemoved = YES;
				[encloseds addObject:item];
			}
		}
	}
	
	if ([self getStoneArrayXY:[item.x intValue]  y:[item.y intValue]+1] != nil){
		tmpEncloseds = [self checkSuicideAndReturnStones:[self getStoneArrayXY:[item.x intValue]  y:[item.y intValue]+1] 
													   x:[item.x intValue] y:[item.y intValue]+1];
		NSLog(@"empEncloseds count is %d", [tmpEncloseds count]);
		if(tmpEncloseds != nil){
			//抜き石フラグを立て,x, y座標配列から取り除く
			NSEnumerator* e = [tmpEncloseds objectEnumerator];
			GameRecords* item;
			while ((item = [e nextObject]) != nil) {
				item.isRemoved = YES;
				[encloseds addObject:item];
			}
		}
	}
	return encloseds;
}


/***************************************************************************************
 抜き石ロジック関連：
 ***************************************************************************************/

/*------------------------------------------------------------------*/
/* 自殺手かどうか調べる                                             */
/*------------------------------------------------------------------*/
-(BOOL)checkSuicide:(GameRecords*)record x:(int)x y:(int)y{
	BOOL rtnVal;
	int opponent;  /* 相手の色 */
	
	/* 仮に石を置く */

	[self setStoneArrayXY:x  y:y stone:record];
	
	/* マークのクリア */
	[self clearCheckBoard];
	
	/* その石は相手に囲まれているか調べる */
	rtnVal = [self doCheckRemoveStone:[record.user_id intValue] x:x y:y];
	
	/* 囲まれているならば自殺手の可能性あり */
	if(rtnVal){
		
		/* 相手の色を求める */
		opponent = [self getOpponentUser:[record.user_id intValue]];
		
		/* その石を置いたことにより、隣の相手の石が取れるなら自殺手ではない */
		if( x > 1 ){
			/* 隣は相手？ */
			if(![record isSameUserId:[[self getStoneArrayXY:x-1  y:y].user_id intValue]]){
				/* 相手の石は囲まれているか？ */
				[self clearCheckBoard];
				rtnVal = [self doCheckRemoveStone:opponent x:x-1 y:y];
				/* 相手の石を取れるので自殺手ではない */
				if( rtnVal == TRUE ){
					/* 盤を元に戻す */
					[self setStoneArrayXY:x y:y stone:nil];
					return NO;
				}
			}

		}
		if( y > 1 ){
			/* 隣は相手？ */
			if(![record isSameUserId:[[self getStoneArrayXY:x y:y-1].user_id intValue]]){
				/* マークのクリア */
				[self clearCheckBoard];
				/* 相手の石は囲まれているか？ */
				rtnVal = [self doCheckRemoveStone: opponent x:x y:y-1];
				/* 相手の石を取れるので自殺手ではない */
				if(rtnVal){
					/* 盤を元に戻す */
					[self setStoneArrayXY:x y:y stone:nil];
					return NO;
				}
			}
		}
		if( x < _xSize ){
			/* 隣は相手？ */
			if(![record isSameUserId:[[self getStoneArrayXY:x+1 y:y].user_id intValue]]){
				/* マークのクリア */
				[self clearCheckBoard];
				/* 相手の石は囲まれているか？ */
				rtnVal = [self doCheckRemoveStone: opponent x:x+1 y:y];
				/* 相手の石を取れるので自殺手ではない */
				if(rtnVal){
					/* 盤を元に戻す */
					[self setStoneArrayXY:x y:y stone:nil];
					return NO;
				}
			}
		}
		if( y < _ySize ){
			/* 隣は相手？ */
			if(![record isSameUserId:[[self getStoneArrayXY:x y:y+1].user_id intValue]]){
				/* マークのクリア */
				[self clearCheckBoard];
				/* 相手の石は囲まれているか？ */
				rtnVal = [self doCheckRemoveStone:opponent x:x y:y+1];
				/* 相手の石を取れるので自殺手ではない */
				if( rtnVal){
					/* 盤を元に戻す */
					[self setStoneArrayXY:x y:y stone:nil];
					return NO;
				}
			}
		}
		
		/* 盤を元に戻す */
		[self setStoneArrayXY:x y:y stone:nil];

		/* 相手の石を取れないなら自殺手 */
		return YES;
		
	}else{
		
		/* 盤を元に戻す */
		[self setStoneArrayXY:x y:y stone:nil];
		/* 囲まれていないので自殺手ではない */
		return NO;
	}
}


-(NSMutableArray*)checkSuicideAndReturnStones:(GameRecords*)record x:(int)x y:(int)y{
	BOOL rtnVal;
	BOOL isNone = FALSE;
	
	/* 仮に石を置く */	
	if ([self getStoneArrayXY:x y:y] == nil) {
		isNone = TRUE;
	}
	[self setStoneArrayXY:x y:y stone:record];
	
	/* マークのクリア */
	[self clearCheckBoard];
	
	
	//囲まれている石を格納する配列
	NSMutableArray* encloseds = [[NSMutableArray alloc] init];
	NSMutableSet* enclosedBy = [[NSMutableSet alloc] init];
	
	/* その石は相手に囲まれているか調べる */
	rtnVal = [self doCheckRemoveStoneAndReturnStones:[record.user_id intValue] x:x y:y enclosed:encloseds enclosedBy:enclosedBy];
	
	/* 囲まれているならば自殺手の可能性あり */
	if(rtnVal){
		if (isNone) {
			[self setStoneArrayXY:x y:y stone:nil];
		}
		
		[encloseds addObject:record];
		//どの石に囲まれているかという情報を格納
		if ([enclosedBy count] > 0) {
			NSEnumerator* e = [encloseds objectEnumerator];
			GameRecords* item;
			while ((item = [e nextObject]) != nil) {
				item.removed_by = enclosedBy; 
			}
		}
		return encloseds;
		
	}else{
		
		/* 盤を元に戻す */
		if (isNone) {
			[self setStoneArrayXY:x y:y stone:nil];
			//_stoneArray[x][y] = nil;
		}
		/* 囲まれていないので自殺手ではない */
		return nil;
	}
}


/*------------------------------------------------------------------*/
/* 座標(x,y)にあるcolor石が相手に囲まれているか調べる               */
/*------------------------------------------------------------------*/
/* 空点があればFALSEを返し、空点がなければTRUEを返す */
-(BOOL)doCheckRemoveStone:(int)opponent x:(int)x y:(int)y{
	BOOL rtn;
	
	/* その場所は既に調べた点ならおしまい */
	if([self getCheckBoardXY:x y:y]){
		return YES;
	}
	
	/* 調べたことをマークする */
	[self setCheckBoardXY:x y:y checked:YES];
	
	/* 何も置かれていないならばおしまい */
	if([self getStoneArrayXY:x y:y] == nil){
		return NO;
	}
	
	/* 同じ色の石ならばその石の隣も調べる */
	if([[self getStoneArrayXY:x y:y] isSameUserId:opponent]){
		/* その石の左(x-1,y)を調べる */
		if( x > 1 ){
			rtn = [self doCheckRemoveStone:opponent x:x-1 y:y];
			if(!rtn){
				return NO;
			}
		}
		/* その石の上(x,y-1)を調べる */
		if( y > 1 ){
			rtn = [self doCheckRemoveStone:opponent x:x y:y-1];
			if(!rtn){
				return NO;
			}
		}
		/* その石の右(x+1,y)を調べる */
		if( x < _xSize ){
			rtn = [self doCheckRemoveStone:opponent x:x+1 y:y];
			if(!rtn){
				return NO;
			}
		}
		/* その石の下(x,y+1)を調べる */
		if( y < _ySize ){
			rtn = [self doCheckRemoveStone:opponent x:x y:y+1];
			if(!rtn){
				return NO;
			}
		}
	}
	
	/* 相手の色の石があった */
	return YES;
}

-(BOOL)doCheckRemoveStoneAndReturnStones:(int)opponent x:(int)x y:(int)y enclosed:(NSMutableArray*)enclosed enclosedBy:(NSMutableSet*)enclosedBy{
	BOOL rtn;
	/* その場所は既に調べた点ならおしまい */
	if ([self getCheckBoardXY:x y:y]) {
		return YES;
	}
	
	/* 調べたことをマークする */
	[self setCheckBoardXY:x y:y checked:YES];
	
	/* 何も置かれていないならばおしまい */
	if ([self getStoneArrayXY:x y:y] == nil) {
		return NO;
	}
	
	/* 同じ色の石ならばその石の隣も調べる */
	if([[self getStoneArrayXY:x y:y] isSameUserId:opponent]){

		[enclosed addObject:[self getStoneArrayXY:x y:y]];
		/* その石の左(x-1,y)を調べる */
		if( x > 1 ){
			rtn = [self doCheckRemoveStoneAndReturnStones:opponent x:x-1 y:y enclosed:enclosed enclosedBy:enclosedBy];
			if (!rtn) {
				return NO;
			}
		}
		/* その石の上(x,y-1)を調べる */
		if( y > 1 ){
			rtn = [self doCheckRemoveStoneAndReturnStones:opponent x:x y:y-1 enclosed:enclosed enclosedBy:enclosedBy];
			if (!rtn) {
				return NO;
			}
		}
		/* その石の右(x+1,y)を調べる */
		if( x < _xSize ){
			rtn = [self doCheckRemoveStoneAndReturnStones:opponent x:x+1 y:y enclosed:enclosed enclosedBy:enclosedBy];
			if (!rtn) {
				return NO;
			}
		}
		/* その石の下(x,y+1)を調べる */
		if( y < _ySize ){
			rtn = [self doCheckRemoveStoneAndReturnStones:opponent x:x y:y+1 enclosed:enclosed enclosedBy:enclosedBy];
			if (!rtn) {
				return NO;
			}
		}
	}

	//囲んでいる石を格納する
	[enclosedBy addObject:[self getStoneArrayXY:x y:y]];
	/* 相手の色の石があった */
	return YES;
}



/***************************************************************************************
 盤面の石操作関連：
 ***************************************************************************************/

/**
 基板をクリアする
 */
-(void)clearStoneBoard
{
	for(int x=0; x < _xSize; x++ ){
		for(int y=0; y < _ySize; y++ ){
			[self setStoneArrayXY:x + 1 y:y + 1 stone:nil];
		}
	}
} 


/*------------------------------------------------------------------*/
/* チェック用の碁盤をクリア                                         */
/*------------------------------------------------------------------*/
-(void)clearCheckBoard
{
	for(int x=0; x < _xSize; x++ ){
		for(int y=0; y < _ySize; y++ ){
			//checkBoard[x][y] = NO;
			[self setCheckBoardXY:x + 1 y:y + 1 checked:NO];
		}
	}
} 

-(void)setStackToXYArray{
	GameRecords* item;
	for (int i=0; i< [self.recordStack count]; i++) {
		item = [self.recordStack objectAtIndex:i];
		if (!item.isRemoved) {
			[self setStoneArrayXY:[item.x intValue] y:[item.y intValue]  stone:item];
		}
	}
}

-(void)setStoneArrayXY:(int)x y:(int)y stone:(GameRecords*)stone{
	if (stone == nil) {
		[self.stoneArray replaceObjectAtIndex:(x + _xSize * y) withObject:[NSNumber numberWithBool:NO]];
	}else {
		[self.stoneArray replaceObjectAtIndex:(x + _xSize * y) withObject:stone];
	}

}

-(GameRecords*)getStoneArrayXY:(int)x y:(int)y{
	if ([[_stoneArray objectAtIndex:(x + _xSize * y)] isKindOfClass:[NSNumber class]]) {
		return nil;
	}else{
		return (GameRecords*)[_stoneArray objectAtIndex:(x + _xSize * y)];
	}
}

-(void)setCheckBoardXY:(int)x y:(int)y checked:(BOOL)checked{
	[self.checkBoard replaceObjectAtIndex:(x + _xSize * y) withObject:[NSNumber numberWithBool:checked]];
}

-(BOOL)getCheckBoardXY:(int)x y:(int)y{
   return [((NSNumber*)[_checkBoard objectAtIndex:(x + _xSize * y)]) boolValue];
}



/***************************************************************************************
 ログ関連：
 ***************************************************************************************/
-(void)showStackLog{
	GameRecords* item;
	for (int i=0; i< [self.recordStack count]; i++) {
		item = [self.recordStack objectAtIndex:i];
		NSLog(@"stackstone [%d] = move:%d, x:%d, y:%d, isRemoved:%d, depth:%d", i, [item.move intValue],[item.x intValue], [item.y intValue], item.isRemoved, [item.depth intValue]);
	}
}

-(void)showStonesXYLog{
	GameRecords* item;
	for (int i=0; i < _ySize; i++) {
		for(int j = 0;j < _xSize; j++){
			item = [self getStoneArrayXY:j y:i];
			if (item == nil || [item.move intValue] < 0) {
				continue;
			}
			NSLog(@"stone[%d][%d] = move:%d, userid : %d, removed : %d, depth : %d", j, i,[item.move intValue], [item.user_id intValue], item.isRemoved, [item.depth intValue]);
		}
	}
	
}




/**
 * 自動セーブカウントをひとつ進め、設定された値に到達していたらセーブする
 */
-(void)checkAutoSave{
	if(++_autoSaveInterval >= AUTO_SAVE_INTERVAL){
		[self save];	
		_autoSaveInterval = 0;
	}
}

/**
 ゲーム初期化時に、レコードに対応するGoStoneViewを再帰的に生成する
 */
-(void)createGoStoneViewCyclic:(GameRecords*)record{
	record.view = [[GoStoneView alloc] initWithGameRecords:record];
	record.view.stoneColorId = [self getRecordUserId:record];
	if (record.next_game_records != nil) {
		[self createGoStoneViewCyclic:record.next_game_records];
	}
}

-(GameRecords*)createOkiishiRecord:(int)x y:(int)y goStoneView:(GoStoneView*)view{
    return nil;
}

/**
 現在のレコードの次の手のレコードを作成する
 */
-(GameRecords*)createNewNormalRecord:(int)x y:(int)y{
	GameRecords* newRecord;
	//実戦譜の最後の譜のあとに連結させるように修正
    newRecord = [[GameRecords alloc] initNewRecord:self move:[self.current_move intValue] prev:self.last_record next:nil];
    newRecord.x = [NSNumber numberWithInt:x];
    newRecord.y = [NSNumber numberWithInt:y];
	
	//現在の手の次の手数を設定する
	newRecord.move = [NSNumber numberWithInt:[self.last_record.move intValue] + 1];
	//一番初めの棋譜の場合
	if(self.first_record == nil){
		NSLog(@"self.first is : %@, self.last is : %@", [self.first_record description], [self.last_record description]);
		self.first_record = newRecord;
		self.last_record = newRecord;
	}
	
	//NormalRecordで、一番最後の手の場合、last_recordを入れ替える
	if([self.last_record.move intValue] < [newRecord.move intValue]){
		self.last_record = newRecord;
	}
	[self setNewCurrentRecord:newRecord];
    self.current_move = newRecord.move;
	self.current_record.view.move = [self.current_move intValue];
	[(NSMutableSet*)
	 self.game_records addObject:newRecord];
	
	//Stackに追加
	[self.recordStack push:newRecord];
	
	return newRecord;
}

/**
 分岐レコードを生成する。
 current_branch_recordがある場合は、current_branch_recordに連結させる
 current_branch_recordがない場合は、current_recordの分岐レコードを挿入する
 */
-(GameRecords*)createNewBranchRecord:(int)x y:(int)y{
	NSLog(@"createBranchGameRecord current_record move is %d", [self.current_record.move intValue]);
	NSLog(@"createBranchGameRecord current_branch_move is %d", [self.current_branch_move intValue]);
    
    self.current_branch_move = [NSNumber numberWithInt:[self.current_branch_move intValue] + 1];
	GameRecords* newRecord = [[GameRecords alloc] initNewRecord:self move:[self.current_branch_move intValue] prev:nil next:nil];
    newRecord.x = [NSNumber numberWithInt:x];
    newRecord.y = [NSNumber numberWithInt:y];
	if (_isNewBranchRecord) {
		//CurrentRecordMoveが0, およびクリニックモードの初手の場合
		if (([self.current_branch_move intValue] == 1) ||
			([((GameRecords*)[_recordStack objectAtIndex:[_recordStack count] - 1]).depth intValue] < _currentDepth - 1)) {
			newRecord.root_record = self.current_record;
		}else {
			newRecord.root_record = self.current_record.next_game_records;
		}
		
		self.current_root_record = newRecord.root_record;
		newRecord.root_record.branch_records = newRecord;
		_isNewBranchRecord = NO;
		
		if ([self.current_branch_move intValue] == 1) {
			[_recordStack push:newRecord];
		}else {
            [self popStackToMoveCyclic:newRecord.move];
            [_recordStack push:newRecord];
		}
        
	}else{
		newRecord.root_record = self.current_root_record;
		self.current_record.next_game_records = newRecord;
		newRecord.prev_game_records = self.current_record;
		//stackに追加
		[_recordStack push:newRecord];
	}
    
	self.current_record = newRecord;
	[self.game_records addObject:newRecord];
	NSLog(@"create branch. current_branch_record is move:%d, x:%d, y:%d", [self.current_record.move intValue], [self.current_record.x intValue], [self.current_record.y intValue]);
	
	//自動セーブチェックを行う
	if(_autoSaveEnable){
		[self checkAutoSave];
	}
	
	return newRecord;
}


-(NSNumber*)getCurrentNextRecodeMove{
    return nil;
}


-(NSMutableArray*)getEnclosedStonesFromStackWithStack:(int)fromMove stack:(NSMutableArray*)stack{
	//囲まれた石を格納するリスト
	NSMutableArray* encloseds = [[NSMutableArray alloc] init];
	NSMutableArray* tmpEncloseds = [[NSMutableArray alloc] init];
	[self clearStoneBoard];
	for (int i = 0; i < [stack count]; i++) {
		GameRecords* item;
		item = [stack objectAtIndex:i];
		//抜き石フラグを初期化する
		if (!item.isRemoved) {
			[self setStoneArrayXY:[item.x intValue]  y:[item.y intValue] stone:item];
		}
	}
    
    [self showStonesXYLog];
	
	//初手から順に評価していく
	if ([stack count] <= 0) {
		return encloseds;
	}
	for (int i=[stack count] - 1 ; i >= [self.current_move intValue] - 1; i--) {
		//i番目の石をx, y座標配列に格納する
		GameRecords* item;
		item = [stack objectAtIndex:i];
		//抜き石フラグを初期化する
		item.isRemoved = NO;
		
		NSLog(@"stackstone [%d] = move:%d, x:%d, y:%d, current_move:%d", i, [item.move intValue],[item.x intValue], [item.y intValue], [self.current_move intValue]);
		/*NSLog(@"at %d evaled. stone[%d][%d] = move:%d", j , [item.x intValue], [item.y intValue], 
		 [((GameRecords*)_stoneArray[[item.x intValue]][[item.y intValue]]).move intValue]);*/
		
		//置いた石の前後左右の石に対し、指定された碁石を置いた時に抜くことが可能な石を取得する
		if ([self getStoneArrayXY:[item.x intValue]-1  y:[item.y intValue]] != nil){
			tmpEncloseds = [self checkSuicideAndReturnStones:[self getStoneArrayXY:[item.x intValue]-1  y:[item.y intValue]] 
														   x:[item.x intValue]-1 y:[item.y intValue]];
			NSLog(@"empEncloseds count is %d", [tmpEncloseds count]);
			if(tmpEncloseds != nil){
				//抜き石フラグを立て,x, y座標配列から取り除く
				NSEnumerator* e = [tmpEncloseds objectEnumerator];
				GameRecords* item;
				while ((item = [e nextObject]) != nil) {
					item.isRemoved = YES;
					item.removed_move = self.current_record.move;
					[encloseds addObject:item];
				}
			}
		}
		
		
		if ([self getStoneArrayXY:[item.x intValue]+1  y:[item.y intValue]] != nil){
			tmpEncloseds = [self checkSuicideAndReturnStones:[self getStoneArrayXY:[item.x intValue]+1  y:[item.y intValue]] 
														   x:[item.x intValue]+1 y:[item.y intValue]];
			NSLog(@"empEncloseds count is %d", [tmpEncloseds count]);
			if(tmpEncloseds != nil){
				//抜き石フラグを立て,x, y座標配列から取り除く
				NSEnumerator* e = [tmpEncloseds objectEnumerator];
				GameRecords* item;
				while ((item = [e nextObject]) != nil) {
					item.isRemoved = YES;
					item.removed_move = self.current_record.move;
					[encloseds addObject:item];
				}
			}
		}
		
		if ([self getStoneArrayXY:[item.x intValue]  y:[item.y intValue]-1] != nil){
			tmpEncloseds = [self checkSuicideAndReturnStones:[self getStoneArrayXY:[item.x intValue]  y:[item.y intValue]-1] 
														   x:[item.x intValue] y:[item.y intValue]-1];
			NSLog(@"empEncloseds count is %d", [tmpEncloseds count]);
			if(tmpEncloseds != nil){
				//抜き石フラグを立て,x, y座標配列から取り除く
				NSEnumerator* e = [tmpEncloseds objectEnumerator];
				GameRecords* item;
				while ((item = [e nextObject]) != nil) {
					item.isRemoved = YES;
					item.removed_move = self.current_record.move;
					[encloseds addObject:item];
				}
			}
		}
		
		if ([self getStoneArrayXY:[item.x intValue]  y:[item.y intValue]+1] != nil){
			tmpEncloseds = [self checkSuicideAndReturnStones:[self getStoneArrayXY:[item.x intValue]  y:[item.y intValue]+1] 
														   x:[item.x intValue] y:[item.y intValue]+1];
			NSLog(@"empEncloseds count is %d", [tmpEncloseds count]);
			if(tmpEncloseds != nil){
				//抜き石フラグを立て,x, y座標配列から取り除く
				NSEnumerator* e = [tmpEncloseds objectEnumerator];
				GameRecords* item;
				while ((item = [e nextObject]) != nil) {
					item.isRemoved = YES;
					item.removed_move = self.current_record.move;
					[encloseds addObject:item];
				}
			}
		}
		[self setStoneArrayXY:[item.x intValue]  y:[item.y intValue] stone:item];
	}
	return encloseds;
}

-(int)getOpponentUser:(int)move{
	return move % 2 == 0 ? 1 : 0;
}

-(int)getRecordUserId:(GameRecords*)record{
    return [self checkUser:[record.move intValue]];
}


-(void)setNewCurrentRecord:(GameRecords *)newRecord{
	if(self.current_record != newRecord){
		newRecord.view.isHighLighted = YES;
		[newRecord.view setNeedsDisplay];
		self.current_record = newRecord;
	}
}

-(void)dealloc{
	[super dealloc];	
}

@end
