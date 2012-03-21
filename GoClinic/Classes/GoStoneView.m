//
//  GoStoneView.m
//  GoClinic
//
//  Created by 猪子 徹 on 10/08/15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GoStoneView.h"
#import "ImageManager.h"
#import "GameRecords.h"
#import "Global.h"


@interface GoStoneView (private)
@end

@implementation GoStoneView
@synthesize delegate = _delegate;
@synthesize move = _move;
@synthesize faceId = _faceId;
@synthesize displayMode = _displayMode;
@synthesize showFace = _showFace;
@synthesize showNumber = _showNumber;
@synthesize isHighLighted = _isHighLighted;
@synthesize isFaceDisplayed = _isFaceDisplayed;
@synthesize isHavingBranches = _isHavingBranches;
@synthesize stoneOpacity = _stoneOpacity;
@synthesize stoneColorId = _stoneColorId;
@synthesize originLocation = _originLocation;
@synthesize startLocation = _startLocation;
@synthesize record = _record;

@synthesize real_x = _real_x;
@synthesize real_y = _real_y;


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
		_delegate = nil;
		_stoneOpacity = 1.0;
		_isHighLighted = NO;
		_faceId = -1;
        
		self.real_x = [[NSNumber numberWithFloat:frame.origin.x] intValue];
		self.real_y = [[NSNumber numberWithFloat:frame.origin.y] intValue];
		self.backgroundColor = [UIColor clearColor];
	}
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
	if((self = [super initWithCoder:aDecoder])){
		_delegate = nil;
	}
	return self;
}

-(id)initWithGameRecords:(GameRecords*)record{
    NSLog(@"realx : %f, realy : %f, width : %f, height : %f", [record.real_x floatValue], [record.real_y floatValue], [record.width floatValue], [record.height floatValue]);
	if((self = [super initWithFrame:CGRectMake([record.real_x floatValue], [record.real_y floatValue], 
											  [record.width floatValue], [record.height floatValue])])){
		_move = [record.move intValue];
		_faceId = [record.face_id intValue];
		_stoneOpacity = 1.0;
        self.record = record;
		self.backgroundColor = [UIColor clearColor];
	}
	return self;
}


-(void)drawNumber{
    // Drawing code
	CGContextRef context = UIGraphicsGetCurrentContext();  
    _isFaceDisplayed = NO;
    switch (self.stoneColorId) {
        case GOSTONE_VIEW_WHITE_COLOR_ID:
            CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 1.0);
            break;
        case GOSTONE_VIEW_BLACK_COLOR_ID:
            CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
            break;
        default:
            break;
    }
    
    //解答用の石の場合、解答用の手数を表示する
    NSString* text;
    text = ([self.record.is_answer boolValue]) ? [NSString stringWithFormat:@"%d", [self.record.answer_move intValue]] : [NSString stringWithFormat:@"%d", self.move];
    float fontsize = STONE_FONT_SIZE;
    [text drawInRect:CGRectMake(self.frame.size.width/3, self.frame.size.width/6, self.frame.size.width, self.frame.size.height) withFont:[UIFont systemFontOfSize:fontsize]];
    
    if(_faceView != nil){
        
        [_faceView removeFromSuperview];
    }
}

-(void)drawFace{
    if (_faceId >= 0) {
        _isFaceDisplayed = YES;
        
        ImageManager* iManager = [ImageManager instance]; 
        UIImage* image;
        switch ([self.record.user_id intValue]) {
            case GOSTONE_VIEW_WHITE_COLOR_ID:
                image = [iManager getWhiteImage:_faceId];
                break;
            case GOSTONE_VIEW_BLACK_COLOR_ID:
                image = [iManager getBlackImage:_faceId];
                break;
            default:
                break;
        }
        UIImageView* imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y, self.frame.size.width, self.frame.size.height);
        _faceView = imageView;
        [self addSubview:imageView];
    }
}

