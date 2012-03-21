//
//  ImageManager.h
//  GoClinic
//
//  Created by 猪子 徹 on 10/10/03.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#define BOB_B_SMILE 0
#define BOB_B_NORMAL 1
#define BOB_B_WEAK 2
#define BOB_B_NOTGOOD 3
#define BOB_B_SOPPO 4
#define BOB_B_STRONG 5
#define BOB_B_BAD 6
#define BOB_B_DEATH 7
#define BOB_B_BIGKARAI 8
#define BOB_B_DOWN 9
#define BOB_B_HANAHOJI 10
#define	BOB_B_KARAI 11
#define BOB_B_MONEY 12
#define	BOB_B_MOUDAME 13
#define	BOB_B_NANDAKA 14
#define	BOB_B_NORMAL2 15
#define	BOB_B_ODOROKI 17
#define	BOB_B_SHAKE 18
#define	BOB_B_SHIRAN 19
#define	BOB_B_SOPPO2 20
#define	BOB_B_STAR 21
#define	BOB_B_SUGOISUGOI 22
#define	BOB_B_SUPPAI 23
#define	BOB_B_UP 24
#define	BOB_B_VERYGOOD 25
#define	BOB_B_YOKUDEKIMASHITA 26

#define BOB_W_SMILE 0
#define BOB_W_NORMAL 1
#define BOB_W_WEAK 2
#define BOB_W_NOTGOOD 3
#define BOB_W_SOPPO 4
#define BOB_W_STRONG 5
#define BOB_W_BAD 6
#define BOB_W_DEATH 7
#define BOB_W_BIGKARAI 8
#define BOB_W_DOWN 9
#define BOB_W_HANAHOJI 10
#define	BOB_W_KARAI 11
#define BOB_W_MONEY 12
#define	BOB_W_MOUDAME 13
#define	BOB_W_NANDAKA 14
#define	BOB_W_NORMAL2 15
#define	BOB_W_ODOROKI 17
#define	BOB_W_SHAKE 18
#define	BOB_W_SHIRAN 19
#define	BOB_W_SOPPO2 20
#define	BOB_W_STAR 21
#define	BOB_W_SUGOISUGOI 22
#define	BOB_W_SUPPAI 23
#define	BOB_W_UP 24
#define	BOB_W_VERYGOOD 25
#define	BOB_W_YOKUDEKIMASHITA 26


/**
 BOB画像を扱うシングルトンクラス。
 @auther inoko
 */
@interface ImageManager : NSObject {
	NSMutableArray* _b_images;
	NSMutableArray* _g_b_images;
	NSMutableArray* _w_images;
	NSMutableArray* _g_w_images;
    NSArray* _faceTitles;

}
@property(nonatomic, retain)NSMutableArray* b_images;
@property(nonatomic, retain)NSMutableArray* w_images;
@property(nonatomic, retain)NSMutableArray* g_b_images;
@property(nonatomic, retain)NSMutableArray* g_w_images;
@property(nonatomic, readonly, retain)NSArray* faceTitles;

/**
 インスタンス取得メソッド
 @return インスタンス
 */
+ (id)instance;

/**
 黒石用のBOB画像を取得する
 @param param 画像のIndex
 @return BOB画像オブジェクト
 */
-(UIImage *)getBlackImage:(int)imageNumber;

/**
 黒石用のBOB画像を取得する（緑の縁取り有り）
 @param param 画像のIndex
 @return BOB画像オブジェクト
 */
-(UIImage *)getGreenBlackImage:(int)imageNumber;

/**
 白石用のBOB画像を取得する
 @param param 画像のIndex
 @return BOB画像オブジェクト
 */
-(UIImage *)getWhiteImage:(int)imageNumber;

/**
 白石用のBOB画像を取得する（緑の縁取り有り）
 @param param 画像のIndex
 @return BOB画像オブジェクト
 */
-(UIImage *)getGreenWhiteImage:(int)imageNumber;
@end
