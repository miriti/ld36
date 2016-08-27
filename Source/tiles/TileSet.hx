package tiles;

import haxe.xml.Fast;

import openfl.geom.Rectangle;
import openfl.geom.Point;
import openfl.display.BitmapData;
import openfl.Assets;

class TileSet {

  public var firstgid:Int;
  public var name:String;
  public var tilewidth:Int;
  public var tileheight:Int;
  public var tilecount:Int;
  public var columns:Int;
  public var image:BitmapData;

  private var tileData:Map<Int, TileData> = new Map<Int, TileData>();

  public function new(xmlData:Fast) {
    firstgid = Std.parseInt(xmlData.att.firstgid);
    tilewidth = Std.parseInt(xmlData.att.tilewidth);
    tileheight = Std.parseInt(xmlData.att.tileheight);
    tilecount = Std.parseInt(xmlData.att.tilecount);
    columns = Std.parseInt(xmlData.att.columns);
    name = xmlData.att.name;

    image = Assets.getBitmapData('assets/' + xmlData.node.image.att.source);

    var offsetX:Int = 0;
    var offsetY:Int = 0;

    for(tileID in firstgid...(firstgid + tilecount)) {
      var data = new TileData();
      data.id = tileID;
      data.bitmapData = new BitmapData(tilewidth, tileheight, true, 0x00000000);
      data.bitmapData.copyPixels(image, new Rectangle(offsetX * 30, offsetY * 30, 30, 30), new Point(0, 0));
      tileData[tileID] = data;

      offsetX++;
    }

    for(tile in xmlData.nodes.tile) {
      var tileID = Std.parseInt(tile.att.id);
      if(tile.hasNode.properties) {
        for(property in tile.node.properties.nodes.property ) {
          tileData[tileID].properties[property.att.name] = property.att.value;
        }
      }
    }
  }

  public function getTile(gid:Int):Tile {
    if(tileData.exists(gid)) {
      return new Tile(tileData[gid]);
    } else {
      return null;
    }
  }

}
