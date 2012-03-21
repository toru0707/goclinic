//
//  FacesViewController.h
//  GoClinic
//
//  Created by 猪子 徹 on 10/10/30.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FacesViewCellController.h"

#define FACES_VIEW_CONTROLLER_TAG 500

@protocol FacesViewControllerDelegate
-(void)touchFacesTableViewCell:(id)sender faceNumber:(int)faceId comment:(NSString*)comment;
@end

/**
 顔登録用のViewController
 @auther inoko
 */
@interface FacesViewController : UITableViewController {
	id<FacesViewControllerDelegate> _delegate;
	FacesViewCellController* _facesViewCellController;
	//0:黒, 1:白
	int _buttonColorFlag;
	NSMutableArray* _blackButtonImgs;
	NSMutableArray* _whiteButtonImgs;
	NSMutableArray* _commentArray;
}
@property(nonatomic, assign) id<FacesViewControllerDelegate> delegate;
@property(nonatomic, retain) FacesViewCellController* facesViewCellController;
@property int buttonColorFlag;
@property(nonatomic, retain) NSMutableArray* blackButtonImgs;
@end
