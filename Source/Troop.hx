package ;

import openfl.events.MouseEvent;
import openfl.geom.Point;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.Assets;

import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.constraint.PivotJoint;
import nape.shape.Polygon;
import nape.shape.Circle;
import nape.constraint.PivotJoint;

import anim.Caveman;

class Troop extends PhysicsObject {
  var aim:Vec2 = new Vec2();
  var throwArrow:ThrowArrow;
  var animation:Caveman;

  public function new() {
    super(BodyType.DYNAMIC);

    animation = new Caveman();

    addChild(animation);

    throwArrow = new ThrowArrow();
    throwArrow.visible = false;
    addChild(throwArrow);

    body.shapes.add(new Polygon(Polygon.box(30, 70)));

    var legs = new Circle(15);
    legs.translate(Vec2.get(0, 35));
    body.shapes.add(legs);

    var head = new Circle(15);
    head.translate(Vec2.get(0, -35));
    body.shapes.add(head);

    body.allowRotation = false;
    body.mass = 50;

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
    trb.throwItem(aim, 800);

    parent.addChild(trb);
  }

  override public function update(delta: Float):Void {
    var input = GameInput.getInstance();

    if(input.isLeft()) {
      body.velocity.x = -200;
      animation.scaleX = -1;
      animation.animated = true;
    } else {
      if(!input.isRight()) {
        body.angularVel = 0;
        animation.animated = false;
      }
    }

    if(input.isRight()) {
      body.velocity.x = 200;
      animation.scaleX = 1;
      animation.animated = true;
    } else {
      if(!input.isLeft()) {
        body.angularVel = 0;
        animation.animated = false;
      }
    }

    var bounds = getBounds(Main.getInstance());

    var globalPos:Vec2 = Vec2.get(bounds.x + bounds.width / 2, bounds.y + bounds.height / 2);

    aim.setxy(stage.mouseX - globalPos.x, stage.mouseY - globalPos.y);
    aim.normalise();

    throwArrow.rotation = aim.angle * (180 / Math.PI);

    super.update(delta);
  }
}
