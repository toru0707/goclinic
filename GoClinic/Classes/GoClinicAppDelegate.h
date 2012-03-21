//
//  GoClinicAppDelegate.h
//  GoClinic
//
//  Created by 猪子 徹 on 10/08/15.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class GameRecordService;
@class GameRecordServiceFactory;
@class Games;

/**
 ApplicationDelegateクラス
 ゲームのDaoを担当する
 @auther inoko
 */
@interface GoClinicAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	NSManagedObjectModel *_managedObjectModel;
	NSManagedObjectContext *_managedObjectContext;	
	NSPersistentStoreCoordinator *_persistentStoreCoordinator;
	Games* _game;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic,retain)Games* game;

/**
 DBから全てのゲームオブジェクトを取得する
 @return 全てのGamesオブジェクトが格納されたNSArray
 */
- (NSArray*)getAllGames;

/**
 DBから全てのクリニックゲームオブジェクトを取得する
 @return 全てのNormalGamesオブジェクトが格納されたNSArray
 */
- (NSArray*)getNormalGames;

/**
 DBから全ての詰碁ゲームオブジェクトを取得する
 @return 全てのTsumegoGamesオブジェクトが格納されたNSArray
 */
- (NSArray*)getTsumegoGames;

/**
 DBから全ての問題ゲームオブジェクトを取得する
 @return 全てのQuestionGamesオブジェクトが格納されたNSArray
 */
- (NSArray*)getQuestionGames;

@end
