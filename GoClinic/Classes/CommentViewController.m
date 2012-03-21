//
//  CommentViewController.m
//  GoClinic
//
//  Created by 猪子 徹 on 10/10/30.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentAddViewCell.h"
#import "CommentViewController.h"
#import "CommentViewCell.h"
#import "CommentView.h"
#import "Comments.h"

@implementation CommentViewController
@synthesize delegate = _delegate;
@synthesize comments = _comments;
@synthesize commentViewCellController = _commentViewCellController;
@synthesize commentAddViewCellController = _commentAddViewCellController;


#pragma mark -
#pragma mark View lifecycle

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil mode:(int)mode{
    if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])){
        self.view.tag = COMMENT_VIEW_CONTROLLER_TAG;
        _insertMode = mode;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
	_commentAddViewCellController = [[CommentAddViewCellController alloc] initWithNibName:@"CommentAddViewCell" bundle:nil];
	_commentAddViewCellController.delegate = self;
	_commentViewCellController = [[CommentViewCellController alloc] initWithNibName:@"CommentViewCell" bundle:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	 //tag:0 登録画面, 1:表示画面
	 switch (_insertMode) {
		case 0:
			return  [_comments count] + 1; 
		case 1:
			 return [_comments count];
		default:
			break;
	 }
	 return 0;
 }
 
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	 
	 NSString* identifier;
	 CommentAddViewCell *commentAddViewCell;
	 CommentViewCell *commentViewCell;
	 //0:登録画面 1:表示画面
	 switch (_insertMode) {
		 case 0:
			 switch (indexPath.row) {
				 case 0:
					 identifier = @"CommentAddViewCell";
					 //CommnetAddViewCellの追加
					 commentAddViewCell = (CommentAddViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
					 
					 if (commentAddViewCell == nil) {
						commentAddViewCell = (CommentAddViewCell *)_commentAddViewCellController.view;
					 }
					 commentAddViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
					 ((CommentView*)self.view).commentAddViewCell = commentAddViewCell;
					 return commentAddViewCell;
				 default:
					 //CommentViewCellの追加
					 identifier = @"CommentViewCell";
					 commentViewCell= (CommentViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];	
					 if (commentViewCell == nil) {
						 CommentViewCellController* controller = [[CommentViewCellController alloc] initWithNibName:identifier bundle:nil];
						 commentViewCell = (CommentViewCell *)controller.view;
						 [controller release];
                         
                         NSLog(@"comments count %d", [_comments count]);
						 Comments* tmp = (Comments*)[_comments objectAtIndex:indexPath.row - 1];
						 
                         NSLog(@"tmp %@", tmp.text);
						 commentViewCell.commentTextView.text = tmp.text;		
						 commentViewCell.pointLabel.text = [NSString stringWithFormat:@"%d", [tmp.point intValue]];
						 commentViewCell.categoryLabel.text = [NSString stringWithFormat:@"%d", 
						 [_categories objectAtIndex:[tmp.category intValue]]];
					 }
					 commentViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
					 ((CommentView*)self.view).commentViewCell = commentViewCell;
					 return commentViewCell;
			 }
			 return nil;
		 case 1:
			 identifier = @"CommentViewCell";
			 commentViewCell= (CommentViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];	
			 if (commentViewCell == nil) {
				 CommentViewCellController* controller = [[CommentViewCellController alloc] initWithNibName:identifier bundle:nil];
				 commentViewCell = (CommentViewCell *)controller.view;
				 [controller release];
				 Comments* tmp = (Comments*)[_comments objectAtIndex:indexPath.row];
				 
				 commentViewCell.commentTextView.text = tmp.text;		
				 commentViewCell.pointLabel.text = [NSString stringWithFormat:@"%d", [tmp.point intValue]];
				 commentViewCell.categoryLabel.text = [NSString stringWithFormat:@"%d", 
													   [_categories objectAtIndex:[tmp.category intValue]]];
			 }
			 commentViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
			 ((CommentView*)self.view).commentViewCell = commentViewCell;
			 return commentViewCell;
		 default:
			 break;
	 }
	 return nil;
 }
 
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {	
	 NSString *identifier;
	//0:登録画面 1:表示画面
	switch (_insertMode) {
		case 0:
			 switch (indexPath.row) {
				 case 0:
					 identifier = @"CommentAddViewCell";
					 CommentAddViewCell *commentAddViewCell= (CommentAddViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];	
					 if (commentAddViewCell == nil) {

						commentAddViewCell = (CommentAddViewCell *)_commentAddViewCellController.view;
					 }
					 commentAddViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
					 return commentAddViewCell.frame.size.height;
				 default:
					 identifier = @"CommentViewCell";
					 CommentViewCell *commentViewCell= (CommentViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];	
					 if (commentViewCell == nil) {
						 commentViewCell = (CommentViewCell *)_commentViewCellController.view;
					 }
					 commentViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
					 return commentViewCell.frame.size.height;
			}
			return 0;
		case 1:
			identifier = @"CommentViewCell";
			CommentViewCell *commentViewCell= (CommentViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];	
			if (commentViewCell == nil) {
				commentViewCell = (CommentViewCell *)_commentViewCellController.view;
			}
			commentViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
			return commentViewCell.frame.size.height;
			break;
		default:
			break;
	}
	return 0;

}
 

-(void)touchCategoryTextField:(id)sender{
    
    /*
	SEL sel = @selector(touchCategoryTextField:);
	id delegate = self.delegate;
	if(delegate && [delegate respondsToSelector:sel]){
		[delegate touchCategoryTextField:self];
	}*/
}

-(void)touchPointTextField:(id)sender{
    
	/*SEL sel = @selector(touchPointTextField:);
	id delegate = self.delegate;
	
	if(delegate && [delegate respondsToSelector:sel]){
		[delegate touchPointTextField:self];
	}*/
}

-(void)touchAddButton:(id)sender comment:(Comments*)comment{
	SEL sel = @selector(touchAddButton:comment:);
	id delegate = self.delegate;
	if(delegate && [delegate respondsToSelector:sel]){
		[delegate touchAddButton:sender comment:comment];
	}
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc {
	[_comments release];
	[_categories release];
	[_commentViewCellController release];
	[_commentAddViewCellController release];
    [super dealloc];
}


@end

