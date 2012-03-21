//
//  TsumegoGameState.m
//  GoClinic
//
//  Created by 猪子 徹 on 11/05/17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TsumegoGameState.h"


@implementation TsumegoGameState

-(id)initWithViewController:(AbstractRecordViewController*)viewController{
    if((self = [super init])){
        _viewController = viewController;
    }
    return self;
}

-(void)showAnswerStones{
    NSEnumerator* e = [_viewController.currentGame.game_records objectEnumerator];
	GameRecords* item;
	while ((item = (GameRecords*)[e nextObject]) != nil) {
		//解答の場合は表示する
		if ([item.is_answer boolValue]) {
            item.view.stoneOpacity = NORMAL_OPACITY;
			[_viewController insertGoStoneView:item.view aboveView:nil];
		}
	}
}

-(void)clearAnswerStones{
    NSEnumerator* e = [_viewController.currentGame.game_records objectEnumerator];
	GameRecords* item;
	while ((item = (GameRecords*)[e nextObject]) != nil) {
		//解答の場合は消去する
		if ([item.is_answer boolValue]) {
			[item.view removeFromSuperview];
		}
	}
}


@end
