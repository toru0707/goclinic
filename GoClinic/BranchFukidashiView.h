//
//  BranchFukidashiView.h
//  GoClinic
//
//  Created by 猪子 徹 on 11/05/29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 碁石のクリニック数を表示するための吹出しView
 
 @auther inoko
 */
@interface BranchFukidashiView : UIView {
    int _branchNum; ///< 分岐の数
}

/**
 コンストラクタ
 */
- (id)initWithBranchNum:(CGRect)frame branchNum:(int)move;
@end
