//
//  QuestionMessageRecords.m
//  GoClinic
//
//  Created by 猪子 徹 on 11/06/09.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "QuestionMessageRecords.h"
#import "Global.h"
#import "Games.h"

@implementation QuestionMessageRecords

-(id)initNewRecord:(Games*)game move:(int)move prev:(GameRecords*)prev next:(GameRecords*)next{
	if((self = [[Games alloc] initWithEntity:[NSEntityDescription entityForName:@"QuestionMessageRecords" inManagedObjectContext:managedObjectContextGlobal] 
              insertIntoManagedObjectContext:managedObjectContextGlobal])){
        [self initParams:game move:move prev:prev next:next];
	}
	return self;
}

@end
