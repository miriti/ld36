package anim;

import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.Assets;

class Caveman extends GameObject {

  public var animated(default, set):Bool = false;

  private var leg_b:Bitmap;
  private var leg_a:Bitmap;
  private var wear:Bitmap;
  private var head:Bitmap;

  private var legs_origin_y:Float;
  private var phase:Float = 0;

  public function set_animated(value:Bool):Bool {
    if(value != animated) {
      leg_a.y = leg_b.y = legs_origin_y;
      phase = 0;
    }
    return animated = value;
  }

  public function new() {
    super();

    leg_b = new Bitmap(Assets.getBitmapData('assets/caveman/leg-b.png'));
    leg_a = new Bitmap(Assets.getBitmapData('assets/caveman/leg-a.png'));
    wear = new Bitmap(Assets.getBitmapData('assets/caveman/wear.png'));
    head = new Bitmap(Assets.getBitmapData('assets/caveman/head.png'));

    wear.x = -wear.width / 2;
    wear.y = -wear.height / 2;

    head.x = -head.width/2;
    head.y = wear.y - head.height + 7;

    legs_origin_y = leg_a.y = leg_b.y = wear.y + wear.height - 20;
    leg_a.x = -15;
    leg_b.x = -5;

    addChild(leg_b);
    addChild(leg_a);
    addChild(wear);
    addChild(head);
  }

  override public function update(delta:Float) : Void {
    if(animated) {
      leg_a.y = legs_origin_y + Math.sin(phase) * 10;
      leg_b.y = legs_origin_y - Math.sin(phase) * 10;

      phase += Math.PI * 10 * delta;
    }

    super.update(delta);
  }

}
