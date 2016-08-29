package;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.media.Sound;
import openfl.Assets;

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

		addChild(mainMenu);

		mainMenu.addEventListener('start_game', function(e:Event) {
			#if flash
			var music:Sound = Assets.getSound("music/theme.mp3");
			#else
			var music:Sound = Assets.getSound("music/theme.ogg");
			#end

			music.play();

			gameMain = new GameMain();
			addChild(gameMain);

			mainMenu.visible = false;
		});

	}


}
