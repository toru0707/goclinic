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
	IBOutlet UIImageView* buttonImgView;
	IBOutlet UITextView* buttonText;
}

@property(nonatomic, retain) UIImageView* buttonImgView;
@property(nonatomic, retain) UITextView* buttonText;

@end
