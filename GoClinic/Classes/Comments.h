//
//  Comments.h
//  GoClinic
//
//  Created by 猪子 徹 on 10/10/11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class NSManagedObject;

/**
 棋譜のコメントクラス
 @auther inoko
 */
@interface Comments :  NSManagedObject  
{
}
@property (nonatomic, retain) NSString * text; ///< コメントのテキスト
@property (nonatomic, retain) NSNumber * point; ///< ポイント
@property (nonatomic, retain) NSNumber * category; ///< カテゴリ

/**
 コンストラクタ
 @return インスタンス
 */
-(id)initNewComment;

@end



