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
  UIWindow *window; ///< プロパティ受け渡し用変数
	NSManagedObjectModel *_managedObjectModel; ///< プロパティ受け渡し用変数
	NSManagedObjectContext *_managedObjectContext;	 ///< プロパティ受け渡し用変数
	NSPersistentStoreCoordinator *_persistentStoreCoordinator; ///< プロパティ受け渡し用変数
	Games* _game; ///< プロパティ受け渡し用変数
}

@property (nonatomic, retain) IBOutlet UIWindow *window; ///< windowのアウトレットオブジェクト
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel; ///< オブジェクトモデル
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext; ///< オブジェクトコンテキスト
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator; ///< パーシステンスストアコーディネータ
@property (nonatomic,retain)Games* game; ///< ゲーム情報

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
