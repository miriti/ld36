package equip;

import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.Assets;

import nape.geom.Vec2;

import hud.Inventory;

class BridgeBuilder extends Equipment {

  var container:Sprite;

  public function new() {
    super();

    var bitmap:Bitmap = new Bitmap(Assets.getBitmapData('assets/bridge.png'));
    bitmap.x = -bitmap.width/2;
    bitmap.y = -bitmap.height/2;

    container = new Sprite();
    container.addChild(bitmap);
  }

  override public function beginAction():Void {
    super.beginAction();

    GameWorld.instance.addChild(container);
  }

  override public function endAction(): Void {
    super.endAction();

    GameWorld.instance.removeChild(container);

    var bridge = new Bridge();
    bridge.position = Vec2.get(GameWorld.instance.mouseX, GameWorld.instance.mouseY);
    bridge.space = GameWorld.instance.space;
    GameWorld.instance.addChild(bridge);

    Inventory.instance.collect('bridge', -1);
  }

  override public function update(delta:Float) {
    super.update(delta);

    container.x = GameWorld.instance.mouseX;
    container.y = GameWorld.instance.mouseY;
  }

}
