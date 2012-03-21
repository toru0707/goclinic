//
//  QuestionAnswerViewControllerState.m
//  GoClinic
//
//  Created by 猪子 徹 on 11/06/12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "QuestionAnswerViewControllerState.h"


@implementation QuestionAnswerViewControllerState

-(void)showGoStoneViewAfterPutGoStone:(GameRecords*)record{
    
    //一手前の棋譜
    GameRecords* prev;
    prev = _controller.currentGame.current_record;
    //Viewの設定
    record.view.stoneOpacity = NORMAL_OPACITY;
    [_controller insertGoStoneView:record.view aboveView:_controller.view];
    [_controller insertGoStoneViewCyclick:[[_controller getLastShownGoStoneViewRecord:prev.prev_game_records] next_game_records] toMove:[record.move intValue] opacity:1.0 isRemovedShow:NO];
    
    //メニューの表示
    UIMenuController *theMenu = [UIMenuController sharedMenuController];
	if([theMenu isMenuVisible]){
		[theMenu setMenuVisible:NO animated:YES];
	}else{
		//_currentSelection = stoneView;
		[theMenu setTargetRect:record.view.frame inView:_controller.boardView];
		UIMenuItem *faceRegistMenuItem = [[[UIMenuItem alloc] initWithTitle:@"顔登録" action:@selector(faceRegistGoStoneMenu:)] autorelease];
		UIMenuItem *commentMenuItem = [[[UIMenuItem alloc] initWithTitle:@"コメント" action:@selector(commentGoStoneMenu:)] autorelease];
		UIMenuItem *henkazuMenuItem = [[[UIMenuItem alloc] initWithTitle:@"変化図を登録" action:@selector(henkazuGoStoneMenu:)] autorelease];
		UIMenuItem *deleteMenuItem = [[[UIMenuItem alloc] initWithTitle:@"削除" action:@selector(deleteGoStoneMenu:)] autorelease];
		theMenu.menuItems = [NSArray arrayWithObjects:faceRegistMenuItem, commentMenuItem, henkazuMenuItem, deleteMenuItem, nil];
		[theMenu setMenuVisible:YES animated:YES];
	}
    
}

@end
