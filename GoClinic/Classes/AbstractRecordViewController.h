//
//  AbstractRecordViewController.h
//  GoClinic
//
//  Created by 猪子 徹 on 10/09/01.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"
#import "BoardView.h"
#import "GoStoneView.h"
#import "Games.h"
#import "CommentViewController.h"
#import "MenuPopOverViewController.h"
#import "CommentView.h"
#import "GamesPickerAlertViewController.h"
#import "SaveGameAlertViewController.h"

/**
 全ての画面のViewControllerの基底となる抽象クラス
 @auther inoko
 */
@interface AbstractRecordViewController : UIViewController <UIScrollViewDelegate, NSFetchedResultsControllerDelegate, BoardViewDelegate,  MenuPopOverViewControllerDelegate, GamePickerAlertViewControllerDelegate, SaveGameAlertViewControllerDelegate>{
    
	IBOutlet UINavigationBar *_navBar; ///< ナビゲーションバーのアウトレットオブジェクト
  IBOutlet CommentView* _commentView; ///< コメントViewのアウトレットオブジェクト
	IBOutlet BoardView *_boardView; ///< 盤面Viewのアウトレットオブジェクト
	IBOutlet UILabel* _gameTitleLabel; ///< ゲームのタイトルLabelのアウトレットオブジェクト
	IBOutlet UIButton* _returnToAboveLevelButton; ///< 上に戻るボタンのアウトレットオブジェクト
  IBOutlet UIButton* _changeToClinicButton; ///<クリニックボタンのアウトレットオブジェクト
  IBOutlet UIButton* _compareClinicButton; ///<比較ボタンのアウトレットオブジェクト
  IBOutlet UIButton* _moveToFirstRecordButton; ///<初めに戻るボタンのアウトレットオブジェクト
  IBOutlet UIButton* _moveToLastRecordButton; ///<最後に進むボタンのアウトレットオブジェクト
  IBOutlet UIBarButtonItem* _moveToNextRecordButton; ///<次へボタンのアウトレットオブジェクト
  IBOutlet UIBarButtonItem* _moveToPrevRecordButton; ///<前へボタンのアウトレットオブジェクト
  IBOutlet UISwitch* _stoneNumberSwitch; ///<手数を表示するボタンのアウトレットオブジェクト
  IBOutlet UISwitch* _stoneFaceSwitch; ///<BOB顔を表示するボタンのアウトレットオブジェクト
  IBOutlet UIImageView* _bobFaceView; ///<BOB顔Viewのアウトレットオブジェクト
  IBOutlet UITextView* _commentTextView; ///<コメントViewのアウトレットオブジェクト
  
  int _stoneDispMode; ///<石の表示モードを示す。0:手数を表示する, 1:顔を表示する, 2:何も表示しない
  BOOL _isPractiveRecordTransparent; ///<比較モード中に実戦譜が半透明かどうかを判定する
  CommentViewController* _commentViewController; ///<コメントViewControlelr
	Games* _currentGame; ///< プロパティ受け渡し用変数
  UIPopoverController* _popoverView; ///< プロパティ受け渡し用変数
}
@property (nonatomic, retain) BoardView* boardView; ///<盤面View
@property (nonatomic, retain) Games* currentGame; ///<現在のゲームオブジェクト
@property (nonatomic, retain) UIPopoverController* popoverView; ///<ポップアップView

/**
 コンストラクタ
 @param nibNameOrNil Nibファイル名
 @param nibBundleOrNil Bundle名
 @param game ViewControllerに設定するGame
 @return ViewControlelrのインスタンス
 */
-(id)initWithNibNameAndGame:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil game:(Games*)game;

/**
 View読み込み時に、BoardViewを初期化する
 */
-(void)initBoardView;

/**
 BoardViewのSubViewを全て非表示にする
 @param animated アニメーションしながら非表示にするかどうか
 @return 一つでもViewを非表示にした場合 YES, 非表示にするViewがない場合 NO
 */
-(BOOL)hideSubViews:(BOOL)animated;

/**
 石のメニューコンテキストの一つ。"コメント"がクリックされた際に呼び出される。
 @param sender メニューを表示した石オブジェクト（GoStones）
 */
-(void)commentGoStoneMenu:(id)sender;

/**
 新規のゲームを作成するための抽象メソッド。
 <pre>
 本クラスを継承する実装クラスでは、本メソッドをOverrideし、
 Gamesを継承する実装クラスを生成する必要がある。
 </pre>
 @return Games Gamesを継承した実装クラスのインスタンス
 */
-(Games*)createGame;

/**
 コメントViewを表示する
 @param animated 表示する際にアニメーションさせる場合 YES
 */
-(void)showCommentView:(BOOL)animated;

/**
 コメントViewを非表示にする
 @param animated 表示する際にアニメーションさせる場合 YES
 */
-(void)hideCommentView:(BOOL)animated;

/**
 表示中の全ての石を非表示にする
 */
-(void)clearBoard;

