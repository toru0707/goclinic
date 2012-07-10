//
//  QuestionGameState.m
//  GoClinic
//
//  Created by 猪子 徹 on 11/06/08.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "QuestionGameState.h"


@implementation QuestionGameState

-(id)initWithGames:(Games*)game{
    if((self = [super init])){
        _game = (QuestionGames*)[game retain];
    }
    return self;
}

-(GameRecords*)createNewRecord:(int)x y:(int)y goStoneView:(GoStoneView*)view{
    return nil;
}

@end
