//require('/Users/inoko/iPhoneProject/GoClinic2/init.js');
/*
 コウのテスト
 */

//画面要素エレメント一覧を表示(表示画面)
UIALogger.logStart("Starting Test");
var target = UIATarget.localTarget();
var app = target.frontMostApp();
var view = app.mainWindow();
var navbar = view.navigationBar();

//登録画面に移動
var rightButton = navbar.rightButton();
rightButton.tap()

//碁盤の(0,0)となる点
var side = 38
var board_y_offset = 130;
var sx = side;
var sy = board_y_offset + side;

//1.コウのテスト
var kouTest = function(){
target.delay(1.0);
target.tapWithOptions({x:sx + side*3, y:sy + side*1}, {touchCount:1, tapCount:1});
target.delay(0.5);
target.tapWithOptions({x:sx + side*3, y:sy + side*4}, {touchCount:1, tapCount:1});
target.delay(0.5);
target.tapWithOptions({x:sx + side*2, y:sy + side*2}, {touchCount:1, tapCount:1});
target.delay(0.5);
target.tapWithOptions({x:sx + side*2, y:sy + side*3}, {touchCount:1, tapCount:1});
target.delay(0.5);
target.tapWithOptions({x:sx + side*4, y:sy + side*2}, {touchCount:1, tapCount:1});
target.delay(0.5);
target.tapWithOptions({x:sx + side*4, y:sy + side*3}, {touchCount:1, tapCount:1});
target.delay(0.5);
target.tapWithOptions({x:sx + side*3, y:sy + side*3}, {touchCount:1, tapCount:1});
target.delay(0.5);
target.tapWithOptions({x:sx + side*3, y:sy + side*2}, {touchCount:1, tapCount:1});
target.delay(0.5);
target.tapWithOptions({x:sx + side*3, y:sy + side*3}, {touchCount:1, tapCount:1});
}

//2.２重抜きのテスト
var nijunukiTest = function(){
	target.delay(1.0);
	target.tapWithOptions({x:sx + side*3, y:sy + side*6}, {touchCount:1, tapCount:1});
	target.delay(0.5);
	target.tapWithOptions({x:sx + side*3, y:sy + side*7}, {touchCount:1, tapCount:1});
	target.delay(0.5);
	target.tapWithOptions({x:sx + side*2, y:sy + side*7}, {touchCount:1, tapCount:1});
	target.delay(0.5);
	target.tapWithOptions({x:sx + side*2, y:sy + side*10}, {touchCount:1, tapCount:1});
	target.delay(0.5);
	target.tapWithOptions({x:sx + side*4, y:sy + side*7}, {touchCount:1, tapCount:1});
	target.delay(0.5);
	target.tapWithOptions({x:sx + side*3, y:sy + side*8}, {touchCount:1, tapCount:1});
	target.delay(0.5);
	target.tapWithOptions({x:sx + side*2, y:sy + side*8}, {touchCount:1, tapCount:1});
	target.delay(0.5);
	target.tapWithOptions({x:sx + side*3, y:sy + side*10}, {touchCount:1, tapCount:1});
	target.delay(0.5);
	target.tapWithOptions({x:sx + side*4, y:sy + side*8}, {touchCount:1, tapCount:1});
	target.delay(0.5);
	target.tapWithOptions({x:sx + side*4, y:sy + side*10}, {touchCount:1, tapCount:1});
	target.delay(0.5);
	target.tapWithOptions({x:sx + side*3, y:sy + side*9}, {touchCount:1, tapCount:1});
	target.delay(0.5);
	target.tapWithOptions({x:sx + side*3, y:sy + side*8}, {touchCount:1, tapCount:1});
	target.delay(0.5);
	target.tapWithOptions({x:sx + side*3, y:sy + side*7}, {touchCount:1, tapCount:1});
	target.delay(0.5);
	target.tapWithOptions({x:sx + side*3, y:sy + side*8}, {touchCount:1, tapCount:1});
	
}

kouTest();
nijunukiTest();

/*
for(var i = 0;i<view.elements().length;i++){
	UIALogger.logDebug("elements[" + i + "] name is " + view.elements()[i].name() + ", rect is " + view.elements()[i].rect().size.width + ", " + view.elements()[i].rect().size.height );	
}*/


