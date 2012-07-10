//
//  TopViewController.h
//  GoClinic
//
//  Created by じーめいる on 12/05/30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import	"AbstractRecordViewController.h"

@interface TopViewController : AbstractRecordViewController {
    
}

-(IBAction) touchShowGame:(id)sender;
-(IBAction) touchCreateGame:(id)sender;
-(IBAction) touchSolveQuestionGame:(id)sender;
-(IBAction) touchCreateQuestionGame:(id)sender;

@end
