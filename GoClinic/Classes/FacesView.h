//
//  RightButtonView.h
//  GoClinic
//
//  Created by 猪子 徹 on 10/09/27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import	"AnimationTableView.h"
@class FacesViewCell;

/**
 顔登録表示表示用View
 @auther inoko
 */
@interface FacesView : AnimationTableView{
	IBOutlet FacesViewCell* _cell;
}
@property(nonatomic, retain) FacesViewCell* cell;

@end
