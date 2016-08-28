package mobs;

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
import nape.callbacks.CbEvent;
import nape.callbacks.CbType;
import nape.callbacks.BodyListener;
import nape.callbacks.BodyCallback;

import anim.Caveman;

import equip.Equipment;

class Mob extends PhysicsObject {
  var moveLeft(default, set):Bool;
  var moveRight(default, set):Bool;
  var equipment(default, set):Equipment = null;

  var aim:Vec2 = new Vec2();
  var animation:Caveman;

  public function look(side:Int) {
    animation.scaleX = side;

    if((equipment != null) && (equipment.display != null)) {
      equipment.display.scaleX = side;
    }
  }

  public function set_moveLeft(value:Bool):Bool {
    if ((value) && (!moveLeft)) {
      animation.animated = true;
      look(-1);
    } else {
      animation.animated = false;
    }

    return moveLeft = value;
  }

  public function set_moveRight(value:Bool):Bool {
    if ((value) && (!moveRight)) {
      animation.animated = true;
      look(1);
    } else {
      animation.animated = false;
    }

    return moveRight = value;
  }

  public function set_equipment(value:Equipment):Equipment {
    if(equipment != null)  {
      equipment.mob = null;

      if(equipment.display!=null) {
        removeChild(equipment.display);
      }
    }

    if(value.display != null) {
      addChild(value.display);
    }

    value.mob = this;

    return equipment = value;
  }

  public function new() {
    super(BodyType.DYNAMIC);

    animation = new Caveman();

    addChild(animation);

    body.shapes.add(new Polygon(Polygon.box(30, 70)));

    var legs = new Circle(15);
    legs.translate(Vec2.get(0, 35));
    body.shapes.add(legs);

    var head = new Circle(15);
    head.translate(Vec2.get(0, -35));
    body.shapes.add(head);

    body.allowRotation = false;
    body.mass = 50;
  }

  override public function update(delta: Float):Void {
    if(moveLeft) {
      body.velocity.x = -200;
    }

    if(moveRight) {
      body.velocity.x = 200;
    }

    if(!moveLeft && !moveRight) {
      body.velocity.x = 0;
    }

    super.update(delta);
  }
}
