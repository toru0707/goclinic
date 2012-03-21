//
//  RecordShowViewController.h
//  GoClinic
//
//  Created by 猪子 徹 on 10/08/15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbstractRecordViewController.h"

/**
 碁石表示用ViewControllerの基底となる抽象クラス
 @auther inoko
 */
@interface RecordShowViewController : AbstractRecordViewController<BoardViewDelegate>{
	//表示画面で一手おいたかどうか
	BOOL _isStonePut;
	//クリニックボタンが押下され、顔が表示しているか否かを示す
	BOOL _isFaceShownByClinic;
}

/**
 現在の状態が石を置くことが出来るか判定する
 @return 石を置くことが出来る場合、YES
 */
-(BOOL)isStonePuttable;

@end

