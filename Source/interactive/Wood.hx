package interactive;

import openfl.display.Bitmap;
import openfl.Assets;

import nape.shape.Circle;

import equip.Equipment;

class Wood extends Interactive {

  public function new() {
    super();

    body.allowRotation = false;
    enabled = true;
    collectable = true;
    id = "wood";

    var bitmap = new Bitmap(Assets.getBitmapData('assets/wood.png'));
    bitmap.x = -bitmap.width / 2;
    bitmap.y = -bitmap.height / 2;

    addChild(bitmap);

    body.shapes.add(new Circle(Math.min(bitmap.width, bitmap.height)/2));
  }

  /*override public function hit(with:Equipment): Void {
    body.space = null;
    visible = false;
    Interactive.current = null;
  }*/

}
