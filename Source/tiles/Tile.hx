package tiles;

import openfl.display.Sprite;
import openfl.display.Bitmap;

class Tile extends Sprite {
  public function new(tileData:TileData) {
    super();

    var bitmap:Bitmap = new Bitmap(tileData.bitmapData);
    addChild(bitmap);
  }

}
