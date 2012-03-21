//
//  RightButtonViewCellController.h
//  GoClinic
//
//  Created by 猪子 徹 on 10/09/30.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FacesViewCell;

@protocol FacesViewCellControllerDelegate
-(void)touchFacesViewCell:(id)sender touched:(int)faceId;
@end

/**
 顔登録用のViewCellController
 @auther inoko
 */
@interface FacesViewCellController : UIViewController {
	IBOutlet FacesViewCell* _cell;
}

@property(nonatomic, retain) FacesViewCell* cell;

@end
