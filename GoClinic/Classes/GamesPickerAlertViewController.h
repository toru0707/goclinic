//
//  GamesPickerAlertViewController.h
//  GoClinic
//
//  Created by 猪子 徹 on 11/05/03.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseLabelPickerAlertViewController.h"
#import "Games.h"

@protocol GamePickerAlertViewControllerDelegate
/**
 PickerのRowが選択された時に呼び出されるメソッド
 */
-(void)selectedGamePickerIndex:(id)sender index:(int)index game:(Games*)game viewController:(UIViewController*)viewController;
@end


/**
 既存のゲーム選択用のPickerAlertViewController（選択時ハイライト有り）
 @auther inoko
 */
@interface GamesPickerAlertViewController : BaseLabelPickerAlertViewController {
    id<GamePickerAlertViewControllerDelegate> _delegate;     ///< プロパティ受け渡し用変数
    NSMutableArray* _games; ///< 表示用のゲームオブジェクト配列
    UIViewController* _viewController; ///< PickerのViewController
}
@property (nonatomic, assign)id<GamePickerAlertViewControllerDelegate> delegate; ///< デリゲートオブジェクト

/**
 * コンストラクタ
 */
- (id)initWithTitle:(NSMutableArray *)pickerList viewController:(UIViewController*)viewController;

@end
