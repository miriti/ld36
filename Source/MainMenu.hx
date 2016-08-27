package ;

import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.Assets;

class MainMenu extends Sprite  {

  var gameLogo:Bitmap;
  var playButton:Sprite;

  public function new() {
    super();

    gameLogo = new Bitmap(Assets.getBitmapData('assets/game_logo.png'));
    playButton = new Sprite();
    playButton.addChild(new Bitmap(Assets.getBitmapData('assets/btn_play.png')));
    playButton.buttonMode = true;

    playButton.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) {
      this.dispatchEvent(new Event('start_game'));
    });

    addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

  }

  function onAddedToStage(e:Event) : Void {
    gameLogo.x = (stage.stageWidth - gameLogo.width) / 2;
    gameLogo.y = 100;

    playButton.x = (stage.stageWidth - playButton.width) / 2;
    playButton.y = stage.stageHeight - playButton.height - 100;

    addChild(gameLogo);
    addChild(playButton);
  }

}
