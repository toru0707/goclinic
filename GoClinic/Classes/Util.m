//
//  Util.m
//  GoClinic
//
//  Created by 猪子 徹 on 11/05/06.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Util.h"


@implementation Util


+ (NSString*)convertDateToString:(NSDate*)date{
	NSString* date_converted;
	NSDate* date_source = date;
	// NSDateFormatter を用意します。
	NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
	// 変換用の書式を設定します。
	[formatter setDateFormat:@"YYYY/MM/dd"];
	// NSDate を NSString に変換します。
	date_converted = [formatter stringFromDate:date_source];
	return date_converted;
}

@end
