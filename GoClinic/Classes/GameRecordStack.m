//
//  GameRecordStack.m
//  GoClinic
//
//  Created by 猪子 徹 on 10/12/04.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GameRecordStack.h"


@implementation NSMutableArray (StackAdditions)

- (id)pop
{
    id lastObject = [[[self lastObject] retain] autorelease];
    if (lastObject)
        [self removeLastObject];
    return lastObject;
}

- (void)push:(id)obj
{
	[self addObject: obj];
}


@end