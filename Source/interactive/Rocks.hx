package interactive;

import equip.Equipment;
import nape.geom.Vec2;

class Rocks extends Interactive {
  var hits:Int = 6;

  public function new(atx:Int, aty:Int, nwidth:Int, nheight:Int) {
    super();

    graphics.beginFill(0x999999);
    graphics.drawRect(0, 0, nwidth, nheight);
    graphics.endFill();

    x = atx;
    y = aty;
  }

  override public function hit(with:Equipment): Void {
    super.hit(with);

    if(--hits <= 0) {
      for(i in 0...Std.int(width/20)) {
        for(j in 0...Std.int(height/20)) {
          var rock:Rock = new Rock();
          rock.position = Vec2.get(10 + x + i * 20, 10 + y + j * 20);
          parent.addChild(rock);
          rock.space = space;
        }
      }

      Interactive.current = null;
      space = null;
      visible = false;
    }
  }

}
