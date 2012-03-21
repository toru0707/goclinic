//
//  QuestionAnswerRecord.m
//  GoClinic
//
//  Created by 猪子 徹 on 11/06/09.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "QuestionAnswerRecords.h"
#import "Games.h"
#import "Global.h"

@implementation QuestionAnswerRecords

-(id)initNewRecord:(Games*)game move:(int)move prev:(GameRecords*)prev next:(GameRecords*)next{
	if((self = [[QuestionAnswerRecords alloc] initWithEntity:[NSEntityDescription entityForName:@"QuestionAnswerRecords" inManagedObjectContext:managedObjectContextGlobal] 
              insertIntoManagedObjectContext:managedObjectContextGlobal])){
        [self initParams:game move:move prev:prev next:next];
	}
	return self;
}

@end
