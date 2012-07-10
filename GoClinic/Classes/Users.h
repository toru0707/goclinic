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
}

@property (nonatomic, retain) NSNumber * user_id; ///< ユーザを一位に指定するID
@property (nonatomic, retain) NSString * name; ///< ユーザの名前
@property (nonatomic, retain) NSSet* games; ///< ユーザがもつ棋譜配列

@end

/**
 以下のメソッドの実装は、ManagedObjectによって動的に生成される
*/
@interface Users (CoreDataGeneratedAccessors)
/**
指定されたゲームを保存する
*/
- (void)addGamesObject:(Games *)value;
/**
指定されたゲームを削除する
*/
- (void)removeGamesObject:(Games *)value;
/**
指定されたゲーム集合を保存する
*/
- (void)addGames:(NSSet *)value;
/**
指定されたゲーム集合を削除する
*/
- (void)removeGames:(NSSet *)value;

@end

