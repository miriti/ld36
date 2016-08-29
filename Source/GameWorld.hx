package ;

import openfl.display.Sprite;
import openfl.events.Event;

import nape.geom.Vec2;
import nape.space.Space;

class GameWorld extends GameObject {

  var gameMap:GameMap;
  var space:Space;

  public function new() {
    super();

    var gravity = Vec2.weak(0, 600);
    space = new Space(gravity);

    gameMap = new GameMap();
    gameMap.load(space);
    addChild(gameMap);
  }

  override function update(delta:Float) {
    space.step(1/60);
  }

}
