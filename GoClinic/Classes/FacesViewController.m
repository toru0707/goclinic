//
//  FacesViewController.m
//  GoClinic
//
//  Created by 猪子 徹 on 10/10/30.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FacesViewController.h"
#import "FacesViewCellController.h"
#import "FacesViewCell.h"
#import "FacesView.h"
#import "ImageManager.h"
#import "Global.h"

@implementation FacesViewController
@synthesize delegate = _delegate;
@synthesize facesViewCellController = _facesViewCellController;
@synthesize buttonColorFlag = _buttonColorFlag;
@synthesize blackButtonImgs = _blackButtonImgs;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])){
        self.view.tag = FACES_VIEW_CONTROLLER_TAG;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	ImageManager* iManager = [ImageManager instance]; 
	_blackButtonImgs = [[NSMutableArray alloc] initWithArray:iManager.b_images];
	_whiteButtonImgs = [[NSMutableArray alloc] initWithArray:iManager.w_images];
	_commentArray = [[NSMutableArray alloc] initWithArray:iManager.faceTitles];
	_facesViewCellController = [[FacesViewCellController alloc] initWithNibName:@"FacesViewCell" bundle:nil];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	switch (_buttonColorFlag) {
		case BLACK_USER_ID:
			return [_blackButtonImgs count];
		case WHITE_USER_ID:
			return [_whiteButtonImgs count];
		default:
			break;
	}
	return [_blackButtonImgs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *identifier;
	identifier = @"FacesViewCell";
	FacesViewCell *cell= (FacesViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];	
	if (cell == nil) {
		FacesViewCellController* controller = [[FacesViewCellController alloc] initWithNibName:identifier bundle:nil];
		cell = (FacesViewCell *)controller.view;
		switch (_buttonColorFlag) {
			case BLACK_USER_ID:
				[cell.imageView setImage:[_blackButtonImgs objectAtIndex:indexPath.row]];
				cell.buttonText.text = [_commentArray objectAtIndex:indexPath.row];
				break;
			case WHITE_USER_ID:
				[cell.imageView setImage:[_whiteButtonImgs objectAtIndex:indexPath.row]];
				cell.buttonText.text = [_commentArray objectAtIndex:indexPath.row];
				break;
			default: 
				break;
		}
		[cell retain];
	}
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	((FacesView*)self.view).cell = cell;
	return cell;
	
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {	
	NSString *identifier;
	identifier = @"FacesViewCell";
	FacesViewCell *cell= (FacesViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];	
	if (cell == nil) {
		cell = (FacesViewCell *)_facesViewCellController.view;
	}
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	return cell.frame.size.height;
	
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	SEL sel = @selector(touchFacesTableViewCell:faceNumber:comment:);
	id delegate = self.delegate;
	if(delegate && [delegate respondsToSelector:sel]){
		[delegate touchFacesTableViewCell:self faceNumber:indexPath.row comment:[_commentArray objectAtIndex:indexPath.row]];
	}
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)dealloc {
	[_facesViewCellController release]; _facesViewCellController = nil;
	[_blackButtonImgs release]; _blackButtonImgs = nil;
	[_whiteButtonImgs release]; _whiteButtonImgs = nil;
    [_commentArray release];
    [super dealloc];
}


@end




