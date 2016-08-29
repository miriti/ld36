package interactive;

import openfl.events.MouseEvent;
import openfl.media.Sound;
import openfl.Assets;

import nape.phys.BodyType;

import motion.Actuate;

import equip.Equipment;

import mobs.Player;

import hud.Inventory;

class Interactive extends PhysicsObject  {
  public var collectable:Bool = false;
  public static var current:Interactive = null;
  public var id: String;
  private static var pickupSound:Sound = null;

  public function new() {
    super(BodyType.DYNAMIC);

    if(pickupSound == null)
      pickupSound = Assets.getSound('sfx/pickup.wav');

    buttonMode = true;
    enabled = false;

    addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
    addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
  }

  private function onMouseOver(e: MouseEvent) : Void {
    if (collectable) {
      space = null;
      enabled = false;
      Inventory.instance.collect(id, 1);
      pickupSound.play();
      Actuate.tween(this, 1, {
        alpha: 0,
        scaleX: 0,
        scaleY: 0,
        x: Player.getInstance().position.x,
        y: Player.getInstance().position.y
      }).onComplete(function() {
        visible = false;
      });
    } else {
      current = this;
    }
  }

  private function onMouseOut(e: MouseEvent) : Void {
    if (collectable) {
      // ???
    } else {
      current = null;
    }
  }

  public function hit(with:Equipment) : Void {
    alpha = 0.5;
    Actuate.tween(this, 0.2, {alpha: 1});
  }

}
