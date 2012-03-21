    //
//  RightButtonViewCellController.m
//  GoClinic
//
//  Created by 猪子 徹 on 10/09/30.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FacesViewCellController.h"


@implementation FacesViewCellController
@synthesize cell = _cell;

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
    [super dealloc];
}


@end
