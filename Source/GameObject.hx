package ;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.Lib;

class GameObject extends Sprite {
  var lastTime:Int = 0;
  public function new() {
    super();
    lastTime = Lib.getTimer();
    addEventListener(Event.ENTER_FRAME, onEnterFrame);
  }

  private function onEnterFrame(e:Event) : Void {
    var currentTime = Lib.getTimer();
    var deltaTime:Float = (currentTime - lastTime) / 1000;
    update(deltaTime);
    lastTime = currentTime;
  }

  public function update(delta:Float) {}

}
