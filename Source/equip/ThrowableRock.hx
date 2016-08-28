package equip;

import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.Assets;

import nape.geom.Vec2;
import nape.phys.BodyType;
import nape.shape.Circle;

class ThrowableRock extends PhysicsObject {
  private static var bitmapData:BitmapData = null;

  public function new() {
    super(BodyType.DYNAMIC);

    if(bitmapData == null) {
      bitmapData = Assets.getBitmapData('assets/rock.png');
    }

    var bitmap = new Bitmap(bitmapData);
    bitmap.x = -bitmap.width/2;
    bitmap.y = -bitmap.height/2;

    addChild(bitmap);

    var shape = new Circle(Math.min(bitmap.width, bitmap.height) / 2);
    shape.material.elasticity = 0.5;
    body.shapes.add(shape);
    body.mass = 1;
  }

  public function throwItem(aim:Vec2, power:Float) {
    body.velocity = aim.muleq(power);
    body.angularVel = 20;
  }

}
