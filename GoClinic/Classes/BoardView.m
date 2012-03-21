//
//  BoardView.m
//  GoClinic
//
//  Created by 猪子 徹 on 10/08/15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BoardView.h"
NSString *GoStoneUTI = @"com.yourcompany.CopyPasteTile.GoStone";

@interface BoardView(private)
-(CGPoint)calcGoPoint:(CGRect)rect;
-(CGRect)calcNormalizedRect:(UITouch*)touch;
-(CGRect)rectFromOrigin:(CGPoint)origin inset:(int)inset;
-(CGRect)rectFromXY:(int)x y:(int)y;
-(void)animateView:(UIView *)theView toPosition:(CGPoint)thePosition;
-(void)animateFirstTouchAtPoint:(CGPoint)touchPoint forView:(UIView *)theView;
@end


@implementation BoardView

@synthesize delegate = _delegate;
@synthesize stones = _stones;
@synthesize isStarDrawn = _isStarDrawn;
@synthesize isXYScaleDrawn = _isXYScaleDrawn;
@synthesize xSize = _xSize;
@synthesize ySize = _ySize;

#define GROW_ANIMATION_DURATION_SECONDS 0.15  
#define SHRINK_ANIMATION_DURATION_SECONDS 0.15

#define BOARDVIEW_WIDTH  768
#define BOARDVIEW_HEIGHT  761
#define BOARDVIEW_X  0
#define BOARDVIEW_Y  130

-(id)initWithXYSizes:(int)x ySize:(int)y{
	if ((self = [self initWithFrame:CGRectMake(BOARDVIEW_X, BOARDVIEW_Y, BOARDVIEW_WIDTH, BOARDVIEW_HEIGHT)])) {
		_xSize = x;
		_ySize = y;
	}
	return self;
}


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
		_delegate = nil;
        self.backgroundColor = [UIColor brownColor];
		_isStarDrawn = YES;
		_isXYScaleDrawn = YES;
		_redrawBoard = YES;
    }
    return self;
}

#pragma mark -
#pragma mark Configuration
/*
- (void)awakeFromNib {
	_isStarDrawn = YES;
	_isXYScaleDrawn = YES;
		
	[self resetBoard];
	[self becomeFirstResponder];
}*/


// Touch handling, tile selection, and menu/pasteboard.
- (BOOL)canBecomeFirstResponder {
	return YES;
}


#pragma mark -
#pragma mark Drawing

