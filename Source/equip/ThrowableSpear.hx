package equip;

import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.Assets;

import nape.phys.BodyType;
import nape.shape.Polygon;

class ThrowableSpear extends PhysicsObject {

  private static var bitmapData:BitmapData;

  var bitmap:Bitmap;

  public function new() {
    super(BodyType.DYNAMIC);

    if(bitmapData == null) {
      bitmapData = Assets.getBitmapData('assets/spear.png');
    }

    bitmap = new Bitmap(bitmapData);

    bitmap.x = -bitmap.width/2;
    bitmap.y = -bitmap.height/2;

    addChild(bitmap);

    body.shapes.add(new Polygon(Polygon.box(bitmap.width, bitmap.height)));
  }

}
