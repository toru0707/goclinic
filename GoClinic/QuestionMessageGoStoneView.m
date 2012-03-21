//
//  QuestionMessageGoStoneView.m
//  GoClinic
//
//  Created by 猪子 徹 on 11/06/09.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "QuestionMessageGoStoneView.h"


@implementation QuestionMessageGoStoneView

- (void)drawRect:(CGRect)rect{
    // Drawing code
	CGContextRef context = UIGraphicsGetCurrentContext();  
	//円の中身を描画  
	CGContextSetRGBFillColor(context, 0.0, 1.0, 0.0, _stoneOpacity);  
	CGContextFillEllipseInRect(context, rect);  
	
	//描画方法を指定 0:手数を表示 1:顔を表示 2:何も表示しない
    if(_showNumber){
        _isFaceDisplayed = NO;
        CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
        
        //解答用の石の場合、解答用の手数を表示する
        NSString* text;
        text = [NSString stringWithFormat:@"%d", self.move];
        float fontsize = STONE_FONT_SIZE;
        [text drawInRect:CGRectMake(self.frame.size.width/3, self.frame.size.width/6, self.frame.size.width, self.frame.size.height) withFont:[UIFont systemFontOfSize:fontsize]];
    }else{
        _isFaceDisplayed = NO;
        CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
    }
    
	//円の線を描画 
	//選択されている場合は、赤で縁取り
	if(_isHighLighted){
		if (_isFaceDisplayed) {
			//顔画像の場合は、透明な緑画像をオーバレイする
			UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"red_edge.png"]];
			imageView.frame = CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y, self.frame.size.width, self.frame.size.height);
			imageView.backgroundColor = [UIColor clearColor];
			[self addSubview:imageView];
			[imageView release];
		}else {
			CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);  
			CGContextSetLineWidth(context, 2.0);  
			CGContextStrokeEllipseInRect(context, rect);
		}
	}
	[self becomeFirstResponder];
    
}

@end
