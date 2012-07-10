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

/**
 GoStoneViewのFactoryクラス
 
 @auther inoko
 */
@interface GoStoneViewFactory : NSObject {
    
}

/**
 GameRecordsからGoStoneViewを生成する
 */
+(GoStoneView*)createGoStoneView:(GameRecords*)record;

@end
