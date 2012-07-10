//
//  OkiishiPickerAlertViewController.h
//  GoClinic
//
//  Created by 猪子 徹 on 11/04/18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseLabelPickerAlertViewController.h"

#define OKIISHI_MAX 9 ///< 置き石の最大個数


@protocol OkiishiPickerAlertViewControllerDelegate
/**
Rowが選択されたときに呼び出されれるメソッド
*/
-(void)selectNumOfOkiishi:(id)sender selectedNum:(int)selectedNum;
@end

/**
 置石数選択用のPickerAlertViewController（ハイライト有り）
 @auther inoko
 */
@interface OkiishiPickerAlertViewController : BaseLabelPickerAlertViewController {
    id<OkiishiPickerAlertViewControllerDelegate> _delegate; ///< プロパティ受け渡し用変数
}
@property (nonatomic, assign)id<OkiishiPickerAlertViewControllerDelegate> delegate; ///< デリゲートオブジェクト
@end