-(void)drawNone{
    // Drawing code
	CGContextRef context = UIGraphicsGetCurrentContext();  
    _isFaceDisplayed = NO;
    switch (self.stoneColorId) {
        case GOSTONE_VIEW_WHITE_COLOR_ID:
            CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 1.0);
            break;
        case GOSTONE_VIEW_BLACK_COLOR_ID:
            CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
            break;
        default:
            break;
    }
    if(_faceView != nil){
        [_faceView removeFromSuperview];
    }
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
	CGContextRef context = UIGraphicsGetCurrentContext();  
	//円の中身を描画  
	switch (self.stoneColorId) {
		case 0:
			CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, _stoneOpacity);  
			break;
		case 1:
			CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, _stoneOpacity);  
			break;
		default:
			break;
	}
	CGContextFillEllipseInRect(context, rect);  
	
	//描画方法を指定 0:手数を表示 1:顔を表示 2:何も表示しない
    if(_showNumber){
        [self drawNumber];
        /*_isFaceDisplayed = NO;
        switch (self.stoneColorId) {
            case GOSTONE_VIEW_WHITE_COLOR_ID:
                CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 1.0);
                break;
            case GOSTONE_VIEW_BLACK_COLOR_ID:
                CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
                break;
            default:
                break;
        }
        
        //解答用の石の場合、解答用の手数を表示する
        NSString* text;
        text = ([self.record.is_answer boolValue]) ? [NSString stringWithFormat:@"%d", [self.record.answer_move intValue]] : [NSString stringWithFormat:@"%d", self.move];
        float fontsize = STONE_FONT_SIZE;
        [text drawInRect:CGRectMake(self.frame.size.width/3, self.frame.size.width/6, self.frame.size.width, self.frame.size.height) withFont:[UIFont systemFontOfSize:fontsize]];
        
        if(_faceView != nil){
            
            [_faceView removeFromSuperview];
        }*/
    }else if(_showFace){
        [self drawFace];
        /*
        if (_faceId >= 0) {
            _isFaceDisplayed = YES;
            
            ImageManager* iManager = [ImageManager instance]; 
            UIImage* image;
            switch ([self.record.user_id intValue]) {
                case GOSTONE_VIEW_WHITE_COLOR_ID:
                    image = [iManager getWhiteImage:_faceId];
                    break;
                case GOSTONE_VIEW_BLACK_COLOR_ID:
                    image = [iManager getBlackImage:_faceId];
                    break;
                default:
                    break;
            }
            UIImageView* imageView = [[UIImageView alloc] initWithImage:image];
            imageView.frame = CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y, self.frame.size.width, self.frame.size.height);
            _faceView = imageView;
            [self addSubview:imageView];
        }
        */
    }else{
        [self drawNone];
        /*
        _isFaceDisplayed = NO;
        switch (self.stoneColorId) {
            case GOSTONE_VIEW_WHITE_COLOR_ID:
                CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 1.0);
                break;
            case GOSTONE_VIEW_BLACK_COLOR_ID:
                CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
                break;
            default:
                break;
        }
        if(_faceView != nil){
            [_faceView removeFromSuperview];
        }*/
    }
		
	//円の線を描画 
	//分岐がある場合は、緑で縁取り
    if (self.record.branch_records != nil) {
        [self drawGreenCircle];
    }
    
	//選択されている場合は、赤で縁取り
	if(_isHighLighted){
		[self drawRedCircle];
	}
	[self becomeFirstResponder];
}

- (void)drawGreenCircle{
		if (_isFaceDisplayed) {
			//顔画像の場合は、透明な緑画像をオーバレイする
			UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"green_edge.png"]];
			imageView.frame = CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y, self.frame.size.width, self.frame.size.height);
			imageView.backgroundColor = [UIColor clearColor];
			[self addSubview:imageView];
			[imageView release];
		}else {
            CGContextRef context = UIGraphicsGetCurrentContext();  
            
			CGContextSetRGBStrokeColor(context, 0.0, 1.0, 0.0, 1.0);  
			CGContextSetLineWidth(context, 2.0);  
			CGContextStrokeEllipseInRect(context, self.frame);
		}
	
}

