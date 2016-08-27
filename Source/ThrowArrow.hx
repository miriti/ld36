package ;

import openfl.display.Sprite;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.Assets;

class ThrowArrow extends Sprite {

  static var bitmapData:BitmapData = null;

  var bitmap:Bitmap;

  public function new() {
    super();
    if(bitmapData == null) {
      bitmapData = Assets.getBitmapData('assets/arrow.png');
    }
    bitmap = new Bitmap(bitmapData);
    bitmap.y = -bitmap.height / 2;
    addChild(bitmap);
  }

}
