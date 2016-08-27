package ;

import haxe.xml.Fast;
import haxe.crypto.Base64;

import openfl.display.Sprite;
import openfl.Assets;

import nape.geom.Vec2;

import tiles.TileMap;
import tiles.Tile;

class GameMap extends Sprite  {
  var tiles:Array<Array<Tile>>;

  public function new() {
    super();
  }

  public function load(space) {
    var xml:Xml = Xml.parse(Assets.getText('assets/map.tmx') );
    var fast:Fast = new Fast(xml.firstElement());

    var tileMap:TileMap = new TileMap(fast.node.tileset);

    for (layer in fast.nodes.layer) {
      trace( layer.att.name, layer.att.width, layer.att.height );

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
          tileX=0;
          tileY++;
        }
      }
    }
  }

  public function generate(space) : Void {
    var width = 20;
    var height = 10;

/*
    tiles = new Array<Array<Tile>>();

    for(i in 0...width) {
      tiles[i] = new Array<Tile>();
      for(j in 0...height) {
        tiles[i][j] = new Tile();
        tiles[i][j].position = Vec2.get(-(20*30)/2 + i * 30, -(10*30)/2 + j * 30);
        tiles[i][j].space = space;
        addChild(tiles[i][j]);
      }

    }
      */
  }

}