/**
 現在のゲームの棋譜の石をすべて表示する
 @param mode 0:碁石に手数を表示する 1:碁石に顔を表示する
 */
-(void)showAllRecords:(int)mode;

/**
 現在のゲームの棋譜の石の中で、is_shown_stateがYESの物をすべて表示する
 @param mode 0:碁石に手数を表示する 1:碁石に顔を表示する
 */
-(void)showAllShownStateRecord:(int)mode;

/**
 現在のゲームを保存する。
 <pre>
 保存される条件は、新規作成された場合か、更新された場合
 </pre>
 */
-(void)saveCurrentGame;

/**
 クリニック(分岐)を新規に作成する。同じ石に対するクリニックが既に存在する場合、上書きされる
 <pre>
 クリニックを開始に際し、以下の内容が実行される。
 1.クリニックする石以降の手の石を非表示にする
 2.現在のゲームのcurrent_branch_moveを変更
 3.同一の深さで、現在の手以降の棋譜を削除する。
 4.現在のゲームの深さ（currentDepth)を一つ増やす 
 */
-(void)createClinic;

/**
 既存のクリニック(分岐)を開始する。
 <pre>
 クリニックを開始に際し、以下の内容が実行される。
 1.クリニックする石以降の手の石を非表示にする
 2.現在のゲームのcurrent_branch_moveを変更
 3.同一の深さで、現在の手以降の棋譜を削除する。
 4.現在のゲームの深さ（currentDepth)を一つ増やす
 </pre>
 */
-(void)startClinic;

/**
 クリニック（分岐）を一つ上の階層に戻る。
 <pre>
 1.現在の階層の石を盤面及びStackから取り除く
 2.現在のroot_recordをcurrent_recordに設定
 3.一階層上の石を盤面及びStackに設定する
 </pre>
 */
-(void)quitClinic;

/**
 指定された棋譜をCurrent_recordに設定し、ハイライトする。コメントや顔が設定されていれば表示する。
 @param record 指定された棋譜
 */
-(void)selectStone:(GameRecords*)record;

/**
 指定された棋譜のハイライトを取り除く。
 @param record 指定された棋譜
 */
-(void)unSelectStone:(GameRecords*)record;

/**
 指定された棋譜のコメントをコメント表示エリアに表示する。
 複数コメントが登録されている場合は、改行して表示する。
 @param record コメントが登録されている棋譜
 */
-(void)showRecordComments:(GameRecords*)record;

/**
 指定されたViewに石の色、及び表示モードを設定する
 @param view current_recordに対応するView
 */
-(void)setGoStoneViewDispSetting:(GoStoneView*)view;


/**
 指定されたXY座標に碁石が配置可能かチェックする
 */
-(void)checkCurrentNextRecordPuttable:(int)x y:(int)y;



/**
 現在の状態から、各ボタンのON/OFFを切り替える
 */
-(void)checkButtonActivate;

/**
 現在選択されている石のルート棋譜があるかチェックし、分岐点へ戻るボタンのON/OFFを切り替える
 */
-(void)checkBranchRecord;


/**
 現在の状態から、比較ボタンのON/OFFを切り替える
 */
-(void)checkComparable;

/**
 現在の状態から、手順進むボタンのON/OFFを切り替える
 */
-(void)checkPrevRecords;

/**
 現在の状態から、手順戻るボタンのON/OFFを切り替える
 */
-(void)checkNextRecords;

/**
 指定されたViewを盤面に表示する
 @param view 碁石ビュー
 @param aboveView viewの下に位置するView
 */
-(void)insertGoStoneView:(GoStoneView*)view aboveView:(UIView*)aboveView;

/**
 指定された棋譜の手数から、指定された手番までの石を盤面に表示する。
 @param record 起点となる棋譜
 @param toMove 終点となる手番
 @param opacity 石の透明度
 @param isRemovedShow 抜き石を表示する場合はYES
 @return 終点となる棋譜。最終手がtoMoveより小さい場合は、最終手を返す。
 */
-(GameRecords*)insertGoStoneViewCyclick:(GameRecords*)record toMove:(int)toMove opacity:(float)opacity isRemovedShow:(BOOL)isRemovedShow;

/**
 指定された棋譜から、最終手までの棋譜の石を非表示にする
 @param record 起点となる棋譜
 */
-(void)removeGoStoneViewCyclic:(GameRecords*)record;


/**
 GoStoneViewから分岐吹き出しViewを削除する
 @param view GoStoneView
 */
-(void)removeFukidashiView:(GoStoneView*)view;

/**
 新規にゲームを開始するコンポジットメソッド。
 盤面の初期化、新規ゲームの作成、画面コントロールの初期化を行う。
 */
-(void)startNewGame;

/**
 画面コントロールの初期化を行う
 */
-(void)initGameInfoControl;

/**
 既存のゲーム選択用のAlertViewを表示する
 */
-(void)showSelectExsistedGamesAlertView;

