//
//  GoStoneViewFactory.h
//  GoClinic
//
//  Created by 猪子 徹 on 11/06/09.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoStoneView.h"
#import "GameRecords.h"


@interface GoStoneViewFactory : NSObject {
    
}

+(GoStoneView*)createGoStoneView:(GameRecords*)record;

@end
