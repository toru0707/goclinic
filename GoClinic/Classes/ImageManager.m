//
//  ImageManager.m
//  GoClinic
//
//  Created by 猪子 徹 on 10/10/03.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ImageManager.h"


@implementation ImageManager
@synthesize b_images = _b_images;
@synthesize w_images = _w_images;
@synthesize g_w_images = _g_b_images;
@synthesize g_b_images = _g_w_images;
@synthesize faceTitles = _faceTitles;

static id _instance = nil;

NSString* BOB_B_SMILE_PATH = @"b_smile.png";	
NSString* BOB_B_NORMAL_PATH = @"b_normal.png";
NSString* BOB_B_WEAK_PATH = @"b_weak.png";
NSString* BOB_B_NOTGOOD_PATH = @"b_notgood.png";
NSString* BOB_B_SOPPO_PATH = @"b_soppo.png";
NSString* BOB_B_STRONG_PATH = @"b_strong.png";
NSString* BOB_B_BAD_PATH = @"b_bad.png";
NSString* BOB_B_DEATH_PATH = @"b_death.png";
NSString* BOB_B_BIGKARAI_PATH = @"b_bigkarai.png";
NSString* BOB_B_DOWN_PATH = @"b_down.png";
NSString* BOB_B_HANAHOJI_PATH = @"b_hanahoji.png";
NSString* BOB_B_KARAI_PATH = @"b_karai.png";
NSString* BOB_B_MONEY_PATH = @"b_money.png";
NSString* BOB_B_MOUDAME_PATH = @"b_moudame.png";
NSString* BOB_B_NANDAKA_PATH = @"b_nandaka.png";
NSString* BOB_B_NORMAL2_PATH = @"b_normal2.png";
NSString* BOB_B_ODOROKI_PATH = @"b_odoroki.png";
NSString* BOB_B_SHAKE_PATH = @"b_shake.png";
NSString* BOB_B_SHIRAN_PATH = @"b_shira-n.png";
NSString* BOB_B_SOPPO2_PATH = @"b_soppo2.png";
NSString* BOB_B_STAR_PATH = @"b_star.png";
NSString* BOB_B_SUGOISUGOI_PATH = @"b_sugoisugoi.png";
NSString* BOB_B_SUPPAI_PATH = @"b_suppai.png";
NSString* BOB_B_UP_PATH = @"b_up.png";
NSString* BOB_B_VERYGOOD_PATH = @"b_verygood";
NSString* BOB_B_YOKUDEKIMASHITA_PATH = @"b_yokudekimashita.png";
NSString* BOB_B_CHIISAI = @"b_chiisai.png";
NSString* BOB_B_OOKII = @"b_ookii.png";
NSString* BOB_B_OOKARA = @"b_ookara.png";
NSString* BOB_B_GANBARISUGI = @"b_ganbarisugi.png";
NSString* BOB_B_YONDEUTE = @"b_yondeute.png";
NSString* BOB_B_DAIAKUSYU = @"b_daiakusyu.png";
NSString* BOB_B_DAIDAIAKUSYU = @"b_daidaiakusyu.png";
NSString* BOB_B_KIMOCHIWARUI = @"b_kimochiwarui.png";
NSString* BOB_B_USUI = @"b_usui.png";
NSString* BOB_B_ATUI = @"b_atui.png";
NSString* BOB_B_HAKKYOU = @"b_hakkyou.png";
NSString* BOB_B_GOJANAI = @"gojanai.png";
NSString* BOB_B_FURUETERU = @"b_normal.png";

