package tiles;

import openfl.display.Sprite;
import openfl.display.Bitmap;

import nape.shape.Polygon;
import nape.phys.BodyType;

class Tile extends PhysicsObject {
  public function new(tileData:TileData) {
    super(BodyType.STATIC);

    var bitmap:Bitmap = new Bitmap(tileData.bitmapData);
    addChild(bitmap);

    var shape = new Polygon(Polygon.box(30, 30));
    body.shapes.add(shape);
  }

}
