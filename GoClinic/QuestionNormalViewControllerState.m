//
//  QuestionNormalViewControllerState.m
//  GoClinic
//
//  Created by 猪子 徹 on 11/06/12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "QuestionNormalViewControllerState.h"


@implementation QuestionNormalViewControllerState

-(void)showGoStoneViewAfterPutGoStone:(GameRecords*)record{
    //一手前の棋譜
    GameRecords* prev;
    //0:ノーマルの棋譜を入力する. 1:ブランチの棋譜を入力する
    switch (_controller.currentGame.insertMode) {
        case 0:
            //一手前の棋譜を設定する
            prev = _controller.currentGame.current_record;
            break;
        case 1:
            //一手前の棋譜を設定する
            prev = _controller.currentGame.current_record.prev_game_records;
            break;
        default:
            break;
    }
    //Viewの設定
    record.view.stoneOpacity = NORMAL_OPACITY;
    [_controller insertGoStoneView:record.view aboveView:_controller.view];
    [_controller insertGoStoneViewCyclick:[[_controller getLastShownGoStoneViewRecord:prev.prev_game_records] next_game_records] toMove:[record.move intValue] opacity:1.0 isRemovedShow:NO];
   
}

@end
