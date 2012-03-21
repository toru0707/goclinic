//
//  QustionViewControllerState.h
//  GoClinic
//
//  Created by 猪子 徹 on 11/06/12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecordRegistViewController.h"

@interface QuestionViewControllerState : NSObject {
    RecordRegistViewController* _controller;
}

-(id)initWithViewController:(RecordRegistViewController*)controller;
-(void)showGoStoneViewAfterPutGoStone:(GameRecords*)record;


@end
