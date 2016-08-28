package ;

import openfl.display.DisplayObject;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;

import hud.GameHud;
import hud.Inventory;

import mobs.Player;

class GameMain extends GameObject {
  private static var _instance:GameMain;

  var world: GameWorld;
  var mouseEvents:Sprite;
  var hud: GameHud;

  var player:Player;

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
    player = Player.getInstance();
    mouseEvents = new Sprite();

    world.addEventListener(MouseEvent.MOUSE_DOWN, player_mouseDown);
    world.addEventListener(MouseEvent.MOUSE_UP, player_mouseUp);

    mouseEvents.addEventListener(MouseEvent.MOUSE_DOWN, player_mouseDown);
    mouseEvents.addEventListener(MouseEvent.MOUSE_UP, player_mouseUp);

    hud = new GameHud();

    Inventory.instance.collect('basic-tool', 1);

    addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
  }

  private function player_mouseDown(e:MouseEvent): Void {
    player.onMouseDown();
  }

  private function player_mouseUp(e:MouseEvent): Void {
    player.onMouseUp();
  }

  private function onAddedToStage(e:Event) : Void {
    mouseEvents.graphics.beginFill(0xffffff);
    mouseEvents.graphics.drawRect(0,0, stage.stageWidth, stage.stageHeight);
    mouseEvents.graphics.endFill();

    mouseEvents.alpha = 0.1;

    addChild(mouseEvents);
    addChild(world);
    addChild(hud);
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
