// 
//  Users.m
//  GoClinic
//
//  Created by 猪子 徹 on 10/10/11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Users.h"
#import "Global.h"

@implementation Users 
@dynamic user_id;
@dynamic name;
@dynamic games;

-(id)init{
	if((self = [[Users alloc] initWithEntity:[NSEntityDescription entityForName:@"Users" inManagedObjectContext:managedObjectContextGlobal] 
			 insertIntoManagedObjectContext:managedObjectContextGlobal])){
	
	}
	return self;
}

@end
