package equip;

import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.Assets;

import nape.phys.BodyType;
import nape.shape.Polygon;

class Bridge extends PhysicsObject {

  public function new() {
    super(BodyType.DYNAMIC);

    var bitmap = new Bitmap(Assets.getBitmapData('assets/bridge.png'));
    bitmap.x = -bitmap.width / 2;
    bitmap.y = -bitmap.height / 2;

    addChild(bitmap);

    body.shapes.add(new Polygon(Polygon.box(bitmap.width, bitmap.height)));
    body.cbTypes.add(GameCbTypes.getGround());
  }

}
