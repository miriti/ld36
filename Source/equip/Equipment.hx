package equip;

import openfl.display.Sprite;

import mobs.Mob;

class Equipment  {

  public var inAction:Bool = false;
  public var actionTime:Float = 0;
  public var display:Sprite = null;
  public var mob:Mob = null;

  public function new() {
  }

  public function beginAction():Void {
    inAction = true;
  }

  public function endAction(): Void {
    inAction = false;
    actionTime = 0;
  }

  public function update(delta:Float) {
    if (inAction) {
      actionTime += delta;
    }
  }

}
