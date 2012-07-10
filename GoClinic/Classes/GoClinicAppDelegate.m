//
//  GoClinicAppDelegate.m
//  GoClinic
//
//  Created by 猪子 徹 on 10/08/15.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "GoClinicAppDelegate.h"
#import "Global.h"
#import "Games.h"
#import "AbstractRecordViewController.h"


@interface GoClinicAppDelegate (private)
  /**
   * アプリケーションのドキュメントディレクトリへのパスを取得する
   */
- (NSString *)applicationDocumentsDirectory;

  /**
   * 指定したPredicateを使用し、DBからGamesオブジェクトを取得する
   * @param Predicateオブジェクト
   */
- (NSArray*)getGamesWithPredicate:(NSPredicate*)condition;
@end

@implementation GoClinicAppDelegate

@synthesize window;
@synthesize managedObjectModel =  _managedObjectModel;
@synthesize managedObjectContext =  _managedObjectContext;	
@synthesize persistentStoreCoordinator  = _persistentStoreCoordinator;
@synthesize game = _game;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {   
	managedObjectContextGlobal = self.managedObjectContext;
    [window makeKeyAndVisible];
	return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
	NSError *error;
	if (_managedObjectContext != nil) {
        if(((AbstractRecordViewController*) self.window.rootViewController).currentGame != nil)
            [((AbstractRecordViewController*) self.window.rootViewController).currentGame save];
		if ([_managedObjectContext hasChanges] && ![_managedObjectContext save:&error]) {
			// Update to handle the error appropriately.
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		} 
	}
}

- (void)applicationWillTerminate:(UIApplication *)application {
	NSError *error;
	if (_managedObjectContext != nil) {
        
        if(((AbstractRecordViewController*) self.window.rootViewController).currentGame != nil)
            [((AbstractRecordViewController*) self.window.rootViewController).currentGame save];
		if ([_managedObjectContext hasChanges] && ![_managedObjectContext save:&error]) {
			// Update to handle the error appropriately.
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		} 
	}
}

- (NSArray*)getAllGames{
	return [self getGamesWithPredicate:nil];
}

- (NSArray*)getNormalGames{
    return [self getGamesWithPredicate:[NSPredicate predicateWithFormat:@"game_category == %@", [NSNumber numberWithInt:NORMAL_GAME_CATEGORY]]];
}

- (NSArray*)getTsumegoGames{
	return [self getGamesWithPredicate:[NSPredicate predicateWithFormat:@"game_category == %@", [NSNumber numberWithInt:TSUMEGO_GAME_CATEGORY]]];
}

- (NSArray*)getQuestionGames{
    	return [self getGamesWithPredicate:[NSPredicate predicateWithFormat:@"game_category == %@", [NSNumber numberWithInt:QUESTION_GAME_CATEGORY]]];    
}

- (NSArray*)getGamesWithPredicate:(NSPredicate*)condition{
  NSEntityDescription *entity =
	[NSEntityDescription entityForName:@"Games"
				inManagedObjectContext:managedObjectContextGlobal];
    
	// 新しいインスタンスを作成する
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	
	if (condition != nil) {
		[fetchRequest setPredicate:condition];
	}
	
  // 取得するエンティティとして設定する
  [fetchRequest setEntity:entity];
  
  // 一度に取得するオブジェクトの個数の上限値を設定する
  [fetchRequest setFetchBatchSize:100];
    
	
	NSError* error = nil;
	NSLog(@"----- executeFetchRequest ------------------------------------------");
	NSArray* allGames = [managedObjectContextGlobal executeFetchRequest:fetchRequest error:&error];
	if(error != nil){
		NSLog(@"error is occured. at getAllGames.");
	}
	
	
    // 解放処理    
	[fetchRequest release];
	
  return allGames;
}



// ここから下は全部追加する
#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *) managedObjectContext {
	
	if (_managedObjectContext != nil) {
		return _managedObjectContext;
	}
	
	NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
	if (coordinator != nil) {
		_managedObjectContext = [[NSManagedObjectContext alloc] init];
		[_managedObjectContext setPersistentStoreCoordinator: coordinator];
	}
	return _managedObjectContext;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created by merging all of the models found in the application bundle.
 */
- (NSManagedObjectModel *)managedObjectModel {
	
	if (_managedObjectModel != nil) {
		return _managedObjectModel;
	}
	_managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain]; 
	return _managedObjectModel;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
	if (_persistentStoreCoordinator != nil) {
		return _persistentStoreCoordinator;
	}
	
	
	NSString *storePath = [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"mydata.sqlite"]; // sqliteファイルの名前は任意
	/*
	 Set up the store.
	 For the sake of illustration, provide a pre-populated default store.
	 */
	
	NSLog(@"persistentStoreCoordinator applicationDocumentsDirectory %@", [self applicationDocumentsDirectory]);
	NSLog(@"persistentStoreCoordinator storePath %@", storePath);
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	// If the expected store doesn't exist, copy the default store.
	if (![fileManager fileExistsAtPath:storePath]) {
		NSLog(@"persistentStoreCoordinator storePath-!storePath");
		NSString *defaultStorePath = [[NSBundle mainBundle] pathForResource:@"mydata" ofType:@"sqlite"]; // sqliteファイルの名前は任意
		if (defaultStorePath) {
			NSLog(@"persistentStoreCoordinator defaultStorePath");
			[fileManager copyItemAtPath:defaultStorePath toPath:storePath error:NULL];
		}
	}
	
	NSURL *storeUrl = [NSURL fileURLWithPath:storePath];
	
	NSError *error = nil;
	_persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
	if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {

		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	} 
	
	return _persistentStoreCoordinator;
}


#pragma mark -
#pragma mark Application's Documents directory

- (NSString *)applicationDocumentsDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
}


- (void)dealloc {
    [_managedObjectContext release];
	[_managedObjectModel release]; 
	[_persistentStoreCoordinator release];
  [window release];
  [super dealloc];
}

@end
