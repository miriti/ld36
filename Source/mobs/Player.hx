package mobs;

import openfl.events.MouseEvent;
import openfl.events.KeyboardEvent;

import equip.BasicTool;

class Player extends Mob {

  private static var _instance:Player;

  public static function getInstance():Player {
    return _instance;
  }

  public function new() {
    super();

    _instance = this;

    equipment = new BasicTool();

    var input = GameInput.getInstance();

    input.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
    input.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
    input.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
    input.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
  }

  private function onKeyDown(e:KeyboardEvent): Void {
    if((e.keyCode == GameInput.KEY_LEFT) || (e.keyCode == GameInput.KEY_A)) {
      moveLeft = true;
    }

    if((e.keyCode == GameInput.KEY_RIGHT) || (e.keyCode == GameInput.KEY_D)) {
      moveRight = true;
    }
  }

  private function onKeyUp(e: KeyboardEvent): Void {
    if((e.keyCode == GameInput.KEY_LEFT) || (e.keyCode == GameInput.KEY_A)) {
      moveLeft = false;
    }

    if((e.keyCode == GameInput.KEY_RIGHT) || (e.keyCode == GameInput.KEY_D)) {
      moveRight = false;
    }
  }

  private function onMouseDown(e:MouseEvent): Void {
    if(equipment != null) {
      equipment.beginAction();
    }
  }

  private function onMouseUp(e:MouseEvent) : Void {
    if(equipment != null) {
      equipment.endAction();
    }
  }

  override public function update(delta: Float): Void {
    super.update(delta);

    var bounds = getRect(GameMain.getInstance());
    var g_x = bounds.x + bounds.width / 2;
    var g_y = bounds.y + bounds.height / 2;

    if(stage.mouseX < g_x) {
      look(-1);
    } else {
      look(1);
    }
  }

}