NSString* BOB_G_B_SMILE_PATH = @"g_b_smile.png";	
NSString* BOB_G_B_NORMAL_PATH = @"g_b_normal.png";
NSString* BOB_G_B_WEAK_PATH = @"g_b_weak.png";
NSString* BOB_G_B_NOTGOOD_PATH = @"g_b_notgood.png";
NSString* BOB_G_B_SOPPO_PATH = @"g_b_soppo.png";
NSString* BOB_G_B_STRONG_PATH = @"g_b_strong.png";
NSString* BOB_G_B_BAD_PATH = @"g_b_bad.png";
NSString* BOB_G_B_DEATH_PATH = @"g_b_death.png";
NSString* BOB_G_B_BIGKARAI_PATH = @"g_b_bigkarai.png";
NSString* BOB_G_B_DOWN_PATH = @"g_b_down.png";
NSString* BOB_G_B_HANAHOJI_PATH = @"g_b_hanahoji.png";
NSString* BOB_G_B_KARAI_PATH = @"g_b_karai.png";
NSString* BOB_G_B_MONEY_PATH = @"g_b_money.png";
NSString* BOB_G_B_MOUDAME_PATH = @"g_b_moudame.png";
NSString* BOB_G_B_NANDAKA_PATH = @"g_b_nandaka.png";
NSString* BOB_G_B_NORMAL2_PATH = @"g_b_normal2.png";
NSString* BOB_G_B_ODOROKI_PATH = @"g_b_odoroki.png";
NSString* BOB_G_B_SHAKE_PATH = @"g_b_shake.png";
NSString* BOB_G_B_SHIRAN_PATH = @"g_b_shira-n.png";
NSString* BOB_G_B_SOPPO2_PATH = @"g_b_soppo2.png";
NSString* BOB_G_B_STAR_PATH = @"g_b_star.png";
NSString* BOB_G_B_SUGOISUGOI_PATH = @"g_b_sugoisugoi.png";
NSString* BOB_G_B_SUPPAI_PATH = @"g_b_suppai.png";
NSString* BOB_G_B_UP_PATH = @"g_b_up.png";
NSString* BOB_G_B_VERYGOOD_PATH = @"g_b_verygood";
NSString* BOB_G_B_YOKUDEKIMASHITA_PATH = @"g_b_yokudekimashita.png";
NSString* BOB_G_B_CHIISAI = @"g_b_chiisai.png";
NSString* BOB_G_B_OOKII = @"g_b_ookii.png";
NSString* BOB_G_B_OOKARA = @"g_b_ookara.png";
NSString* BOB_G_B_GANBARISUGI = @"g_b_ganbarisugi.png";
NSString* BOB_G_B_YONDEUTE = @"g_b_yondeute.png";
NSString* BOB_G_B_DAIAKUSYU = @"g_b_daiakusyu.png";
NSString* BOB_G_B_DAIDAIAKUSYU = @"g_b_daidaiakusyu.png";
NSString* BOB_G_B_KIMOCHIWARUI = @"g_b_kimochiwarui.png";
NSString* BOB_G_B_USUI = @"g_b_usui.png";
NSString* BOB_G_B_ATUI = @"g_b_atui.png";
NSString* BOB_G_B_HAKKYOU = @"g_b_hakkyou.png";
NSString* BOB_G_B_GOJANAI = @"gojanai.png";
NSString* BOB_G_B_FURUETERU = @"g_b_normal.png";


NSString* BOB_W_SMILE_PATH = @"w_smile.png";	
NSString* BOB_W_NORMAL_PATH = @"w_normal.png";
NSString* BOB_W_WEAK_PATH = @"w_weak.png";
NSString* BOB_W_NOTGOOD_PATH = @"w_notgood.png";
NSString* BOB_W_SOPPO_PATH = @"w_soppo.png";
NSString* BOB_W_STRONG_PATH = @"w_strong.png";
NSString* BOB_W_BAD_PATH = @"w_bad.png";
NSString* BOB_W_DEATH_PATH = @"w_death.png";
NSString* BOB_W_BIGKARAI_PATH = @"w_bigkarai.png";
NSString* BOB_W_DOWN_PATH = @"w_down.png";
NSString* BOB_W_HANAHOJI_PATH = @"w_hanahoji.png";
NSString* BOB_W_KARAI_PATH = @"w_karai.png";
NSString* BOB_W_MONEY_PATH = @"w_money.png";
NSString* BOB_W_MOUDAME_PATH = @"w_moudame.png";
NSString* BOB_W_NANDAKA_PATH = @"w_nandaka.png";
NSString* BOB_W_NORMAL2_PATH = @"w_normal2.png";
NSString* BOB_W_ODOROKI_PATH = @"w_odoroki.png";
NSString* BOB_W_SHAKE_PATH = @"w_shake.png";
NSString* BOB_W_SHIRAN_PATH = @"w_shira-n.png";
NSString* BOB_W_SOPPO2_PATH = @"w_soppo2.png";
NSString* BOB_W_STAR_PATH = @"w_star.png";
NSString* BOB_W_SUGOISUGOI_PATH = @"w_sugoisugoi.png";
NSString* BOB_W_SUPPAI_PATH = @"w_suppai.png";
NSString* BOB_W_UP_PATH = @"w_up.png";
NSString* BOB_W_VERYGOOD_PATH = @"w_verygood";
NSString* BOB_W_YOKUDEKIMASHITA_PATH = @"w_yokudekimashita.png";
NSString* BOB_W_CHIISAI = @"w_chiisai.png";
NSString* BOB_W_OOKII = @"w_ookii.png";
NSString* BOB_W_OOKARA = @"w_ookara.png";
NSString* BOB_W_GANBARISUGI = @"w_ganbarisugi.png";
NSString* BOB_W_YONDEUTE = @"w_yondeute.png";
NSString* BOB_W_DAIAKUSYU = @"w_daiakusyu.png";
NSString* BOB_W_DAIDAIAKUSYU = @"w_daidaiakusyu.png";
NSString* BOB_W_KIMOCHIWARUI = @"w_kimochiwarui.png";
NSString* BOB_W_USUI = @"w_usui.png";
NSString* BOB_W_ATUI = @"w_atui.png";
NSString* BOB_W_HAKKYOU = @"w_hakkyou.png";
NSString* BOB_W_GOJANAI = @"gojanai.png";
NSString* BOB_W_FURUETERU = @"w_normal.png";


