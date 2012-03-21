// 
//  Comments.m
//  GoClinic
//
//  Created by 猪子 徹 on 10/10/11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Comments.h"
#import "Global.h"

@implementation Comments 

@dynamic text;
@dynamic point;
@dynamic category;

-(id)initNewComment{
	if((self = [[Comments alloc] initWithEntity:[NSEntityDescription entityForName:@"Comments" inManagedObjectContext:managedObjectContextGlobal] 
			 insertIntoManagedObjectContext:managedObjectContextGlobal])){
		self.point = 0;
	}
	return self;
}

-(void)dealloc{
	 [super dealloc];
}

@end
