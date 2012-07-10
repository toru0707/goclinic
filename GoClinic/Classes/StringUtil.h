//
//  Util.h
//  GoClinic
//
//  Created by 猪子 徹 on 11/05/06.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 文字列関係のUtilクラス
 
 @auther inoko
 */
@interface StringUtil : NSObject {
    
}
/**
指定された日付を文字列に変換する
*/
+(NSString*)convertDateToString:(NSDate*)date;

@end
