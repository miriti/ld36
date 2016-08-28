package interactive;

import openfl.filters.GlowFilter;
import openfl.events.MouseEvent;

class Tree extends GameObject {

  public function new(atx:Int, aty:Int, nwidth:Int, nheight:Int) {
    super();

    graphics.beginFill(0x880000);
    graphics.drawRect(0, 0, nwidth, nheight);
    graphics.endFill();

    x = atx;
    y = aty;

    var glowFilter:GlowFilter = new GlowFilter();

    addEventListener(MouseEvent.MOUSE_OVER, function(e:MouseEvent) {
      trace( "over" );
      filters = [glowFilter];
    });

    addEventListener(MouseEvent.MOUSE_OUT, function(e:MouseEvent) {
      filters = [];
      trace( "out" );
    });
  }

}
