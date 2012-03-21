//
//  BranchFukidashiView.m
//  GoClinic
//
//  Created by 猪子 徹 on 11/05/29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BranchFukidashiView.h"

#define VIEW_WIDTH 30
#define VIEW_HEIGHT 30
#define FONT_SIZE 12

@implementation BranchFukidashiView


- (id)initWithBranchNum:(CGRect)frame branchNum:(int)branchNum{
    if ((self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, VIEW_WIDTH, VIEW_HEIGHT)])) {
        _branchNum = branchNum;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
	CGContextRef context = UIGraphicsGetCurrentContext();  
	//円の中身を描画  
    CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 1.0);  
	CGContextFillEllipseInRect(context, rect);  
	
	//描画方法を指定 0:手数を表示 1:顔を表示 2:何も表示しない
    CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 1.0);
    //解答用の石の場合、解答用の手数を表示する
    NSString* text;
    text =  [NSString stringWithFormat:@"%d", _branchNum];
    [text drawInRect:CGRectMake(self.frame.size.width/3, self.frame.size.width/6, self.frame.size.width, self.frame.size.height) withFont:[UIFont systemFontOfSize:FONT_SIZE]];
    
	[self becomeFirstResponder];
}

- (void)dealloc
{
    [super dealloc];
}

@end