NSString* BOB_G_W_SMILE_PATH = @"g_w_smile.png";	
NSString* BOB_G_W_NORMAL_PATH = @"g_w_normal.png";
NSString* BOB_G_W_WEAK_PATH = @"g_w_weak.png";
NSString* BOB_G_W_NOTGOOD_PATH = @"g_w_notgood.png";
NSString* BOB_G_W_SOPPO_PATH = @"g_w_soppo.png";
NSString* BOB_G_W_STRONG_PATH = @"g_w_strong.png";
NSString* BOB_G_W_BAD_PATH = @"g_w_bad.png";
NSString* BOB_G_W_DEATH_PATH = @"g_w_death.png";
NSString* BOB_G_W_BIGKARAI_PATH = @"g_w_bigkarai.png";
NSString* BOB_G_W_DOWN_PATH = @"g_w_down.png";
NSString* BOB_G_W_HANAHOJI_PATH = @"g_w_hanahoji.png";
NSString* BOB_G_W_KARAI_PATH = @"g_w_karai.png";
NSString* BOB_G_W_MONEY_PATH = @"g_w_money.png";
NSString* BOB_G_W_MOUDAME_PATH = @"g_w_moudame.png";
NSString* BOB_G_W_NANDAKA_PATH = @"g_w_nandaka.png";
NSString* BOB_G_W_NORMAL2_PATH = @"g_w_normal2.png";
NSString* BOB_G_W_ODOROKI_PATH = @"g_w_odoroki.png";
NSString* BOB_G_W_SHAKE_PATH = @"g_w_shake.png";
NSString* BOB_G_W_SHIRAN_PATH = @"g_w_shira-n.png";
NSString* BOB_G_W_SOPPO2_PATH = @"g_w_soppo2.png";
NSString* BOB_G_W_STAR_PATH = @"g_w_star.png";
NSString* BOB_G_W_SUGOISUGOI_PATH = @"g_w_sugoisugoi.png";
NSString* BOB_G_W_SUPPAI_PATH = @"g_w_suppai.png";
NSString* BOB_G_W_UP_PATH = @"g_w_up.png";
NSString* BOB_G_W_VERYGOOD_PATH = @"g_w_verygood";
NSString* BOB_G_W_YOKUDEKIMASHITA_PATH = @"g_w_yokudekimashita.png";
NSString* BOB_G_W_CHIISAI = @"g_w_chiisai.png";
NSString* BOB_G_W_OOKII = @"g_w_ookii.png";
NSString* BOB_G_W_OOKARA = @"g_w_ookara.png";
NSString* BOB_G_W_GANBARISUGI = @"g_w_ganbarisugi.png";
NSString* BOB_G_W_YONDEUTE = @"g_w_yondeute.png";
NSString* BOB_G_W_DAIAKUSYU = @"g_w_daiakusyu.png";
NSString* BOB_G_W_DAIDAIAKUSYU = @"g_w_daidaiakusyu.png";
NSString* BOB_G_W_KIMOCHIWARUI = @"g_w_kimochiwarui.png";
NSString* BOB_G_W_USUI = @"g_w_usui.png";
NSString* BOB_G_W_ATUI = @"g_w_atui.png";
NSString* BOB_G_W_HAKKYOU = @"g_w_hakkyou.png";
NSString* BOB_G_W_GOJANAI = @"gojanai.png";
NSString* BOB_G_W_FURUETERU = @"g_w_normal.png";


