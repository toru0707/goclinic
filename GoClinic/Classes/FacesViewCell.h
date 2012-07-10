//
//  RightButtonViewCell.h
//  GoClinic
//
//  Created by 猪子 徹 on 10/09/27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 顔登録表示表示用ViewCell
 @auther inoko
 */
@interface FacesViewCell : UITableViewCell {
	IBOutlet UIImageView* buttonImgView; ///< プロパティ受け渡し用変数
	IBOutlet UITextView* buttonText; ///< プロパティ受け渡し用変数
}

@property(nonatomic, retain) UIImageView* buttonImgView; ///< BOB顔表示する部分のViewのアウトレットオブジェクト
@property(nonatomic, retain) UITextView* buttonText; ///< テキスト部分のViewのアウトレットオブジェクト
@end
