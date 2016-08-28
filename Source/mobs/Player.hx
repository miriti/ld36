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
  }

  private function onKeyDown(e:KeyboardEvent): Void {
    if((e.keyCode == GameInput.KEY_LEFT) || (e.keyCode == GameInput.KEY_A)) {
      moveLeft = true;
    }

    if((e.keyCode == GameInput.KEY_RIGHT) || (e.keyCode == GameInput.KEY_D)) {
      moveRight = true;
    }

    if((e.keyCode == GameInput.KEY_UP) || (e.keyCode == GameInput.KEY_W) || (e.keyCode == GameInput.KEY_SPACE)) {
      jump();
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

  public function onMouseDown(): Void {
    if(equipment != null) {
      equipment.beginAction();
    }
  }

  public function onMouseUp() : Void {
    if(equipment != null) {
      equipment.endAction();
    }
  }

  override public function update(delta: Float): Void {
    super.update(delta);

    if(mouseX < 0) {
      look = -1;
    } else {
      look = 1;
    }
  }

}
