//
//  Users.h
//  GoClinic
//
//  Created by 猪子 徹 on 10/10/11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Games;

/**
 ユーザ情報を格納するクラス
 @auther inoko
 */
@interface Users :  NSManagedObject  
{
	BOOL _isCurrent;
}

@property BOOL isCurrent;
@property (nonatomic, retain) NSNumber * user_id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet* games;

@end


@interface Users (CoreDataGeneratedAccessors)
- (void)addGamesObject:(Games *)value;
- (void)removeGamesObject:(Games *)value;
- (void)addGames:(NSSet *)value;
- (void)removeGames:(NSSet *)value;

@end

