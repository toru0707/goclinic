//
//  Global.h
//  GoClinic
//
//  Created by 猪子 徹 on 10/09/07.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
//View
#define DISPLAY_WIDTH 768.0
#define SCREEN_WIDTH 684.0
#define Y_OFFSET 20.0
#define X_OFFSET 20.0
#define TILE_INSET 6.0
#define SIDE 38.0
#define BOARD_SIZE 19
#define BOARD_SIZE19 19
#define BOARD_SIZE13 13
#define NORMAL_OPACITY 1.0
#define TRANS_OPACITY 0.5

//View tag(AlertView)
#define START_NEW_GAME_TAG 0
#define START_EXISTED_GAME_TAG 1
#define FLIP_TO_SHOW_VIEW_TAG 2
#define SHOW_GAME_SAVE_TEXT_TAG 3
#define DID_ROTATE_TAG 4
#define FLIP_TO_TSUMEGO_VIEW_TAG 5
#define QUIT_TSUMEGO_VIEW_TAG 6
#define FLIP_TO_TSUMEGO_SHOW_VIEW_TAG 7
#define DELETE_GAMERECORD_VIEW_TAG 8
#define QUESTION_SELECT_VIEW_TAG 9

//View tag(TextField
#define GAME_SAVE_TEXTFIELD 10
#define GAME_DATE_TEXTFIELD 11
#define OKIISHI_TEXTFIELD 12

#define GOSTONE_VIEW_MOVE_DISPLAY_MODE 0
#define GOSTONE_VIEW_FACE_DISPLAY_MODE 1
#define GOSTONE_VIEW_NONE_DISPLAY_MODE 2
#define GOSTONE_VIEW_WHITE_COLOR_ID 0
#define GOSTONE_VIEW_BLACK_COLOR_ID 1

#define BLACK_USER_ID 1
#define WHITE_USER_ID 0


NSManagedObjectContext *managedObjectContextGlobal;