/**
 現在のゲームをセーブする。セーブするのは、新規作成/更新されたゲームのみ
 */
-(void)saveCurrentGame;

/**
 既存のゲームを終了する準備をする。 もし、既存のゲームが変更されていたら、保存を促す。
 @param menuId ゲームの終了後に実行されるメニューのID
 */
//TODO SELECTER に変更する
-(void)prepareExitGame:(int)menuId;

/**
 指定された棋譜より前の棋譜で、現在表示されている棋譜を取得する
 @return 指定された棋譜より前の棋譜で、現在表示されている棋譜
 */
-(GameRecords*)getLastShownGoStoneViewRecord:(GameRecords*)from;

/**
 比較時の実戦譜の石の透明度を切り替える
 */
-(void)changePractiveRecordTransparency;

/**
 現在の石表示モードを取得する
 @return 現在の石表示モード。GOSTONE_VIEW_FACE_DISPLAY_MODE, GOSTONE_VIEW_MOVE_DISPLAY_MODE, GOSTONE_VIEW_NONE_DISPLAY_MODEの何れか。
 */
-(int)getCurrentDispMode;

/**
 表示中の全ての石の表示をリフレッシュする。
 リフレッシュの際、数字表示スイッチ、顔表示スイッチの状態により、表示モードを変化させる
 */
-(void)refreshAllGoStoneView;

/**
 棋譜表示画面を表示する
 */
-(void)showNormalShowMode;

/**
 棋譜登録画面を表示する
 */
-(void)showNormalRegistMode;

/**
 詰碁表示画面を表示する
 */
-(void)showTsumegoShowMode;

/**
 詰碁登録画面を表示する
 */
-(void)showTsumegoRegistMode;

/**
 問題表示画面を表示する
 */
-(void)showQuestionShowMode;

/**
 問題登録画面を表示する
 */
-(void)showQuestionRegistMode;

/**
 問題保存用のAlertViewを表示する
 @param gameType 
 */
//TODO SELECTERで良い？
-(void)showSaveAlertView:(int)gameType;

/**
 ゲームのタイトルを表示する
 */
-(void)showGameTitle;

/**
 メニューを表示する
 @param sender MenuButton
 @param delegate AbstractRecordViewControllerを実装したViewController
 */
-(void)showMenu:(id)sender delegate:(id)delegate;

/**
 StoneStackから抜き石を削除する
 */
-(void)putOffEnclosedStonesFromStack;

/**
 全ての碁石を指定された表示モードにする
 @param isStateSaved YES:表示する、NO:表示しない
 */
-(void)setShownViewToShowView:(BOOL)isStateSaved;

/**
 次の手が指定されたXY座標に配置可能か判断する
 */
-(void)checkCurrentNextRecordPuttable:(int)x y:(int)y;

/**
 碁石を配置した後に碁石Viewを表示する
 */
-(void)showGoStoneViewAfterPutGoStone:(GameRecords*)record;

/**
 ナビゲーションバー右側のボタンをタッチする
 @param sender NavBarButtonオブジェクト
 */
-(IBAction)touchNavRightButton:(id)sender;

/**
 ナビゲーションバー左側のボタンをタッチする
 @param sender NavBarButtonオブジェクト
 */
-(IBAction)touchMenuButton:(id)sender;

/**
 顔表示スイッチをタッチする
 @param sender UISwitchオブジェクト
 */
-(IBAction)touchFaceDispSwitch:(id)sender;

/**
 手数表示スイッチをタッチする
 @param sender UISwitchオブジェクト
 */
-(IBAction)touchMoveDispSwitch:(id)sender;

/**
 手順進めるボタンをタッチする
 */
-(IBAction)touchMoveToNextRecordButton;

/**
 手順戻るボタンをタッチする
 */
-(IBAction)touchMoveToPrevRecordButton;

/**
 最初まで戻るボタンをタッチする
 */
-(IBAction)touchMoveToFirstRecordButton;

/**
 最後まで進むボタンをタッチする
 */
-(IBAction)touchMoveToLastRecordButton;

/**
 戻るボタンをタッチする
 @param sender 戻るボタンオブジェクト
 */
-(IBAction)touchReturnToAboveLevelButton:(id)sender;

/**
 比較ボタンをタッチする
 @param sender 比較ボタンオブジェクト
 */
-(IBAction)touchCompareClinicButton:(id)sender;

/**
 クリニックボタンをタッチする
 @param sender クリニックボタンオブジェクト
 */
-(IBAction)touchClinicButton:(id)sender;

/**
 全てのGoStoneView, 及び、現在のゲームの手番表示モードを切り替える
 @param isShowNumber 手番表示モードにする場合YES
 */
-(void)changeShowNumberMode:(BOOL)isShowNumber;

/**
 全てのGoStoneView, 及び、現在のゲームの顔表示モードを切り替える
 @param isShowFace BOB顔表示モードにする場合YES
 */
-(void)changeShowFaceMode:(BOOL)isShowFace;

@end
