package ;

import openfl.display.DisplayObject;
import openfl.display.Sprite;
import openfl.events.Event;

class GameMain extends GameObject {
  private static var _instance:GameMain;

  var world:GameWorld;
  public var following(default, set): DisplayObject = null;

  function set_following(value:DisplayObject):DisplayObject {
    return following = value;
  }

  public static function getInstance():GameMain {
    return _instance;
  }

  public function new() {
    super();

    _instance = this;

    world = new GameWorld();

    addChild(world);

    addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
  }

  private function onAddedToStage(e:Event) : Void {
    GameInput.getInstance().init(stage);
  }

  override public function update(delta:Float): Void {
    super.update(delta);

    if (following != null) {
      var bounds = following.getBounds(world);

      world.x = (stage.stageWidth / 2) - following.x;
      world.y = (stage.stageHeight / 2) - following.y;
    }

  }

}
