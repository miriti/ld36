package ;

import openfl.events.MouseEvent;
import openfl.geom.Point;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.Assets;

import nape.geom.Vec2;
import nape.phys.BodyType;
import nape.constraint.PivotJoint;
import nape.shape.Polygon;
import nape.shape.Circle;

class Troop extends PhysicsObject {
  static var bitmapData:BitmapData;

  var aim:Vec2 = new Vec2();
  var throwArrow:ThrowArrow;

  public function new() {
    super(BodyType.DYNAMIC);

    var bitmap = new Bitmap(Assets.getBitmapData('assets/troop.png'));
    bitmap.x = -bitmap.width / 2;
    bitmap.y = -bitmap.height / 2;
    addChild(bitmap);

    throwArrow = new ThrowArrow();
    throwArrow.visible = false;
    addChild(throwArrow);

    var box = new Polygon(Polygon.box(bitmap.width, bitmap.height));
    //box.material.dynamicFriction = 0;
    //box.translate(Vec2.get(0, -bitmap.width/2));

    var circle = new Circle(bitmap.width/2);
    circle.translate(Vec2.get(0, bitmap.height-bitmap.width-bitmap.width/2));
    circle.material.rollingFriction = 0;

    body.shapes.add(box);
    //body.shapes.add(circle);

    var input = GameInput.getInstance();

    input.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent): Void {
      throwArrow.visible = true;
    });

    input.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
  }

  private function onMouseUp(e:MouseEvent) : Void {
    throwArrow.visible = false;

    var trb = new ThrowableItem();
    trb.space = body.space;
    trb.position = Vec2.get(x+aim.x*100, y+aim.y*100);
    trb.throwItem(aim, 400);

    parent.addChild(trb);
  }

  override public function update(delta: Float):Void {
    var input = GameInput.getInstance();

    if(input.isLeft()) {
      body.velocity.x = -200;
    }

    if(input.isRight()) {
      body.velocity.x = 200;
    }

    var bounds = getBounds(Main.getInstance());

    var globalPos:Vec2 = Vec2.get(bounds.x + bounds.width/2, bounds.y + bounds.height/2);

    aim.setxy(stage.mouseX - globalPos.x, stage.mouseY - globalPos.y);
    aim.normalise();

    throwArrow.rotation = aim.angle * (180/Math.PI);

    super.update(delta);
  }
}
