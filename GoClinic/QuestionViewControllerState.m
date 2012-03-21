//
//  QustionViewControllerState.m
//  GoClinic
//
//  Created by 猪子 徹 on 11/06/12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "QuestionViewControllerState.h"


@implementation QuestionViewControllerState

-(id)initWithViewController:(RecordRegistViewController*)controller{
    if((self = [super init])){
        _controller = controller;
    }
    return self;
}

-(void)showGoStoneViewAfterPutGoStone:(GameRecords*)record{}

@end
