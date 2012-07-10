//
//  FacesViewController.h
//  GoClinic
//
//  Created by 猪子 徹 on 10/10/30.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FacesViewCellController.h"

#define FACES_VIEW_CONTROLLER_TAG 500 ///< ViewControllerを識別するためのタグ

@protocol FacesViewControllerDelegate
/**
 * TableViewCellをタッチしたときに呼び出されるメソッド
 */
-(void)touchFacesTableViewCell:(id)sender faceNumber:(int)faceId comment:(NSString*)comment;
@end

/**
 顔登録用のViewController
 @auther inoko
 */
@interface FacesViewController : UITableViewController {
	id<FacesViewControllerDelegate> _delegate; ///< プロパティ受け渡し用変数
	FacesViewCellController* _facesViewCellController; ///< プロパティ受け渡し用変数
	int _buttonColorFlag; ///< プロパティ受け渡し用変数
	NSMutableArray* _blackButtonImgs;  ///< プロパティ受け渡し用変数
	NSMutableArray* _whiteButtonImgs; ///< 白石用のBOB顔配列
	NSMutableArray* _commentArray; ///< コメント配列
}
@property(nonatomic, assign) id<FacesViewControllerDelegate> delegate; ///< デリゲートオブジェクト
@property(nonatomic, retain) FacesViewCellController* facesViewCellController; ///< BOB顔TableViewCellController
@property int buttonColorFlag; ///< ボタンの色のフラグ。0:黒, 1:白
@property(nonatomic, retain) NSMutableArray* blackButtonImgs; ///< 黒石用のBOB顔配列
@end