- (void)drawRect:(CGRect)rect {
	
    // Draw the board
	if (_redrawBoard) {
		[self.backgroundColor set];
		UIRectFill(rect);
		UIColor *lineColor = [UIColor blackColor];
		[lineColor set];
		
		int gridWidth = (_xSize - 1) * SIDE;
		float x_offset = (self.frame.size.width - gridWidth) / 2;
		float y_offset = (self.frame.size.width - gridWidth) / 2;
		
		float x = x_offset, y = y_offset;
		for (int i=1; i < _xSize + 1; i++) {
			CGRect line = CGRectMake(x, y, 1.0, gridWidth);
			UIRectFrame(line);
			x += SIDE;
		}
		
		x = x_offset, y = y_offset;
		for (int i=1; i < _ySize + 1; i++) {
			CGRect line = CGRectMake(x, y, gridWidth, 1.0);
			UIRectFrame(line);
			y += SIDE;
		}
		
		//星を描画する
		CGContextRef context = UIGraphicsGetCurrentContext();
		if(_isStarDrawn){
			float x = x_offset, y = y_offset;
			//for (int i = 1; i < 20; i++) {
			for (int i = 1; i < _xSize + 1; i++) {
				for (int j = 1; j < _ySize + 1; j++) {
					if (_xSize == BOARD_SIZE) {
						
						if((( i == 4) && (j == 4)) || ((i == 4) && ( j == 10)) || ((i == 4) && (j == 16)) ||
						   ((i == 10) && (j == 4)) || ((i==10) && (j ==10)) || ((i == 10 ) && (j==16)) ||
						   ((i == 16) && (j==4)) || ((i==16) && (j == 10)) || ((i == 16) && (j == 16))){
							//塗りの色を設定(初期化できる)
							CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
							//塗りも描画
							CGContextFillPath(context);
							//円の塗りつぶし
							CGContextFillEllipseInRect(context, CGRectMake(x - (SIDE/8), y - (SIDE/8), SIDE/4, SIDE/4));
													
						}
					}else if (_xSize == BOARD_SIZE13) {
						if((( i == 4) && (j == 4)) || ((i == 4) && ( j == 7)) || ((i == 4) && (j == 10)) ||
						   ((i == 7) && (j == 4)) || ((i==7) && (j ==7)) || ((i == 7 ) && (j==10)) ||
						   ((i == 10) && (j==4)) || ((i==10) && (j == 7)) || ((i == 10) && (j == 10))){
							//塗りの色を設定(初期化できる)
							CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
							//塗りも描画
							CGContextFillPath(context);
							//円の塗りつぶし
							CGContextFillEllipseInRect(context, CGRectMake(x - (SIDE/8), y - (SIDE/8), SIDE/4, SIDE/4));
							
						}
					}

					y += SIDE;
				}
					
				y = y_offset;
				x += SIDE;
			}
		}
		
		//XY軸の目盛を描画する
		if(_isXYScaleDrawn){
			x = x_offset, y = y_offset;
			
			float fontsize = 18;
			for (int i = 1; i < _xSize + 1; i++) {
				NSString* text = [NSString stringWithFormat:@"%d", i];
				[text drawInRect:CGRectMake(x - SIDE/4, y - SIDE, fontsize * 2, fontsize * 2) withFont:[UIFont systemFontOfSize:fontsize]];
				x += SIDE;
			}
			
			x = x_offset, y = y_offset;
			for (int i = 1; i < _ySize + 1; i++) {
				NSString* text = [NSString stringWithFormat:@"%d", i];
				[text drawInRect:CGRectMake(x + (SIDE * _xSize) - (SIDE / 2) , y - (SIDE/4), fontsize * 2, fontsize * 2) withFont:[UIFont systemFontOfSize:fontsize]];
				y += SIDE;
			}
		}
		
		_redrawBoard = NO;
		return;
	}
	
}


#pragma mark -
#pragma mark Resetting the board

- (IBAction)resetBoard {
	_redrawBoard = YES;
	[self setNeedsDisplay];
}



#pragma mark -
#pragma mark Motion-event handling
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
	
}

// Shaking resets board.
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
	
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {	
	
}



#pragma mark -
#pragma mark Touch handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	SEL sel = @selector(touchBoard:withView:);
	id delegate = self.delegate;
	if(delegate && [delegate respondsToSelector:sel]){
		[delegate touchBoard:[touches anyObject] withView:self];
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	/*
	 登録モードで、ダブルタップの場合、メニューを出して、登録を出す
	 */
	UITouch *theTouch = [touches anyObject];
	if (([theTouch tapCount] == 1) && [self becomeFirstResponder]) {
		
		UIMenuController *theMenu = [UIMenuController sharedMenuController];
		if([theMenu isMenuVisible]){
			[theMenu setMenuVisible:NO animated:YES];
		}else{
			CGRect drawRect = [self calcNormalizedRect:theTouch];
			if (drawRect.size.width == 0) {
				return;
			}
			GoStoneView *stoneView = [[GoStoneView alloc] initWithFrame:drawRect];
            //stoneView.backgroundColor = [UIColor clearColor];
            stoneView.delegate = self;
            //現在の位置を保存する
            stoneView.originLocation = stoneView.frame;
			CGPoint point = [self calcGoPoint:drawRect];
            int x = [[NSNumber numberWithFloat:point.x] intValue];
            int y = [[NSNumber numberWithFloat:point.y] intValue];
			if ((x < 1) || (_xSize < x) || 
				(y < 1) || (_ySize < y)) {
				UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"情報" message:@"枠外です。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
				[alertView show];
				[alertView release];
				return;
			}
			SEL sel = @selector(putGoStone:x:y:);
			id delegate = self.delegate;
			if(delegate && [delegate respondsToSelector:sel]){
				[delegate putGoStone:stoneView x:x y:y];
			}

		}
	}

}


