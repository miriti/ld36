package interactive;

import openfl.events.MouseEvent;

import nape.phys.BodyType;

import motion.Actuate;

import equip.Equipment;

class Interactive extends PhysicsObject  {

  public static var current:Interactive = null;

  public function new() {
    super(BodyType.DYNAMIC);

    buttonMode = true;
    enabled = false;

    addEventListener(MouseEvent.MOUSE_OVER, function(e:MouseEvent) {
      current = this;
    });

    addEventListener(MouseEvent.MOUSE_OUT, function(e:MouseEvent) {
      current = null;
    });
  }

  public function hit(with:Equipment) : Void {
    alpha = 0.5;
    Actuate.tween(this, 0.2, {alpha: 1});
  }

}
