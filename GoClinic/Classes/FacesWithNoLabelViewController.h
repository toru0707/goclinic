//
//  FacesWithNoLabelViewController.h
//  GoClinic
//
//  Created by 猪子 徹 on 11/04/04.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FacesViewController.h"

#define FACES_WITH_NO_LABEL_VIEW_CONTROLLER_TAG 502

@protocol FacesWithNoLabelViewControllerDelegate
-(void)touchFacesWithNoLabelTableViewCell:(id)sender faceNumber:(int)faceNumber;
@end

/**
 顔登録用のViewController（ラベルなし）
 @auther inoko
 */
@interface FacesWithNoLabelViewController : UITableViewController {
	id<FacesWithNoLabelViewControllerDelegate> _delegate;
    //0:黒, 1:白
	int _buttonColorFlag;
	NSMutableArray* _blackButtonImgs;
	NSMutableArray* _whiteButtonImgs;
}
@property(nonatomic, assign) id<FacesWithNoLabelViewControllerDelegate> delegate;
@property int buttonColorFlag;
@end
