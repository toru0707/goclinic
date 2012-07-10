//
//  RecordRegistViewController.h
//  GoClinic
//
//  Created by 猪子 徹 on 10/08/15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import	"AbstractRecordViewController.h"
#import "FacesViewController.h"
#import "DatePickerAlertViewController.h"
#import "SaveGameAlertViewController.h"
#import "InputGameNameAlertViewController.h"
#import "RegistGameAlertViewController.h"


@class FacesView;

/**
 碁石登録用ViewControllerの基底となる抽象クラス
 @auther inoko
 */
@interface RecordRegistViewController : AbstractRecordViewController <BoardViewDelegate, CommentViewControllerDelegate, FacesViewControllerDelegate,UIAlertViewDelegate, DatePickerAlertViewControllerDelegate,  UITextFieldDelegate, InputGameNameAlertViewControllerDelegate, RegistGameAlertViewControllerDelegate>{
	IBOutlet FacesView* _facesView; ///<BOB顔View
  IBOutlet UITextField* _dateTextField; ///<日付入力TextField
  int _prevAlertViewTag; ///< 直前に表示されていたAlertViewのViewタグ
  int _okiishiNum; ///<置石の数
}
/**
 次の一手を置くことが出来るか評価する
 次の一手とは、_current_game#current_recordの次手とする
 @param x 次の一手のX座標
 @param y 次の一手のY座標
 */
- (void)checkCurrentNextRecordPuttable:(int)x y:(int)y;

/**
 手を打った後に、石を表示する
 @param record 打った石
 */
- (void)showGoStoneViewAfterPutGoStone:(GameRecords*)record;

/**
 指定したGameを設定し、表示画面を表示する
 表示画面は、本クラスを実装した画面の表示画面の事である（棋譜登録、詰碁登録等）
 @param game 現在のGame
 */
- (void)showShowViewWithGame:(Games*)game;

/**
 顔登録用サイドビューを表示する
 @param animated アニメーションする場合YES
 */
- (void)showFacesView:(BOOL)animated;

/**
 顔登録用サイドビューを非表示にする
 @param animated アニメーションする場合YES
 */
- (void)hideFacesView:(BOOL)animated;

/**
 現在のゲームが更新されているなら、セーブ用のAlertViewを表示する
 */
- (void)saveCurrentGameWithSaveAlertView:(UIViewController*)controller;

/**
 日付TextFieldがタッチされた
 @param sender 日付TextFieldオブジェクト
 */
- (IBAction)touchDateTextField:(id)sender;
@end

