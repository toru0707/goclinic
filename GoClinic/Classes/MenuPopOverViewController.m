//
//  MenuPopOverViewController.m
//  GoClinic
//
//  Created by 猪子 徹 on 10/10/12.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MenuPopOverViewController.h"


@implementation MenuPopOverViewController
@synthesize delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil menuList:(NSMutableArray*)menuList
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])){
        self.view.tag = MENU_POP_OVER_VIEW_CONTROLLER_TAG;
        _menuList = menuList;
    }
    return self;
}

- (void)viewDidLoad {
	
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_menuList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.textLabel.text = [_menuList objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	SEL sel = @selector(touchMenuItem:menuId:);
	id delegate = self.delegate;
	if(delegate && [delegate respondsToSelector:sel]){
		[delegate touchMenuItem:[_menuList objectAtIndex:indexPath.row] menuId:indexPath.row];
	}
}

- (void)dealloc {
    [_menuList release];
    [super dealloc];
}


@end

