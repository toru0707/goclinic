//
//  FacesWithNoLabelViewController.m
//  GoClinic
//
//  Created by 猪子 徹 on 11/04/04.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FacesWithNoLabelViewController.h"
#import "ImageManager.h"
#import "FacesView.h"

@implementation FacesWithNoLabelViewController
@synthesize delegate = _delegate;
@synthesize buttonColorFlag = _buttonColorFlag;


- (void)viewDidLoad {
    [super viewDidLoad];
	ImageManager* iManager = [ImageManager instance]; 
	_blackButtonImgs = [[NSMutableArray alloc] initWithArray:iManager.b_images];
	_whiteButtonImgs = [[NSMutableArray alloc] initWithArray:iManager.w_images];
	
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	switch (_buttonColorFlag) {
		case 0:
			return [_blackButtonImgs count];
		case 1:
			return [_whiteButtonImgs count];
		default:
			break;
	}
	return [_blackButtonImgs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *identifier;
	identifier = @"cell";
	UITableViewCell *tableCell= (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];	
	if (tableCell == nil) {
		tableCell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
        UIImageView *imageView;
		switch (_buttonColorFlag) {
			case 0:
                imageView = [[UIImageView alloc] initWithImage:[_blackButtonImgs objectAtIndex:indexPath.row]];
				
				break;
			case 1:
				imageView = [[UIImageView alloc] initWithImage:[_whiteButtonImgs objectAtIndex:indexPath.row]];
				break;
			default: 
				break;
		}
        [tableCell addSubview:imageView];
		[tableCell retain];
	}
	tableCell.selectionStyle = UITableViewCellSelectionStyleNone;
	return tableCell;
	
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {	
	return 30;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	SEL sel = @selector(touchFacesWithNoLabelTableViewCell:faceNumber:);
	id delegate = self.delegate;
	if(delegate && [delegate respondsToSelector:sel]){
		[delegate touchFacesWithNoLabelTableViewCell:self faceNumber:indexPath.row];
	}
}

-(void)dealloc{
    [_blackButtonImgs release];
    [_whiteButtonImgs release];
    [super dealloc];
}

@end
