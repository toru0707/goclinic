//画面要素エレメント一覧を表示(表示画面)
UIALogger.logStart("Starting Test");
var target = UIATarget.localTarget();
var app = target.frontMostApp();
var view = app.mainWindow();
var navbar = view.navigationBar();


UIATarget.onAlert = function onAlert(alert){
	UIALogger.logMessage("alertShow");
	return false;
}
target.delay(2);
//登録画面に移動
var rightButton = navbar.rightButton();
rightButton.tap();
