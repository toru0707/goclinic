//
//  GoStoneViewFactory.m
//  GoClinic
//
//  Created by 猪子 徹 on 11/06/09.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GoStoneViewFactory.h"
#import "GameRecords.h"
#import "QuestionMessageRecords.h"
#import "QuestionAnswerRecords.h"
#import "QuestionMessageGoStoneView.h"
#import "QuestionAnswerGoStoneView.h"

@implementation GoStoneViewFactory

+(GoStoneView*)createGoStoneView:(GameRecords*)record{
    GoStoneView* stoneView;
    
    //問題用棋譜の場合
    if ([record isKindOfClass:[QuestionMessageRecords class]]) {
        stoneView = [[QuestionMessageGoStoneView alloc] initWithGameRecords:record];
    }
    //問題解答用棋譜の場合
    else if([record isKindOfClass:[QuestionAnswerRecords class]]){
        stoneView = [[QuestionAnswerGoStoneView alloc] initWithGameRecords:record];
    }
    //通常棋譜の場合
    else{
        stoneView = [[GoStoneView alloc] initWithGameRecords:record];
    }
    
    stoneView.record = record;
    record.view = stoneView;
	return stoneView;
}

@end
