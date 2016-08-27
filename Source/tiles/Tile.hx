package tiles;

import openfl.display.Sprite;
import openfl.display.Bitmap;

import nape.shape.Polygon;
import nape.phys.BodyType;

class Tile extends PhysicsObject {
  public function new(tileData:TileData) {
    super(BodyType.STATIC);

    var bitmap:Bitmap = new Bitmap(tileData.bitmapData);
    bitmap.x = -bitmap.width / 2;
    bitmap.y = -bitmap.height / 2;
    addChild(bitmap);

    var shape = new Polygon(Polygon.box(30, 30));

    if((tileData.properties.exists('fluid')) && (tileData.properties['fluid'] == "true")) {
      shape.fluidEnabled = true;
    }

    body.shapes.add(shape);
  }

}
