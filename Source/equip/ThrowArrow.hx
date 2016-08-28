package equip;

import openfl.display.Sprite;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.Assets;

class ThrowArrow extends Sprite {

  public var power(default, set):Float = 0;

  static var bitmapData:BitmapData = null;

  var bitmap:Bitmap;

  public function new() {
    super();
    if(bitmapData == null) {
      bitmapData = Assets.getBitmapData('assets/arrow.png');
    }
    bitmap = new Bitmap(bitmapData);
    bitmap.y = -bitmap.height / 2;
    bitmap.alpha = 0.5;
    addChild(bitmap);

    power = 0;
  }

  function set_power(value: Float):Float {
    value = Math.min(value, 1);
    value = Math.max(value, 0);

    bitmap.scaleX = value;
    return power = value;
  }

}
