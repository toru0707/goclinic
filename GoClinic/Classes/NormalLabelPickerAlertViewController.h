//
//  NormalLabelPickerAlertViewController.h
//  GoClinic
//
//  Created by 猪子 徹 on 11/05/03.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseLabelPickerAlertViewController.h"

@protocol NormalLabelPickerAlertViewControllerDelegate
/**
Rowを選択したときに呼び出されるメソッド
*/
-(void)selectedLabelPickerIndex:(id)sender index:(int)index label:(NSString*)label;
@end

/**
 文字列選択用のPickerAlertViewController（ハイライト有り）
 @auther inoko
 */
@interface NormalLabelPickerAlertViewController : BaseLabelPickerAlertViewController {
  id<NormalLabelPickerAlertViewControllerDelegate> _delegate; ///< プロパティ受け渡し用変数
}
@property (nonatomic, assign)id<NormalLabelPickerAlertViewControllerDelegate> delegate; ///< デリゲートオブジェクト

@end