-(void) touchBeganGoStone:(NSSet *)theTouch withEvent:(UIEvent *)event withGoStoneView:(GoStoneView *)stoneView{

	_currentSelection = stoneView.record;
	_currentSelection.view.startLocation = stoneView.frame;
	_currentSelection.prevX = stoneView.record.x;
	_currentSelection.prevY = stoneView.record.y;
    NSLog(@"touchBegan prevX : %d, prevY : %d",[_currentSelection.prevX intValue], [_currentSelection.prevY intValue]);
	//石を拡大する
	NSUInteger touchCount = 0;
	for (UITouch *touch in theTouch) {
		// Send to the dispatch method, which will make sure the appropriate subview is acted upon
		[self animateFirstTouchAtPoint:[touch locationInView:self] forView:_currentSelection.view];
		touchCount++;  
	}	
	
	SEL sel = @selector(touchBeganBoardWithStone:withEvent:withGoStoneView:);
	id delegate = self.delegate;
	if(delegate && [delegate respondsToSelector:sel]){
		[delegate touchBeganBoardWithStone:[theTouch anyObject] withEvent:event withGoStoneView:stoneView];
	}
}


/**
 * 碁石の移動が完了した時に呼び出されるメソッド
 */
-(void) touchEndGoStone:(NSSet *)theTouch withEvent:(UIEvent *)event withGoStoneView:(GoStoneView *)stoneView{
	_isStoneMobed = YES;
	//石を縮める
	NSUInteger touchCount = 0;
	for (UITouch *touch in theTouch) {
		// Send to the dispatch method, which will make sure the appropriate subview is acted upon
		[self animateView:_currentSelection.view toPosition:[touch locationInView:self]];
		touchCount++;  
	}
	
	SEL sel = @selector(checkPutGoStone:withEvent:withGoStoneView:);
	id delegate = self.delegate;
	if(delegate && [delegate respondsToSelector:sel]){		
		UITouch *touch = [theTouch anyObject];
		CGRect drawRect = [self calcNormalizedRect:touch];
		if (drawRect.size.width == 0) {
			return;
		}
		CGPoint point = [self calcGoPoint:drawRect];
		
		//元の場所と同じ場合はメニューを表示する
		NSLog(@"point.x:%d, point.y:%d, stone.prevX:%d, stone.prevY:%d",[[NSNumber numberWithFloat:point.x] intValue] ,[stoneView.record.prevX intValue], [[NSNumber numberWithFloat:point.y] intValue] ,[stoneView.record.prevY intValue]);
		if (([[NSNumber numberWithFloat:point.x] intValue] == [stoneView.record.prevX intValue]) && 
			([[NSNumber numberWithFloat:point.y] intValue] == [stoneView.record.prevY intValue])) {
			_currentSelection.view.frame = _currentSelection.view.startLocation;
			_currentSelection = nil;
			
			//移動した場合は、メニューを表示させない
			_isStoneMobed = NO;
			
			sel = @selector(touchEndedBoardWithStone:withEvent:withGoStoneView:);
			if(delegate && [delegate respondsToSelector:sel]){
				[delegate touchEndedBoardWithStone:[theTouch anyObject] withEvent:event withGoStoneView:stoneView];
			}
			return;
		}
		
		stoneView.record.x = [NSNumber numberWithFloat:point.x];
		stoneView.record.y = [NSNumber numberWithFloat:point.y];
		 switch ([delegate checkPutGoStone:[theTouch anyObject] withEvent:event withGoStoneView:stoneView]) {
 			UIAlertView* alertView;
			 case -1:
				 //既に石が置かれていれば置けないようにする
				 alertView = [[UIAlertView alloc] initWithTitle:@"情報" message:@"既に石が置かれています。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
				 [alertView show];
				 [alertView release];
				 
				 _currentSelection.view.frame = _currentSelection.view.startLocation;
				 _currentSelection.x = _currentSelection.prevX;
				 _currentSelection.y = _currentSelection.prevY;
				 _currentSelection = nil;
				 return;
			 case -2:
				 //自殺手のため、アラートビューを表示して終了
				 alertView = [[UIAlertView alloc] initWithTitle:@"情報" message:@"自殺手です。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
				 [alertView show];
				 [alertView release];
				 
				 _currentSelection.view.frame = _currentSelection.view.startLocation;
				 _currentSelection.x = _currentSelection.prevX;
				 _currentSelection.y = _currentSelection.prevY;
				 _currentSelection = nil;
				 return;			 
			 default:
				 break;
		 } 
		
		//石を置ける場合は石を移動する（登録画面のみ）
        sel = @selector(moveGoStone:toRect:);
        if(delegate && [delegate respondsToSelector:sel]){
            [delegate moveGoStone:stoneView toRect:drawRect];
        }
		
	}
    
    //TODO 石の上に分岐する数を表示する
	sel = @selector(touchEndedBoardWithStone:withEvent:withGoStoneView:);
	if(delegate && [delegate respondsToSelector:sel]){
		[delegate touchEndedBoardWithStone:[theTouch anyObject] withEvent:event withGoStoneView:stoneView];
	}
}


-(void) touchCancelledGoStone:(NSSet *)theTouch withEvent:(UIEvent *)event withGoStoneView:(GoStoneView *)stoneView{

	NSUInteger touchCount = 0;
	for (UITouch *touch in theTouch) {
		// Send to the dispatch method, which will make sure the appropriate subview is acted upon
		[self animateView:_currentSelection.view toPosition:[touch locationInView:self]];
		touchCount++;  
	}
	_currentSelection.view.frame = _currentSelection.view.startLocation;
	_currentSelection.x = _currentSelection.prevX;
	_currentSelection.y = _currentSelection.prevY;
	_currentSelection = nil;
}


-(void)touchForMenu:(NSSet *)theTouch withEvent:(UIEvent*)event withGoStoneView:(GoStoneView *)stoneView{
	//石が移動した場合はメニューを表示させない
	if (_isStoneMobed) {
		return;
	}
	SEL sel = @selector(touchForMenuWithStone:withEvent:withGoStoneView:);
	id delegate = self.delegate;
	if(delegate && [delegate respondsToSelector:sel]){
		[delegate touchForMenuWithStone:[theTouch anyObject] withEvent:event withGoStoneView:stoneView];
	}
}

-(void) touchForMenuCancel:(GoStoneView*)stoneView{
	SEL sel = @selector(touchForMenuCancelWithStone:);
	id delegate = self.delegate;
	if(delegate && [delegate respondsToSelector:sel]){
		[delegate touchForMenuCancelWithStone:stoneView];
	}
}

- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
    NSUInteger touchCount = 0;
    // Enumerates through all touch objects
    for (UITouch *touch in touches) {
        // Send to the dispatch method, which will make sure the appropriate subview is acted upon
        _currentSelection.view.center = [touch locationInView:self];
        NSLog(@"touchMoved prevX : %d, prevY : %d",[_currentSelection.prevX intValue], [_currentSelection.prevY intValue]);
        touchCount++;
    }
	
}


// Scales up a view slightly which makes the piece slightly larger, as if it is being picked up by the user.
-(void)animateFirstTouchAtPoint:(CGPoint)touchPoint forView:(UIImageView *)theView 
{
	// Pulse the view by scaling up, then move the view to under the finger.
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:GROW_ANIMATION_DURATION_SECONDS];
	theView.transform = CGAffineTransformMakeScale(1.2, 1.2);
	[UIView commitAnimations];
}

