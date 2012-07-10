// 
//  GameRecords.m
//  GoClinic
//
//  Created by 猪子 徹 on 10/10/17.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GameRecords.h"
#import "Games.h"
#import "Comments.h"
#import "Global.h"

@implementation GameRecords 

@dynamic is_bad;
@dynamic face_id;
@dynamic point;
@dynamic is_good;
@dynamic is_shown_state;
@dynamic move;
@dynamic removed_move;
@dynamic answer_move;
@dynamic move_on_face_registered;
@dynamic comments;
@dynamic next_game_records;
@dynamic branch_records;
@dynamic root_record;
@dynamic prev_game_records;
@dynamic is_answer;
@dynamic is_okiishi;
@dynamic removed_by;
@dynamic depth;
@dynamic games;
@dynamic user_id;
@dynamic x;
@dynamic y;
@dynamic real_x;
@dynamic real_y;
@dynamic width;
@dynamic height;

@synthesize view = _view;
@synthesize prevX = _prevX;
@synthesize prevY = _prevY;
@synthesize isRemoved = _isRemoved;

-(id)initWithFrame:(CGRect)frame{
    if((self = [self initNewRecord:nil move:-1 prev:nil next:nil])){
        self.x = [NSNumber numberWithInt:frame.origin.x];
        self.y = [NSNumber numberWithInt:frame.origin.y];
        self.real_x = [NSNumber numberWithFloat:frame.origin.x];
        self.real_y = [NSNumber numberWithFloat:frame.origin.y];
        self.width = [NSNumber numberWithInt:frame.size.width];
        self.height = [NSNumber numberWithInt:frame.size.height];
        self.view = [[GoStoneView alloc] initWithGameRecords:self];
        self.view.record = self;
    }
    return self;
}

-(id)initTmpRecord{
    return [self initNewRecord:nil move:-1 prev:nil next:nil];
}

-(id)initNewRecord:(Games*)game move:(int)move prev:(GameRecords*)prev next:(GameRecords*)next{
	if((self = [[GameRecords alloc] initWithEntity:[NSEntityDescription entityForName:@"GameRecords" inManagedObjectContext:managedObjectContextGlobal] 
			 insertIntoManagedObjectContext:managedObjectContextGlobal])){
        [self initParams:game move:move prev:prev next:next];
	}
	return self;
}

-(void)initParams:(Games*)game move:(int)move prev:(GameRecords*)prev next:(GameRecords*)next{
    self.move = [NSNumber numberWithInt:move];
    
    self.prev_game_records = prev;
    if (prev != nil) {
        prev.next_game_records = self;
    }
    if (next != nil) {
        self.next_game_records = next;
    }
    self.comments = [[NSMutableSet alloc] init];
    
    
    
    self.face_id = [NSNumber numberWithInt:-1];
    self.removed_by = [[NSMutableSet alloc] init];
    self.depth = [NSNumber numberWithInt:0];
    self.isRemoved = NO;
    self.is_shown_state = [NSNumber numberWithBool:NO];
}

+(int)getMaxExistingGameRecordId{
	NSNumber* gameRecordId = [NSNumber numberWithInt:0];
	if(managedObjectContextGlobal != nil ) {
		NSEntityDescription * entityDescription = [NSEntityDescription entityForName:@"GameRecords" inManagedObjectContext:managedObjectContextGlobal];
		NSFetchRequest * request = [[[NSFetchRequest alloc] init] autorelease];
		[request setEntity:entityDescription];	
		NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"game_record_id" ascending:NO];
		[request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
		[sortDescriptor release];
		NSArray * allGameRecords = [managedObjectContextGlobal executeFetchRequest:request error:nil];
		if (allGameRecords && [allGameRecords count] > 0) {
			gameRecordId = [[allGameRecords objectAtIndex:0] valueForKey:@"game_record_id"];
		}
	}
	return [gameRecordId intValue];
}


-(BOOL)isSameUserId:(int)userId{
	return [self.user_id intValue] == userId;
}

- (BOOL)delete{    
	[self.managedObjectContext deleteObject:self];
    
	NSError *error = nil;
	if([self.managedObjectContext save: &error ] == NO ){
		// エラー対策
		return NO;
	}
	return YES;
}


- (id)createGoodRecord:(GameRecords *)record{
	GameRecords* newRecord = [[GameRecords	alloc] initNewRecord:nil move:[record.move intValue] prev:nil next:nil];
	newRecord.move = self.move;
	newRecord.is_bad = [NSNumber numberWithInt:0];
	newRecord.is_good = [NSNumber numberWithInt:1];
	return newRecord;
}

- (id)createBadRecord:(GameRecords *)record{
	GameRecords* newRecord = [[GameRecords	alloc] initNewRecord:nil move:[record.move intValue] prev:nil next:nil];
	newRecord.move = self.move;
	newRecord.is_bad = [NSNumber numberWithInt:1];
	newRecord.is_good = [NSNumber numberWithInt:0];
	return newRecord;
}

-(void)dealloc{
    [_view release];
    [_prevX release];
    [_prevY release];
	[super dealloc];
}
@end
