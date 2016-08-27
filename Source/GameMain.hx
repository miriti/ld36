package ;

import openfl.display.Sprite;
import openfl.events.Event;

class GameMain extends Sprite {

  var world:GameWorld;

  public function new() {
    super();

    world = new GameWorld();

    addChild(world);

    addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
  }

  private function onAddedToStage(e:Event) : Void {
    GameInput.getInstance().init(stage);
  }

}
