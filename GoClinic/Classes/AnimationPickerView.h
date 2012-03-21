//
//  AnimationView.h
//  GoClinic
//
//  Created by 猪子 徹 on 10/10/02.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 スライドアニメーション機能を持つPickerView
 @auther inoko
 */
@interface AnimationPickerView : UIPickerView {

}

/**
 スライドアニメーションを開始する
 @param rect (recx.x, rect.y)がアニメーション終了地点となる
 @param sender delegate先オブジェクト
 */
-(void)startAnimation:(CGRect)rect sender:(id)sender;

@end
