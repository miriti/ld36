package ;

import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.Assets;

class Button extends Sprite {
  var bitmap:Bitmap;

  public function new(image:String) {
    super();

    buttonMode = true;

    bitmap = new Bitmap(Assets.getBitmapData("assets/" + image + ".png"));
    bitmap.x = -bitmap.width/2;
    bitmap.y = -bitmap.height/2;

    addChild(bitmap);

    addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent):Void {
        scaleX = scaleY = 0.9;
    });

    addEventListener(MouseEvent.MOUSE_UP, function(e:MouseEvent):Void {
      scaleX = scaleY = 1;
      dispatchEvent(new Event('action'));
    });
  }

}
