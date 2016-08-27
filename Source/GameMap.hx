package ;

import haxe.xml.Fast;
import haxe.crypto.Base64;

import openfl.display.Sprite;
import openfl.Assets;

import nape.geom.Vec2;
import nape.shape.Polygon;
import nape.phys.Body;
import nape.phys.BodyType;

import tiles.TileSet;
import tiles.Tile;

class GameMap extends Sprite  {
  var tiles:Array<Array<Tile>>;

  public function new() {
    super();
  }

  public function load(space):Void {
    var xml:Xml = Xml.parse(Assets.getText('assets/map.tmx') );
    var fast:Fast = new Fast(xml.firstElement());

    var tileMap:TileSet = new TileSet(fast.node.tileset);

    for (layer in fast.nodes.layer) {
      var tileX:Int = 0;
      var tileY:Int = 0;

      for(tile in layer.node.data.nodes.tile) {
        var tile = tileMap.getTile(Std.parseInt(tile.att.gid));
        if(tile != null) {
          tile.position = Vec2.get(tileX * 30, tileY * 30);
          tile.space = space;
          addChild(tile);
        }

        tileX++;

        if(tileX >= Std.parseInt(layer.att.width)) {
          tileX = 0;
          tileY++;
        }
      }
    }

    for(object in fast.node.objectgroup.nodes.object) {
      if( object.att.type == 'player' ) {
        var troop:Troop = new Troop();
        troop.space = space;
        troop.position = Vec2.get(Std.parseInt(object.att.x), Std.parseInt(object.att.y));
        addChild(troop);
      }

      if( object.att.type == 'collision' ) {
        var collisionBody:Body = new Body(BodyType.STATIC);

        var shape:Polygon = new Polygon(Polygon.rect(0, 0, Std.parseInt(object.att.width), Std.parseInt(object.att.height)));
          collisionBody.shapes.add(shape);
          collisionBody.position = Vec2.get(Std.parseInt(object.att.x) + Std.parseInt(object.att.width) / 2, Std.parseInt(object.att.y) + Std.parseInt(object.att.height) / 2);
      }
    }
  }
}
