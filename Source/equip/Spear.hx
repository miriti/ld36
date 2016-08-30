package equip;

import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.Assets;

import hud.Inventory;

class Spear extends ThrowEquipment {

  var bitmap:Bitmap;
  var container:Sprite;

  public function new() {
    super();

    chargingTime = 1.5;

    bitmap = new Bitmap(Assets.getBitmapData("assets/spear.png"));
    bitmap.x = -bitmap.width * 0.25;
    bitmap.y = -bitmap.height / 2;

    container = new Sprite();
    container.addChild(bitmap);

    var newDisplay = new Sprite();
    newDisplay.addChild(container);

    display = newDisplay;
  }

  override public function endAction(): Void {
    super.endAction();
    container.rotation = 0;

    Inventory.instance.collect('spear', -1);

    if(Inventory.instance.icons['spear'].count == 0) {
      mob.equipment = null;
    }
  }

  override public function update(delta: Float): Void {
    super.update(delta);

    if(inAction) {
      container.rotation = arrow.rotation;
    }
  }

  override public function generateProjectile(): PhysicsObject {
    return new ThrowableSpear();
  }

}