- (void)drawRedCircle{
        if (_isFaceDisplayed) {
			//顔画像の場合は、透明な緑画像をオーバレイする
			UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"red_edge.png"]];
			imageView.frame = CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y, self.frame.size.width, self.frame.size.height);
			imageView.backgroundColor = [UIColor clearColor];
			[self addSubview:imageView];
			[imageView release];
		}else {
            CGContextRef context = UIGraphicsGetCurrentContext();  
			CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);  
			CGContextSetLineWidth(context, 2.0);  
			CGContextStrokeEllipseInRect(context, self.frame);
		}

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	//GoStoneViewのタッチメソッドをデリゲート
	SEL sel = @selector(touchBeganGoStone:withEvent:withGoStoneView:);
	id delegate = self.delegate;
	if(delegate && [delegate respondsToSelector:sel]){
		[delegate touchBeganGoStone:touches withEvent:event withGoStoneView:self];
	}
	
	//押しっぱなしにした1秒後にメニュー表示用のメソッドを呼び出す
	_menuTimer = [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(invokeTouchForMenu) 
												userInfo:nil repeats:NO];

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	//メニュー表示をキャンセル
	if (_menuTimer) {
		[_menuTimer invalidate];
		_menuTimer = nil;
		SEL sel = @selector(touchForMenuCancel:);
		id delegate = self.delegate;
		if(delegate && [delegate respondsToSelector:sel]){
			[delegate touchForMenuCancel:self];
		}
	}
	
	//GoStoneViewのタッチメソッドをデリゲート
	SEL sel = @selector(touchEndGoStone:withEvent:withGoStoneView:);
	id delegate = self.delegate;
	if(delegate && [delegate respondsToSelector:sel]){
		[delegate touchEndGoStone:touches withEvent:event withGoStoneView:self];
	}

}


- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
	//メニュー表示をキャンセル
	if (_menuTimer) {
		[_menuTimer invalidate];
		_menuTimer = nil;
		SEL sel = @selector(touchForMenuCancel:);
		id delegate = self.delegate;
		if(delegate && [delegate respondsToSelector:sel]){
			[delegate touchForMenuCancel:self];
		}
	}
	//GoStoneViewのタッチメソッドをデリゲート
	SEL sel = @selector(touchCancelledGoStone:withEvent:withGoStoneView:);
	id delegate = self.delegate;
	
	if(delegate && [delegate respondsToSelector:sel]){
		[delegate touchCancelledGoStone:touches withEvent:event withGoStoneView:self];
	}
}

/**
 メニュー表示用のデリゲートメソッドを呼び出すためのメソッド
 */
-(void)invokeTouchForMenu{
	//メニュー表示用のデリゲートメソッドを呼び出す
	SEL sel = @selector(touchForMenu:withEvent:withGoStoneView:);
	id delegate = self.delegate;
	
	if(delegate && [delegate respondsToSelector:sel]){
		[delegate touchForMenu:nil withEvent:nil withGoStoneView:self];
	}
	_menuTimer = nil;
}

-(void)showContextMenu:(UIView*)targetView{
    UIMenuController *theMenu = [UIMenuController sharedMenuController];
	if([theMenu isMenuVisible]){
		[theMenu setMenuVisible:NO animated:YES];
	}else{
		[theMenu setTargetRect:self.frame inView:targetView];
		UIMenuItem *commentMenuItem = [[[UIMenuItem alloc] initWithTitle:@"コメント" action:@selector(commentGoStoneMenu:)] autorelease];
		UIMenuItem *clinicMenuItem = [[[UIMenuItem alloc] initWithTitle:@"クリニック" action:@selector(clinicGoStoneMenu:)] autorelease];
		UIMenuItem *faceRegistMenuItem = [[[UIMenuItem alloc] initWithTitle:@"顔登録" action:@selector(faceRegistGoStoneMenu:)] autorelease];
		UIMenuItem *deleteMenuItem = [[[UIMenuItem alloc] initWithTitle:@"削除" action:@selector(deleteGoStoneMenu:)] autorelease];
        UIMenuItem *henkazuMenuItem = [[[UIMenuItem alloc] initWithTitle:@"変化図を登録" action:@selector(henkazuMenuItem:)] autorelease];
        
		theMenu.menuItems = [NSArray arrayWithObjects:commentMenuItem, clinicMenuItem, faceRegistMenuItem, deleteMenuItem, nil];
		[theMenu setMenuVisible:YES animated:YES];
	}
}

-(BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)dealloc {
	[_faceView release];
	[_record release];
	[_menuTimer release];
    [super dealloc];
}


@end
