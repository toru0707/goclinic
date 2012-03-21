//
//  QuestionGameState.h
//  GoClinic
//
//  Created by 猪子 徹 on 11/06/08.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuestionGames.h"
@class Games;
@class GoStoneView;
@class GameRecords;

@interface QuestionGameState : NSObject {
    QuestionGames* _game;
}

-(id)initWithGames:(Games*)game;
-(GameRecords*)createNewRecord:(int)x y:(int)y goStoneView:(GoStoneView*)view;

@end
