//
//  QuestionAnswerGoStoneView.m
//  GoClinic
//
//  Created by 猪子 徹 on 11/06/09.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "QuestionAnswerGoStoneView.h"
#import "GameRecords.h"
#import "ImageManager.h"

@implementation QuestionAnswerGoStoneView


- (void)drawRect:(CGRect)rect{
    // Drawing code
	CGContextRef context = UIGraphicsGetCurrentContext();  
	//円の中身を描画  
	switch (self.stoneColorId) {
		case 0:
			CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 0.5);  
			break;
		case 1:
			CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 0.5);  
			break;
		default:
			break;
	}
	CGContextFillEllipseInRect(context, rect);  
	
	//描画方法を指定 0:手数を表示 1:顔を表示 2:何も表示しない
    if(_showNumber){
        [self drawNumber];
    }else if(_showFace){
        [self drawFace];
    }else{
        [self drawNone];
    }
    
    
	//選択されている場合は、赤で縁取り
	if(_isHighLighted){
		[self drawRedCircle];
	}
	[self becomeFirstResponder];

    
}

-(void)showContextMenu:(UIView*)targetView{
    UIMenuController *theMenu = [UIMenuController sharedMenuController];
	if([theMenu isMenuVisible]){
		[theMenu setMenuVisible:NO animated:YES];
	}else{
		[theMenu setTargetRect:self.frame inView:targetView];
		UIMenuItem *commentMenuItem = [[[UIMenuItem alloc] initWithTitle:@"コメント" action:@selector(commentGoStoneMenu:)] autorelease];
		UIMenuItem *faceRegistMenuItem = [[[UIMenuItem alloc] initWithTitle:@"顔登録" action:@selector(faceRegistGoStoneMenu:)] autorelease];
		UIMenuItem *deleteMenuItem = [[[UIMenuItem alloc] initWithTitle:@"削除" action:@selector(deleteGoStoneMenu:)] autorelease];
        UIMenuItem *henkazuMenuItem = [[[UIMenuItem alloc] initWithTitle:@"変化図を登録" action:@selector(henkazuGoStoneMenu:)] autorelease];
        
		theMenu.menuItems = [NSArray arrayWithObjects:faceRegistMenuItem, commentMenuItem, henkazuMenuItem, deleteMenuItem, nil];
		[theMenu setMenuVisible:YES animated:YES];
	}
}


@end