// Scales down the view and moves it to the new position. 
-(void)animateView:(UIView *)theView toPosition:(CGPoint)thePosition
{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:SHRINK_ANIMATION_DURATION_SECONDS];
	// Set the center to the final postion
	theView.center = thePosition;
	// Set the transform back to the identity, thus undoing the previous scaling effect.
	theView.transform = CGAffineTransformIdentity;
	[UIView commitAnimations];	
}

/**
 指定された石を指定された方向にアニメーションさせる
 
 */
-(void)animateStones:(NSMutableSet*)recordArray orientation:(UIDeviceOrientation)orientation duration:(float)duration{
	
	GameRecords* record;
	NSEnumerator* e = [recordArray objectEnumerator]; 
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:duration];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	while ((record = (GameRecords*)[e nextObject]) != nil) {
		if (orientation==UIDeviceOrientationLandscapeLeft) {
			NSLog(@"横(左90度回転)");
			//-x方向に落下
			record.view.center = CGPointMake(record.view.frame.size.width * -1, record.view.frame.origin.y);
		} else if (orientation==UIDeviceOrientationLandscapeRight) {
			NSLog(@"横(右90度回転)");
			//+x方向に落下
			record.view.center = CGPointMake(record.view.frame.size.width + [[UIScreen mainScreen] bounds].size.width, record.view.frame.origin.y);
		} else if (orientation==UIDeviceOrientationPortraitUpsideDown) {
			NSLog(@"縦(上下逆)");
		} else if (orientation==UIDeviceOrientationPortrait) {
			NSLog(@"縦");
		} else if (orientation==UIDeviceOrientationFaceUp) {
			NSLog(@"画面が上向き");
		} else if (orientation==UIDeviceOrientationFaceDown) {
			NSLog(@"画面が下向き");
		} 
	}
	[UIView commitAnimations];	
	
}


