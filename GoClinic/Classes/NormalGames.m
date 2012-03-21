// 
//  NormalGames.m
//  GoClinic
//
//  Created by 猪子 徹 on 11/02/23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NormalGames.h"
#import "GameRecords.h"
#import "GoStoneView.h"
#import "Global.h"

@implementation NormalGames

-(id)initGames{
	if((self = [[NormalGames alloc] initWithEntity:[NSEntityDescription entityForName:@"NormalGames" inManagedObjectContext:managedObjectContextGlobal] 
					insertIntoManagedObjectContext:managedObjectContextGlobal])){
		[super initGamesWithBoardSize:BOARD_SIZE ySize:BOARD_SIZE];
        self.game_category = [NSNumber numberWithInt:NORMAL_GAME_CATEGORY];
        self.title = [NSString stringWithFormat:@""];
	}
	return self;
}



-(GameRecords*)createOkiishiRecord:(int)x y:(int)y goStoneView:(GoStoneView *)view{
    GameRecords* newRecord;
	//実戦譜の最後の譜のあとに連結させるように修正
    newRecord = [[GameRecords alloc] initNewRecord:self move:0 prev:nil next:nil];
    newRecord.user_id = [NSNumber numberWithInt:GOSTONE_VIEW_BLACK_COLOR_ID];
    newRecord.x = [NSNumber numberWithInt:x];
    newRecord.y = [NSNumber numberWithInt:y];
    newRecord.is_okiishi = [NSNumber numberWithBool:YES];
    newRecord.view = view;
    newRecord.depth = [NSNumber numberWithInt:self.currentDepth];
	newRecord.real_x = [NSNumber numberWithFloat:newRecord.view.frame.origin.x];
    newRecord.real_y = [NSNumber numberWithFloat:newRecord.view.frame.origin.y];
    newRecord.width = [NSNumber numberWithFloat:newRecord.view.frame.size.width];
    newRecord.height = [NSNumber numberWithFloat:newRecord.view.frame.size.height];
    [self setStoneArrayXY:x y:y stone:newRecord];
    newRecord.view.stoneColorId = [newRecord.user_id intValue];
    newRecord.view.record = newRecord;
    
    
    
	//手数は0
	newRecord.move = [NSNumber numberWithInt:0];

    [self.game_records addObject:newRecord];
	
	//Stackの最初に追加
    [self.recordStack insertObject:newRecord atIndex:0];
    
    //盤面に追加
	//[self.recordStack push:newRecord];
	
	return newRecord;
}


-(NSNumber*)getCurrentNextRecodeMove{
    switch (self.insertMode) {
		case 0:
			return [NSNumber numberWithInt:[self.current_move intValue] + 1];
		case 1:
			return [NSNumber numberWithInt:[self.current_branch_move intValue] + 1];
		default:
			break;
	}
    return [NSNumber numberWithInt:0];
}

-(void)dealloc{
	[super dealloc];	
}

@end
