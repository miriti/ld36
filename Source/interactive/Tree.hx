package interactive;

import equip.Equipment;
import nape.geom.Vec2;

class Tree extends Interactive {
  var hits:Int = 4;
  var woodCount:Int;

  public function new(atx:Int, aty:Int, nwidth:Int, nheight:Int, woodCount:Int=4) {
    super();

    this.woodCount = woodCount;

    graphics.beginFill(0x880000);
    graphics.drawRect(0, 0, nwidth, nheight);
    graphics.endFill();

    x = atx;
    y = aty;
  }

  override public function hit(with:Equipment) : Void {
    super.hit(with);

    if(--hits<=0) {
      for(i in 0...woodCount) {
        var wood:Wood = new Wood();
        wood.position = Vec2.get(x + width/2,  y + i * (height/woodCount));
        wood.body.velocity = Vec2.get(Math.random()*100, Math.random()*100);
        parent.addChild(wood);
        wood.space = space;
      }

      space = null;
      visible = false;
      //parent.removeChild(this);

      Interactive.current = null;
    }
  }

}