-(GameRecords*)createGameRecords:(int)x y:(int)y{
    GameRecords* record =  [[GameRecords alloc] initWithFrame:[self rectFromXY:x y:y]];
    record.x = [NSNumber numberWithInt:x];
    record.y = [NSNumber numberWithInt:y];
    return record;
}

#pragma mark -
#pragma mark Utility methods

- (CGRect)rectFromOrigin:(CGPoint)origin inset:(int)inset {
	return CGRectMake(origin.x+inset, origin.y+inset, SIDE-inset-1.0, SIDE-inset-1.0);
}

- (CGRect)rectFromXY:(int)x y:(int)y{
    int gridWidth = (_xSize) * SIDE;
	int gridHeight = (_ySize) * SIDE;
	float x_offset = (self.frame.size.width - gridWidth) / 2;
	float y_offset = (self.frame.size.height - gridHeight) / 2;
    float x_origin = x_offset + (SIDE * (x - 1));
    float y_origin = y_offset + (SIDE * (y - 1));
    return CGRectMake(x_origin + TILE_INSET/2, y_origin + TILE_INSET/2 , SIDE - TILE_INSET - 1.0, SIDE - TILE_INSET - 1.0);
}

/*
 タッチしたポイントから碁石の位置を計算する
 原点は1,1とする
 */
-(CGPoint) calcGoPoint:(CGRect)rect{
	int gridWidth = (_xSize) * SIDE;
	int gridHeight = (_ySize) * SIDE;
	float x_offset = (self.frame.size.width - gridWidth) / 2;
	float y_offset = (self.frame.size.height - gridHeight) / 2;
	long int tempX = lround(rect.origin.x - x_offset);
	long int tempY = lround(rect.origin.y - y_offset);
	
	if ((tempX < 0) || (tempY < 0)) {
		return CGPointMake(0, 0);
	}
	
	long int aSide = (long int)(SIDE);
	long int origxoffset = tempX / aSide;
	long int origyoffset = tempY / aSide;
	
	CGPoint point = CGPointMake(origxoffset + 1, origyoffset + 1);
	return point;
}

-(CGRect)calcNormalizedRect:(UITouch*)touch{
	CGPoint tapPoint = [touch locationInView:self];
	
	if (tapPoint.y > (SIDE * 20) + Y_OFFSET) {
	//if(tapPoint.y > (SIDE * _xSize) + Y_OFFSET){
	return CGRectMake(0,0,0,0);
	}
	
	long int tempX = lround(tapPoint.x+ (SIDE / 2));
	long int tempY = lround(tapPoint.y + (SIDE/2));
	long int aSide = (long int)(SIDE);
	long int origxoffset = tempX%aSide;
	long int origyoffset = tempY%aSide;
	tapPoint.x = (double)(tempX - (SIDE / 2)) - origxoffset;
	tapPoint.y = (double)(tempY - (SIDE / 2)) - origyoffset;
	return [self rectFromOrigin:tapPoint inset:TILE_INSET];
}



- (void)dealloc {
    [super dealloc];
}




@end
