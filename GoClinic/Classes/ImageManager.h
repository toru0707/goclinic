//
//  ImageManager.h
//  GoClinic
//
//  Created by 猪子 徹 on 10/10/03.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#define BOB_B_SMILE 0 ///< 黒石のBOB顔ID
#define BOB_B_NORMAL 1 ///< 黒石のBOB顔ID
#define BOB_B_WEAK 2 ///< 黒石のBOB顔ID
#define BOB_B_NOTGOOD 3 ///< 黒石のBOB顔ID
#define BOB_B_SOPPO 4 ///< 黒石のBOB顔ID
#define BOB_B_STRONG 5 ///< 黒石のBOB顔ID
#define BOB_B_BAD 6 ///< 黒石のBOB顔ID
#define BOB_B_DEATH 7 ///< 黒石のBOB顔ID
#define BOB_B_BIGKARAI 8 ///< 黒石のBOB顔ID
#define BOB_B_DOWN 9 ///< 黒石のBOB顔ID
#define BOB_B_HANAHOJI 10 ///< 黒石のBOB顔ID
#define	BOB_B_KARAI 11 ///< 黒石のBOB顔ID
#define BOB_B_MONEY 12 ///< 黒石のBOB顔ID
#define	BOB_B_MOUDAME 13 ///< 黒石のBOB顔ID
#define	BOB_B_NANDAKA 14 ///< 黒石のBOB顔ID
#define	BOB_B_NORMAL2 15 ///< 黒石のBOB顔ID
#define	BOB_B_ODOROKI 17 ///< 黒石のBOB顔ID
#define	BOB_B_SHAKE 18 ///< 黒石のBOB顔ID
#define	BOB_B_SHIRAN 19 ///< 黒石のBOB顔ID
#define	BOB_B_SOPPO2 20 ///< 黒石のBOB顔ID
#define	BOB_B_STAR 21 ///< 黒石のBOB顔ID
#define	BOB_B_SUGOISUGOI 22 ///< 黒石のBOB顔ID
#define	BOB_B_SUPPAI 23 ///< 黒石のBOB顔ID
#define	BOB_B_UP 24 ///< 黒石のBOB顔ID
#define	BOB_B_VERYGOOD 25 ///< 黒石のBOB顔ID
#define	BOB_B_YOKUDEKIMASHITA 26 ///< 黒石のBOB顔ID

#define BOB_W_SMILE 0 ///< 白石のBOB顔ID
#define BOB_W_NORMAL 1 ///< 白石のBOB顔ID
#define BOB_W_WEAK 2 ///< 白石のBOB顔ID
#define BOB_W_NOTGOOD 3 ///< 白石のBOB顔ID
#define BOB_W_SOPPO 4 ///< 白石のBOB顔ID
#define BOB_W_STRONG 5 ///< 白石のBOB顔ID
#define BOB_W_BAD 6 ///< 白石のBOB顔ID
#define BOB_W_DEATH 7 ///< 白石のBOB顔ID
#define BOB_W_BIGKARAI 8 ///< 白石のBOB顔ID
#define BOB_W_DOWN 9 ///< 白石のBOB顔ID
#define BOB_W_HANAHOJI 10 ///< 白石のBOB顔ID
#define	BOB_W_KARAI 11 ///< 白石のBOB顔ID
#define BOB_W_MONEY 12 ///< 白石のBOB顔ID
#define	BOB_W_MOUDAME 13 ///< 白石のBOB顔ID
#define	BOB_W_NANDAKA 14 ///< 白石のBOB顔ID
#define	BOB_W_NORMAL2 15 ///< 白石のBOB顔ID
#define	BOB_W_ODOROKI 17 ///< 白石のBOB顔ID
#define	BOB_W_SHAKE 18 ///< 白石のBOB顔ID
#define	BOB_W_SHIRAN 19 ///< 白石のBOB顔ID
#define	BOB_W_SOPPO2 20 ///< 白石のBOB顔ID
#define	BOB_W_STAR 21 ///< 白石のBOB顔ID
#define	BOB_W_SUGOISUGOI 22 ///< 白石のBOB顔ID
#define	BOB_W_SUPPAI 23 ///< 白石のBOB顔ID
#define	BOB_W_UP 24 ///< 白石のBOB顔ID
#define	BOB_W_VERYGOOD 25 ///< 白石のBOB顔ID
#define	BOB_W_YOKUDEKIMASHITA 26 ///< 白石のBOB顔ID

/** ///< 白石のBOB顔ID
 BOB画像を格納するクラス
 @auther inoko
 */
@interface ImageManager : NSObject {
	NSMutableArray* _b_images; ///< プロパティ受け渡し用変数
	NSMutableArray* _g_b_images; ///< プロパティ受け渡し用変数
	NSMutableArray* _w_images; ///< プロパティ受け渡し用変数
	NSMutableArray* _g_w_images; ///< プロパティ受け渡し用変数
  NSArray* _faceTitles; ///< プロパティ受け渡し用変数

}
@property(nonatomic, retain)NSMutableArray* b_images; ///<黒石のBOB顔配列
@property(nonatomic, retain)NSMutableArray* w_images; ///<白石のBOB顔配列
@property(nonatomic, retain)NSMutableArray* g_b_images; ///<黒石のBOB顔配列
@property(nonatomic, retain)NSMutableArray* g_w_images; ///<白石のBOB顔配列
@property(nonatomic, readonly, retain)NSArray* faceTitles; ///<BOB顔の名前配列

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