-(id)initAndLoadImages{
	if((self = [super init])){
		UIImage* bob_b_image2 = [UIImage imageNamed:BOB_B_NORMAL_PATH];
		UIImage* bob_b_image3 = [UIImage imageNamed:BOB_B_SMILE_PATH];
		UIImage* bob_b_image4 = [UIImage imageNamed:BOB_B_WEAK_PATH];
		UIImage* bob_b_image5 = [UIImage imageNamed:BOB_B_STRONG_PATH];
		UIImage* bob_b_image6 = [UIImage imageNamed:BOB_B_DEATH_PATH ];
		UIImage* bob_b_image7 = [UIImage imageNamed:BOB_B_NOTGOOD_PATH ];
		UIImage* bob_b_image9 = [UIImage imageNamed:BOB_B_SOPPO_PATH];
		UIImage* bob_b_image10 = [UIImage imageNamed:BOB_B_UP_PATH ];
		UIImage* bob_b_image11 = [UIImage imageNamed:BOB_B_DOWN_PATH];
		UIImage* bob_b_image12 = [UIImage imageNamed:BOB_B_NORMAL2_PATH ];
		UIImage* bob_b_image13 = [UIImage imageNamed:BOB_B_SHIRAN_PATH ];
		UIImage* bob_b_image15 = [UIImage imageNamed:BOB_B_SOPPO2_PATH ];
		UIImage* bob_b_image16 = [UIImage imageNamed:BOB_B_NANDAKA_PATH];
		UIImage* bob_b_image17 = [UIImage imageNamed:BOB_B_KARAI_PATH ];
		UIImage* bob_b_image18 = [UIImage imageNamed:BOB_B_BIGKARAI_PATH ];
		UIImage* bob_b_image19 = [UIImage imageNamed:BOB_B_ODOROKI_PATH ];
		UIImage* bob_b_image20 = [UIImage imageNamed:BOB_B_VERYGOOD_PATH];
		UIImage* bob_b_image21 = [UIImage imageNamed:BOB_B_SUGOISUGOI_PATH ];
		UIImage* bob_b_image22 = [UIImage imageNamed:BOB_B_HANAHOJI_PATH];
		UIImage* bob_b_image23 = [UIImage imageNamed:BOB_B_STAR_PATH  ];
		UIImage* bob_b_image24 = [UIImage imageNamed:BOB_B_MONEY_PATH];
		UIImage* bob_b_image25 = [UIImage imageNamed:BOB_B_MOUDAME_PATH];
		UIImage* bob_b_image26 = [UIImage imageNamed:BOB_B_SUPPAI_PATH ];
		UIImage* bob_b_image27 = [UIImage imageNamed:BOB_B_YOKUDEKIMASHITA_PATH ];
		UIImage* bob_b_image28 = [UIImage imageNamed:BOB_B_CHIISAI ];
		UIImage* bob_b_image29 = [UIImage imageNamed:BOB_B_OOKII ];
		UIImage* bob_b_image30 = [UIImage imageNamed:BOB_B_OOKARA];
		UIImage* bob_b_image31 = [UIImage imageNamed:BOB_B_GANBARISUGI];
		UIImage* bob_b_image32 = [UIImage imageNamed:BOB_B_YONDEUTE];
		UIImage* bob_b_image33 = [UIImage imageNamed:BOB_B_DAIAKUSYU];
		UIImage* bob_b_image34 = [UIImage imageNamed:BOB_B_DAIDAIAKUSYU];
		UIImage* bob_b_image35 = [UIImage imageNamed:BOB_B_KIMOCHIWARUI];
		UIImage* bob_b_image36 = [UIImage imageNamed:BOB_B_USUI];
		UIImage* bob_b_image37 = [UIImage imageNamed:BOB_B_ATUI];
		UIImage* bob_b_image38 = [UIImage imageNamed:BOB_B_HAKKYOU];
		UIImage* bob_b_image39 = [UIImage imageNamed:BOB_B_GOJANAI];
		UIImage* bob_b_image40 = [UIImage imageNamed:BOB_B_FURUETERU];
		
		UIImage* bob_g_b_image2 = [UIImage imageNamed:BOB_G_B_NORMAL_PATH];
		UIImage* bob_g_b_image3 = [UIImage imageNamed:BOB_G_B_SMILE_PATH];
		UIImage* bob_g_b_image4 = [UIImage imageNamed:BOB_G_B_WEAK_PATH];
		UIImage* bob_g_b_image5 = [UIImage imageNamed:BOB_G_B_STRONG_PATH];
		UIImage* bob_g_b_image6 = [UIImage imageNamed:BOB_G_B_DEATH_PATH ];
		UIImage* bob_g_b_image7 = [UIImage imageNamed:BOB_G_B_NOTGOOD_PATH ];
		UIImage* bob_g_b_image9 = [UIImage imageNamed:BOB_G_B_SOPPO_PATH];
		UIImage* bob_g_b_image10 = [UIImage imageNamed:BOB_G_B_UP_PATH ];
		UIImage* bob_g_b_image11 = [UIImage imageNamed:BOB_G_B_DOWN_PATH];
		UIImage* bob_g_b_image12 = [UIImage imageNamed:BOB_G_B_NORMAL2_PATH ];
		UIImage* bob_g_b_image13 = [UIImage imageNamed:BOB_G_B_SHIRAN_PATH ];
		UIImage* bob_g_b_image15 = [UIImage imageNamed:BOB_G_B_SOPPO2_PATH ];
		UIImage* bob_g_b_image16 = [UIImage imageNamed:BOB_G_B_NANDAKA_PATH];
		UIImage* bob_g_b_image17 = [UIImage imageNamed:BOB_G_B_KARAI_PATH ];
		UIImage* bob_g_b_image18 = [UIImage imageNamed:BOB_G_B_BIGKARAI_PATH ];
		UIImage* bob_g_b_image19 = [UIImage imageNamed:BOB_G_B_ODOROKI_PATH ];
		UIImage* bob_g_b_image20 = [UIImage imageNamed:BOB_G_B_VERYGOOD_PATH];
		UIImage* bob_g_b_image21 = [UIImage imageNamed:BOB_G_B_SUGOISUGOI_PATH ];
		UIImage* bob_g_b_image22 = [UIImage imageNamed:BOB_G_B_HANAHOJI_PATH];
		UIImage* bob_g_b_image23 = [UIImage imageNamed:BOB_G_B_STAR_PATH  ];
		UIImage* bob_g_b_image24 = [UIImage imageNamed:BOB_G_B_MONEY_PATH];
		UIImage* bob_g_b_image25 = [UIImage imageNamed:BOB_G_B_MOUDAME_PATH];
		UIImage* bob_g_b_image26 = [UIImage imageNamed:BOB_G_B_SUPPAI_PATH ];
		UIImage* bob_g_b_image27 = [UIImage imageNamed:BOB_G_B_YOKUDEKIMASHITA_PATH ];
		UIImage* bob_g_b_image28 = [UIImage imageNamed:BOB_G_B_CHIISAI ];
		UIImage* bob_g_b_image29 = [UIImage imageNamed:BOB_G_B_OOKII ];
		UIImage* bob_g_b_image30 = [UIImage imageNamed:BOB_G_B_OOKARA];
		UIImage* bob_g_b_image31 = [UIImage imageNamed:BOB_G_B_GANBARISUGI];
		UIImage* bob_g_b_image32 = [UIImage imageNamed:BOB_G_B_YONDEUTE];
		UIImage* bob_g_b_image33 = [UIImage imageNamed:BOB_G_B_DAIAKUSYU];
		UIImage* bob_g_b_image34 = [UIImage imageNamed:BOB_G_B_DAIDAIAKUSYU];
		UIImage* bob_g_b_image35 = [UIImage imageNamed:BOB_G_B_KIMOCHIWARUI];
		UIImage* bob_g_b_image36 = [UIImage imageNamed:BOB_G_B_USUI];
		UIImage* bob_g_b_image37 = [UIImage imageNamed:BOB_G_B_ATUI];
		UIImage* bob_g_b_image38 = [UIImage imageNamed:BOB_G_B_HAKKYOU];
		UIImage* bob_g_b_image39 = [UIImage imageNamed:BOB_G_B_GOJANAI];
		UIImage* bob_g_b_image40 = [UIImage imageNamed:BOB_G_B_FURUETERU];
		
		UIImage* bob_w_image2 = [UIImage imageNamed:BOB_W_NORMAL_PATH];
		UIImage* bob_w_image3 = [UIImage imageNamed:BOB_W_SMILE_PATH];
		UIImage* bob_w_image4 = [UIImage imageNamed:BOB_W_WEAK_PATH];
		UIImage* bob_w_image5 = [UIImage imageNamed:BOB_W_STRONG_PATH];
		UIImage* bob_w_image6 = [UIImage imageNamed:BOB_W_DEATH_PATH ];
		UIImage* bob_w_image7 = [UIImage imageNamed:BOB_W_NOTGOOD_PATH ];
		UIImage* bob_w_image9 = [UIImage imageNamed:BOB_W_SOPPO_PATH];
		UIImage* bob_w_image10 = [UIImage imageNamed:BOB_W_UP_PATH ];
		UIImage* bob_w_image11 = [UIImage imageNamed:BOB_W_DOWN_PATH];
		UIImage* bob_w_image12 = [UIImage imageNamed:BOB_W_NORMAL2_PATH ];
		UIImage* bob_w_image13 = [UIImage imageNamed:BOB_W_SHIRAN_PATH ];
		UIImage* bob_w_image15 = [UIImage imageNamed:BOB_W_SOPPO2_PATH ];
		UIImage* bob_w_image16 = [UIImage imageNamed:BOB_W_NANDAKA_PATH];
		UIImage* bob_w_image17 = [UIImage imageNamed:BOB_W_KARAI_PATH ];
		UIImage* bob_w_image18 = [UIImage imageNamed:BOB_W_BIGKARAI_PATH ];
		UIImage* bob_w_image19 = [UIImage imageNamed:BOB_W_ODOROKI_PATH ];
		UIImage* bob_w_image20 = [UIImage imageNamed:BOB_W_VERYGOOD_PATH];
		UIImage* bob_w_image21 = [UIImage imageNamed:BOB_W_SUGOISUGOI_PATH ];
		UIImage* bob_w_image22 = [UIImage imageNamed:BOB_W_HANAHOJI_PATH];
		UIImage* bob_w_image23 = [UIImage imageNamed:BOB_W_STAR_PATH  ];
		UIImage* bob_w_image24 = [UIImage imageNamed:BOB_W_MONEY_PATH];
		UIImage* bob_w_image25 = [UIImage imageNamed:BOB_W_MOUDAME_PATH];
		UIImage* bob_w_image26 = [UIImage imageNamed:BOB_W_SUPPAI_PATH ];
		UIImage* bob_w_image27 = [UIImage imageNamed:BOB_W_YOKUDEKIMASHITA_PATH ];
		UIImage* bob_w_image28 = [UIImage imageNamed:BOB_W_CHIISAI ];
		UIImage* bob_w_image29 = [UIImage imageNamed:BOB_W_OOKII ];
		UIImage* bob_w_image30 = [UIImage imageNamed:BOB_W_OOKARA];
		UIImage* bob_w_image31 = [UIImage imageNamed:BOB_W_GANBARISUGI];
		UIImage* bob_w_image32 = [UIImage imageNamed:BOB_W_YONDEUTE];
		UIImage* bob_w_image33 = [UIImage imageNamed:BOB_W_DAIAKUSYU];
		UIImage* bob_w_image34 = [UIImage imageNamed:BOB_W_DAIDAIAKUSYU];
		UIImage* bob_w_image35 = [UIImage imageNamed:BOB_W_KIMOCHIWARUI];
		UIImage* bob_w_image36 = [UIImage imageNamed:BOB_W_USUI];
		UIImage* bob_w_image37 = [UIImage imageNamed:BOB_W_ATUI];
		UIImage* bob_w_image38 = [UIImage imageNamed:BOB_W_HAKKYOU];
		UIImage* bob_w_image39 = [UIImage imageNamed:BOB_W_GOJANAI];
		UIImage* bob_w_image40 = [UIImage imageNamed:BOB_W_FURUETERU];
		
		
		UIImage* bob_g_w_image2 = [UIImage imageNamed:BOB_G_W_NORMAL_PATH];
		UIImage* bob_g_w_image3 = [UIImage imageNamed:BOB_G_W_SMILE_PATH];
		UIImage* bob_g_w_image4 = [UIImage imageNamed:BOB_G_W_WEAK_PATH];
		UIImage* bob_g_w_image5 = [UIImage imageNamed:BOB_G_W_STRONG_PATH];
		UIImage* bob_g_w_image6 = [UIImage imageNamed:BOB_G_W_DEATH_PATH ];
		UIImage* bob_g_w_image7 = [UIImage imageNamed:BOB_G_W_NOTGOOD_PATH ];
		UIImage* bob_g_w_image9 = [UIImage imageNamed:BOB_G_W_SOPPO_PATH];
		UIImage* bob_g_w_image10 = [UIImage imageNamed:BOB_G_W_UP_PATH ];
		UIImage* bob_g_w_image11 = [UIImage imageNamed:BOB_G_W_DOWN_PATH];
		UIImage* bob_g_w_image12 = [UIImage imageNamed:BOB_G_W_NORMAL2_PATH ];
		UIImage* bob_g_w_image13 = [UIImage imageNamed:BOB_G_W_SHIRAN_PATH ];
		UIImage* bob_g_w_image15 = [UIImage imageNamed:BOB_G_W_SOPPO2_PATH ];
		UIImage* bob_g_w_image16 = [UIImage imageNamed:BOB_G_W_NANDAKA_PATH];
		UIImage* bob_g_w_image17 = [UIImage imageNamed:BOB_G_W_KARAI_PATH ];
		UIImage* bob_g_w_image18 = [UIImage imageNamed:BOB_G_W_BIGKARAI_PATH ];
		UIImage* bob_g_w_image19 = [UIImage imageNamed:BOB_G_W_ODOROKI_PATH ];
		UIImage* bob_g_w_image20 = [UIImage imageNamed:BOB_G_W_VERYGOOD_PATH];
		UIImage* bob_g_w_image21 = [UIImage imageNamed:BOB_G_W_SUGOISUGOI_PATH ];
		UIImage* bob_g_w_image22 = [UIImage imageNamed:BOB_G_W_HANAHOJI_PATH];
		UIImage* bob_g_w_image23 = [UIImage imageNamed:BOB_G_W_STAR_PATH  ];
		UIImage* bob_g_w_image24 = [UIImage imageNamed:BOB_G_W_MONEY_PATH];
		UIImage* bob_g_w_image25 = [UIImage imageNamed:BOB_G_W_MOUDAME_PATH];
		UIImage* bob_g_w_image26 = [UIImage imageNamed:BOB_G_W_SUPPAI_PATH ];
		UIImage* bob_g_w_image27 = [UIImage imageNamed:BOB_G_W_YOKUDEKIMASHITA_PATH ];
		UIImage* bob_g_w_image28 = [UIImage imageNamed:BOB_G_W_CHIISAI ];
		UIImage* bob_g_w_image29 = [UIImage imageNamed:BOB_G_W_OOKII ];
		UIImage* bob_g_w_image30 = [UIImage imageNamed:BOB_G_W_OOKARA];
		UIImage* bob_g_w_image31 = [UIImage imageNamed:BOB_G_W_GANBARISUGI];
		UIImage* bob_g_w_image32 = [UIImage imageNamed:BOB_G_W_YONDEUTE];
		UIImage* bob_g_w_image33 = [UIImage imageNamed:BOB_G_W_DAIAKUSYU];
		UIImage* bob_g_w_image34 = [UIImage imageNamed:BOB_G_W_DAIDAIAKUSYU];
		UIImage* bob_g_w_image35 = [UIImage imageNamed:BOB_G_W_KIMOCHIWARUI];
		UIImage* bob_g_w_image36 = [UIImage imageNamed:BOB_G_W_USUI];
		UIImage* bob_g_w_image37 = [UIImage imageNamed:BOB_G_W_ATUI];
		UIImage* bob_g_w_image38 = [UIImage imageNamed:BOB_G_W_HAKKYOU];
		UIImage* bob_g_w_image39 = [UIImage imageNamed:BOB_G_W_GOJANAI];
		UIImage* bob_g_w_image40 = [UIImage imageNamed:BOB_G_W_FURUETERU];
		
		
		_b_images = [[NSMutableArray alloc] initWithObjects:
					bob_b_image2,
				   	bob_b_image3,
				    bob_b_image4, 
				    bob_b_image5,
				    bob_b_image6,
				    bob_b_image7, 
				    bob_b_image9,
					bob_b_image10,
					bob_b_image11,
					bob_b_image12,
					bob_b_image13,
					bob_b_image15,
					bob_b_image16,
					bob_b_image17, 
					bob_b_image18,
					bob_b_image19,
					bob_b_image20,
					bob_b_image21,
					bob_b_image22,
					bob_b_image23,
					bob_b_image24, 
					bob_b_image25,
					bob_b_image26,
					bob_b_image27, 
					bob_b_image28,
					bob_b_image29,
					bob_b_image30,
					bob_b_image31,
					bob_b_image32,
					bob_b_image33,
					bob_b_image34, 
					bob_b_image35,
					bob_b_image36,
					bob_b_image37, 
					bob_b_image38,
					bob_b_image39, 
					bob_b_image40,
				    nil];
		
		_g_b_images = [[NSMutableArray alloc] initWithObjects:
					 bob_g_b_image2,
					 bob_g_b_image3,
					 bob_g_b_image4, 
					 bob_g_b_image5,
					 bob_g_b_image6,
					 bob_g_b_image7, 
					 bob_g_b_image9,
					 bob_g_b_image10,
					 bob_g_b_image11,
					 bob_g_b_image12,
					 bob_g_b_image13,
					 bob_g_b_image15,
					 bob_g_b_image16,
					 bob_g_b_image17, 
					 bob_g_b_image18,
					 bob_g_b_image19,
					 bob_g_b_image20,
					 bob_g_b_image21,
					 bob_g_b_image22,
					 bob_g_b_image23,
					 bob_g_b_image24, 
					 bob_g_b_image25,
					 bob_g_b_image26,
					 bob_g_b_image27, 
					 bob_g_b_image28,
					   bob_g_b_image29,
					   bob_g_b_image30,
					   bob_g_b_image31,
					   bob_g_b_image32,
					   bob_g_b_image33,
					   bob_g_b_image34, 
					   bob_g_b_image35,
					   bob_g_b_image36,
					   bob_g_b_image37, 
					   bob_g_b_image38,
					   bob_g_b_image39, 
					   bob_g_b_image40,
					 nil];
		
		_w_images = [[NSMutableArray alloc] initWithObjects:
					 bob_w_image2,
					 bob_w_image3,
					 bob_w_image4, 
					 bob_w_image5,
					 bob_w_image6,
					 bob_w_image7, 
					 bob_w_image9,
					 bob_w_image10,
					 bob_w_image11,
					 bob_w_image12,
					 bob_w_image13,
					 bob_w_image15,
					 bob_w_image16,
					 bob_w_image17, 
					 bob_w_image18,
					 bob_w_image19,
					 bob_w_image20,
					 bob_w_image21,
					 bob_w_image22,
					 bob_w_image23,
					 bob_w_image24, 
					 bob_w_image25,
					 bob_w_image26,
					 bob_w_image27, 
					 bob_w_image28,
					 bob_w_image29,
					 bob_w_image30,
					 bob_w_image31,
					 bob_w_image32,
					 bob_w_image33,
					 bob_w_image34, 
					 bob_w_image35,
					 bob_w_image36,
					 bob_w_image37, 
					 bob_w_image38,
					 bob_w_image39, 
					 bob_w_image40,
					 nil];
		
		_g_w_images = [[NSMutableArray alloc] initWithObjects:
					 bob_g_w_image2,
					 bob_g_w_image3,
					 bob_g_w_image4, 
					 bob_g_w_image5,
					 bob_g_w_image6,
					 bob_g_w_image7, 
					 bob_g_w_image9,
					 bob_g_w_image10,
					 bob_g_w_image11,
					 bob_g_w_image12,
					 bob_g_w_image13,
					 bob_g_w_image15,
					 bob_g_w_image16,
					 bob_g_w_image17, 
					 bob_g_w_image18,
					 bob_g_w_image19,
					 bob_g_w_image20,
					 bob_g_w_image21,
					 bob_g_w_image22,
					 bob_g_w_image23,
					 bob_g_w_image24, 
					 bob_g_w_image25,
					 bob_g_w_image26,
					 bob_g_w_image27, 
					 bob_g_w_image28,
					   bob_g_w_image29,
					   bob_g_w_image30,
					   bob_g_w_image31,
					   bob_g_w_image32,
					   bob_g_w_image33,
					   bob_g_w_image34, 
					   bob_g_w_image35,
					   bob_g_w_image36,
					   bob_g_w_image37, 
					   bob_g_w_image38,
					   bob_g_w_image39, 
					   bob_g_w_image40,
					 nil];
	}
    
    _faceTitles = [[NSMutableArray alloc] initWithObjects:NSLocalizedString(@"NORMAL_COMMENT", @""), 
     NSLocalizedString(@"SMILE_COMMENT", @""), NSLocalizedString(@"WEAK_COMMENT", @""),
     NSLocalizedString(@"STRONG_COMMENT", @""), NSLocalizedString(@"DEATH_COMMENT", @""),
     NSLocalizedString(@"NOTGOOD_COMMENT", @""), NSLocalizedString(@"SOPPO_COMMENT", @""),
     NSLocalizedString(@"UP_COMMENT", @""), NSLocalizedString(@"DOWN_COMMENT", @""),
     NSLocalizedString(@"NORMAL2_COMMENT", @""), NSLocalizedString(@"SHIRA-N_COMMENT", @""),
     NSLocalizedString(@"SOPPO2_COMMENT", @""), NSLocalizedString(@"NANDAKA_COMMENT", @""),
     NSLocalizedString(@"KARAI_COMMENT", @""), NSLocalizedString(@"BIGKARAI_COMMENT", @""),
     NSLocalizedString(@"ODOROKI_COMMENT", @""), NSLocalizedString(@"VERYGOOD_COMMENT", @""),
     NSLocalizedString(@"SUGOISUGOI_COMMENT", @""), NSLocalizedString(@"HANAHOJI_COMMENT", @""),
     NSLocalizedString(@"STAR_COMMENT", @""), NSLocalizedString(@"MONEY_COMMENT", @""),
     NSLocalizedString(@"MOUDAME_COMMENT", @""), NSLocalizedString(@"SUPPAI_COMMENT", @""),
     NSLocalizedString(@"YOKUDEKIMASHITA_COMMENT", @""), NSLocalizedString(@"CHIISAI_COMMENT", @""),
     NSLocalizedString(@"OOKII_COMMENT", @""), NSLocalizedString(@"OOKARA_COMMENT", @""),
     NSLocalizedString(@"GANBARISUGI_COMMENT", @""), NSLocalizedString(@"YONDEUTE_COMMENT", @""),
     NSLocalizedString(@"DAIAKUSYU_COMMENT", @""), NSLocalizedString(@"DAIDAIAKUSYU_COMMENT", @""),
     NSLocalizedString(@"KIMOCHIWARUI_COMMENT", @""), NSLocalizedString(@"USUI_COMMENT", @""),
     NSLocalizedString(@"ATUI_COMMENT", @""), NSLocalizedString(@"HAKKYOU_COMMENT", @""),
     NSLocalizedString(@"GOJANAI_COMMENT", @""), NSLocalizedString(@"FURUETERU_COMMENT", @""),nil];
    
	return self;
}

