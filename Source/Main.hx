package;

import openfl.display.Sprite;
import openfl.events.Event;

class Main extends Sprite {
	static var _instance:Main;

	var mainMenu:MainMenu = new MainMenu();
	var gameMain:GameMain;

	public static function getInstance(): Main {
		return _instance;
	}

	public function new () {

		super ();

		_instance = this;

		/*addChild(mainMenu);*/
		addChild(new GameMain());

		mainMenu.addEventListener('start_game', function(e:Event) {
			removeChild(mainMenu);

			gameMain = new GameMain();
			addChild(gameMain);
		});

	}


}
