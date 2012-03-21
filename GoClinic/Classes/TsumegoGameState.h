//
//  TsumegoGameState.h
//  GoClinic
//
//  Created by 猪子 徹 on 11/05/17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractRecordViewController.h"

/**
 詰碁モード用ViewControllerに共通した処理を提供するクラス
 @auther inoko
 */
@interface TsumegoGameState : NSObject {
    AbstractRecordViewController* _viewController;
}

/**
 コンストラクタ
 @param viewControlelr 詰碁モード用ViewController
 @return インスタンス
 */
-(id)initWithViewController:(AbstractRecordViewController*)viewController;

/**
 登録されている棋譜の中の全ての解答棋譜を表示する
 */
-(void)showAnswerStones;

/**
 盤面に表示されている解答棋譜を非表示にする
 */
-(void)clearAnswerStones;

@end
