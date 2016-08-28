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

import mobs.Player;

import interactive.Tree;
import interactive.Rocks;

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
          tile.x = tileX * 30;
          tile.y = tileY * 30;
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
      var b_x:Int = 0;
      var b_y:Int = 0;
      var b_width:Int = 0;
      var b_height:Int = 0;

      if((object.has.x) && (object.has.y)) {
        b_x = Std.parseInt(object.att.x);
        b_y = Std.parseInt(object.att.y);
      }

      if((object.has.width) && (object.has.height)) {
        b_width = Std.parseInt(object.att.width);
        b_height = Std.parseInt(object.att.height);
      }

      if( object.att.type == 'player' ) {
        var player:Player = new Player();
        player.space = space;
        space.listeners.add(player.interactionListener);

        //trace( player.interactionListener, player.interactionListener.space );

        player.position = Vec2.get(Std.parseInt(object.att.x), Std.parseInt(object.att.y));
        addChild(player);

        GameMain.getInstance().following = player;
      }

      if( object.att.type == 'collision' ) {
        var collisionBody:Body = new Body(BodyType.STATIC);
        collisionBody.cbTypes.add(GameCbTypes.getGround());

        if((object.has.width) && (object.has.height)) {

          var shape:Polygon = new Polygon(Polygon.box(b_width, b_height));
          collisionBody.shapes.add(shape);
          collisionBody.position = Vec2.get(b_x + b_width / 2, b_y + b_height / 2);
        }

        if(object.hasNode.polygon) {
          var points_strs:Array<String> = object.node.polygon.att.points.split(" ");
          var polygon_points:Array<Vec2> = new Array<Vec2>();

          for(ps in points_strs) {
            var s:Array<String> = ps.split(",");
            var v:Vec2 = Vec2.get(Std.parseInt(s[0]), Std.parseInt(s[1]));
            polygon_points.push(v);
          }

          var shape:Polygon = new Polygon(polygon_points);
          collisionBody.shapes.add(shape);
          collisionBody.position = Vec2.get(b_x, b_y);
        }

        collisionBody.space = space;
      }

      if( object.att.type == 'water' ) {
        trace( "water?" );
      }

      if( object.att.type == 'tree' ) {
        var woodCount:Int = 4;
        if(object.hasNode.properties) {
          for(prop in object.node.properties.nodes.property) {
            if(prop.att.name == 'wood_count') {
              woodCount = Std.parseInt(prop.att.value);
            }
          }
        }

        var tree:Tree = new Tree(b_x, b_y, b_width, b_height, woodCount);
        tree.space = space;
        addChild(tree);
      }

      if( object.att.type == 'rocks' ) {
        var rocks:Rocks = new Rocks(b_x, b_y, b_width, b_height);
        rocks.space = space;
        addChild(rocks);
      }
    }
  }
}
