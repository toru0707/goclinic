//
//  FacesWithNoLabelViewController.h
//  GoClinic
//
//  Created by 猪子 徹 on 11/04/04.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FacesViewController.h"

#define FACES_WITH_NO_LABEL_VIEW_CONTROLLER_TAG 502 ///< ViewControllerを指定するTAG

@protocol FacesWithNoLabelViewControllerDelegate
/**
 * TableViewCellを選択したときに呼び出されるメソッド
 */
-(void)touchFacesWithNoLabelTableViewCell:(id)sender faceNumber:(int)faceNumber;
@end

/**
 顔登録用のViewController（ラベルなし）
 @auther inoko
 */
@interface FacesWithNoLabelViewController : UITableViewController {
	id<FacesWithNoLabelViewControllerDelegate> _delegate; ///< プロパティ受け渡し用変数
	int _buttonColorFlag; ///< プロパティ受け渡し用変数
	NSMutableArray* _blackButtonImgs; ///< 黒石用ボタン画像を格納する配列
	NSMutableArray* _whiteButtonImgs; ///< 白石用ボタン画像を格納する配列
}
@property(nonatomic, assign) id<FacesWithNoLabelViewControllerDelegate> delegate; ///< デリゲートオブジェクト
@property int buttonColorFlag; ///< ボタンの色を示すフラグ。0:黒, 1:白
@end
