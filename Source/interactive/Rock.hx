package interactive;

import openfl.display.Bitmap;
import openfl.Assets;

import nape.shape.Circle;

import equip.Equipment;

class Rock extends Interactive  {

  public function new() {
    super();

    id = 'rock';
    enabled = true;
    collectable = true;

    var bitmap = new Bitmap(Assets.getBitmapData('assets/rock.png'));
    bitmap.x = -bitmap.width/2;
    bitmap.y = -bitmap.height/2;
    addChild(bitmap);

    body.shapes.add(new Circle(Math.min(bitmap.width, bitmap.height)/2));
  }
/**
  override public function hit(with:Equipment): Void {
    space = null;
    visible = false;
  } **/


}
