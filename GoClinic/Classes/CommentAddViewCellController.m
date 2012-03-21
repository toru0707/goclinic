    //
//  CommentAddViewCellController.m
//  GoClinic
//
//  Created by 猪子 徹 on 10/09/30.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CommentAddViewCellController.h"
#import "CommentAddViewCell.h"
#import "Comments.h"
#import "CategoryPickerAlertViewController.h"
#import "PointPickerAlertViewController.h"


@implementation CommentAddViewCellController
@synthesize delegate = _delegate;
@synthesize cell = _cell;

-(IBAction)touchAddButton:(id)sender{
	SEL sel = @selector(touchAddButton:comment:);
	id delegate = self.delegate;
	if(delegate && [delegate respondsToSelector:sel]){
		Comments* addComment = [[Comments alloc] initNewComment];
		addComment.point = [NSNumber numberWithInt:[_cell.pointTextField.text intValue]];
		addComment.category = [NSNumber numberWithInt:[_cell.categoryTextField.text intValue]];
		addComment.text = _cell.commentTextView.text;
		[delegate touchAddButton:self comment:addComment];
	}
}


-(IBAction)touchPointTextField:(id)sender{
    
    NSMutableArray *pointArray = [[NSMutableArray alloc] init];
    for (int i=0; i <= DEFAULT_POINT_MAX; i = i + DEFAULT_POINT_DISTANCE) {
        [pointArray addObject:[NSString stringWithFormat:@"%d", i]];
    }
    
	PointPickerAlertViewController *controller;
	controller = [[PointPickerAlertViewController alloc] initWithTitle:@"情報" message:@"点数を選択して下さい" cancelButtonTitle:@"キャンセル" okButtonTitle:@"OK" pickerList:pointArray];
    controller.delegate = self;
    [controller showAlertView];
}

-(IBAction)touchCategoryTextField:(id)sender{
    NSMutableArray* categories = [[NSMutableArray alloc] initWithObjects:@"勝着",@"敗着",@"驚きましたね",@"良手",@"まずまず",@"気が付かない",@"疑問手",@"辛",@"大辛",@"甘",@"大甘",@"緩着",@"大緩着",@"悪手",@"大悪手",@"論外",nil];
	CategoryPickerAlertViewController *controller;
    controller = [[CategoryPickerAlertViewController alloc] initWithTitle:@"情報" message:@"カテゴリを選択してください" cancelButtonTitle:@"キャンセル" okButtonTitle:@"OK" pickerList:categories];
    controller.delegate = self;
    [controller showAlertView];
}


-(void)selectCategory:(id)sender selectedIndex:(int)selectedIndex category:(NSString *)category{
    _cell.categoryTextField.text = [NSString stringWithFormat:@"%d", selectedIndex];
}

-(void)selectPoint:(id)sender selectedIndex:(int)selectedIndex point:(int)point{
    _cell.pointTextField.text = [NSString stringWithFormat:@"%d", point];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
	switch (textField.tag) {
		//0:category 1:point
		case 0:
			[self touchCategoryTextField:textField];
			break;
		case 1:
			[self touchPointTextField:textField];
			break;
		default:
			break;
	}
	
	return NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)viewDidUnload {
    [super viewDidUnload];
}


- (void)dealloc {
	[_cell release];
    [_categories release];
    [super dealloc];
}


@end
