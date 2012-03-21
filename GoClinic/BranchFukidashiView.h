//
//  BranchFukidashiView.h
//  GoClinic
//
//  Created by 猪子 徹 on 11/05/29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BranchFukidashiView : UIView {
    int _branchNum;
}

- (id)initWithBranchNum:(CGRect)frame branchNum:(int)move;
@end
