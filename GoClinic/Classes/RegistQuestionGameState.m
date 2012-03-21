//
//  RegistQuestionGameState.m
//  GoClinic
//
//  Created by 猪子 徹 on 11/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RegistQuestionGameState.h"
#import "QuestionMessageRecords.h"

@implementation RegistQuestionGameState

-(GameRecords*)createNewRecord:(int)x y:(int)y goStoneView:(GoStoneView*)view{
    GameRecords* newRecord;
    
	//実戦譜の最後の譜のあとに連結させるように修正
    newRecord = [[QuestionMessageRecords alloc] initNewRecord:_game move:[_game.last_record.move intValue] + 1 prev:nil next:nil];
    newRecord.x = [NSNumber numberWithInt:x];
    newRecord.y = [NSNumber numberWithInt:y];
	
    [_game setQuestionRecordsXY:x y:y record:newRecord];
	return newRecord;
}

@end
