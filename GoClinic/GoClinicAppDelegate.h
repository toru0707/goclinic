//
//  GoClinicAppDelegate.h
//  GoClinic
//
//  Created by 猪子 徹 on 11/03/14.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoClinicViewController;

@interface GoClinicAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet GoClinicViewController *viewController;

@end
