//
//  NormalQuestionGameState.m
//  GoClinic
//
//  Created by 猪子 徹 on 11/06/09.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NormalQuestionGameState.h"

@implementation NormalQuestionGameState


-(GameRecords*)createNewRecord:(int)x y:(int)y goStoneView:(GoStoneView*)view{
    GameRecords* newRecord = nil;
    switch (_game.insertMode) {
        case 0:
            newRecord = [_game createNewNormalRecord:x y:y];
            break;
        case 1:
            newRecord  = [_game createNewBranchRecord:x y:y];
            break;
        default:
            break;
    }
    return newRecord;
}

@end