+ (id)instance
{
    @synchronized(self) {
        if (!_instance) {
            [[self alloc] initAndLoadImages];
        }
    }
    return _instance;
}

+ (id)allocWithZone:(NSZone*)zone
{
    @synchronized(self) {
        if (!_instance) {
            _instance = [super allocWithZone:zone];
            return _instance;
        }
    }
    return nil;
}

-(UIImage *)getBlackImage:(int)imageNumber{
	if (imageNumber < 0) {
		return nil;
	}
	return (UIImage *)[_b_images objectAtIndex:imageNumber];
}

-(UIImage *)getGreenBlackImage:(int)imageNumber{
	if (imageNumber < 0) {
		return nil;
	}	
	return (UIImage *)[_g_b_images objectAtIndex:imageNumber];
}

-(UIImage *)getWhiteImage:(int)imageNumber{
	if (imageNumber < 0) {
		return nil;
	}
	return (UIImage *)[_w_images objectAtIndex:imageNumber];	
}

-(UIImage *)getGreenWhiteImage:(int)imageNumber{
	if (imageNumber < 0) {
		return nil;
	}	
	return (UIImage *)[_g_w_images objectAtIndex:imageNumber];
}

- (id)copyWithZone:(NSZone*)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (unsigned)retainCount
{
    return UINT_MAX;
}

- (void)release
{
}

- (id)autorelease
{
    return self;
}

-(void)dealloc{
	[_b_images release]; _b_images = nil;
	[_g_b_images release]; _g_b_images = nil;
	[_w_images release]; _w_images = nil;
	[_g_w_images release]; _g_w_images = nil;
	[super dealloc];	
}
@end
