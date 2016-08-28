package equip;

import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.Assets;

import hud.Inventory;

class RockThrow extends ThrowEquipment {
  var bitmap:Bitmap;
  var container:Sprite;

  public function new() {
    super();

    bitmap = new Bitmap(Assets.getBitmapData("assets/rock.png"));
    bitmap.x = 30;
    bitmap.y = -bitmap.height / 2;

    container = new Sprite();
    container.addChild(bitmap);

    var newDisplay = new Sprite();
    newDisplay.addChild(container);

    display = newDisplay;
  }

  override public function generateProjectile(): PhysicsObject {
    return new ThrowableRock();
  }

}
