
//画面要素エレメント一覧を表示(表示画面)
UIALogger.logStart("Starting Test");
var target = UIATarget.localTarget();
var app = target.frontMostApp();
var view = app.mainWindow();
var navbar = view.navigationBar();

//登録画面に移動
var rightButton = navbar.rightButton();
rightButton.tap();

//碁盤の(0,0)となる点
var side = 38;
var board_y_offset = 130;
var sx = side;
var sy = board_y_offset + side;

function setStones(stones){
	for(var i = 0;i<stones.length;i++){
		target.delay(0.5);
		UIALogger.logDebug("x : " + stones[i][0] + ", y : " + stones[i][1]);
		target.tapWithOptions({x:sx + side*stones[i][0], y:sy + side*stones[i][1]}, {touchCount:1, tapCount:1});	
	}
}


//1.最初の置き石
var stones1 = [[16,4], [4,4], [16,16], [4,17], [4,15], [3,13], [5,14], [7, 17], [4,12], [3,16], 
			  [3,15], [14,3],[17,6], [10,4], [3,10], [17,14], [14,17], [3,6], [17,15], [16,14]];
target.delay(0.5);
setStones(stones1);
target.delay(0.5);

//2.データを保存
rightButton = navbar.rightButton();
rightButton.tap();

//TODO 24ー＞29
UIALogger.logDebug("ファイルを保存しました.");

rightButton = navbar.rightButton();
rightButton.tap();

//3.クリニックの置き石(30 -> 49)
var stones2 = [[16,2], [16,3], [17,3], [17,4], [17,5],[18,4],[18,3],[18,5],[18,6],[17,3],
    		[19,4], [18,2], [19,5], [15,2], [16,1], [15,1], [19,2], [17,1], [16,2], [16,1]];
target.delay(0.5);
setStones(stones2);
target.delay(0.5);

//4.比較（50 -> 55)
//TODO

//5.置き石＋削除 + 移動
var stones3 = [[17,9]];
target.delay(0.5);
setStones(stones3);
target.delay(0.5);

//TODO 削除

//置き石
var stones4 = [[14,14], [15,11];
target.delay(0.5);
setStones(stones4);
target.delay(0.5);

//移動
//TODO

//置き石
var stones5 = [[17,17], [16,17], [17,18]];
target.delay(0.5);
setStones(stones5);
target.delay(0.5);

//6.ファイルの上書き保存
rightButton = navbar.rightButton();
rightButton.tap();
//TODO

//7.表示画面での石表示
//TODO
