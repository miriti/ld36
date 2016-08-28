package equip;

import nape.geom.Vec2;

class ThrowEquipment extends Equipment {

  public var chargingTime:Float = 2;
  public var aim:Vec2 = new Vec2();

  var arrow:ThrowArrow = new ThrowArrow();

  public function new() {
    super();
  }

  override public function beginAction() : Void {
    super.beginAction();

    if(display != null) {
      display.addChild(arrow);
    }
  }

  override public function endAction(): Void {
    super.endAction();

    var p:PhysicsObject = generateProjectile();

    if (p != null) {
      p.body.velocity = aim.mul(arrow.power * 10);
      p.space = mob.space;
      p.position = mob.position.add(aim.normalise().mul(50));
      mob.parent.addChild(p);
    }

    if(display != null) {
      display.removeChild(arrow);
    }
  }

  override public function update(delta:Float): Void {
    super.update(delta);

    if (inAction) {
      aim.setxy(mob.mouseX, mob.mouseY);

      var rotat:Vec2 = Vec2.get(mob.mouseX * mob.look, mob.mouseY);

      arrow.rotation = rotat.angle * (180/Math.PI);
      arrow.power = actionTime / chargingTime;
    }
  }

  public function generateProjectile():PhysicsObject {
    return null;
  }

}
