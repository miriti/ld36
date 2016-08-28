package equip;

import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.Assets;
import motion.Actuate;

import interactive.Interactive;

class BasicTool extends Equipment  {

  var bitmap:Bitmap;
  var container:Sprite;

  public function new() {
    super();

    bitmap = new Bitmap(Assets.getBitmapData("assets/basic-tool.png"));
    bitmap.x = -bitmap.width/2;
    bitmap.y = -bitmap.height*0.75;

    container = new Sprite();
    container.addChild(bitmap);
    container.x = 35;

    var newDisplay = new Sprite();
    newDisplay.addChild(container);

    display = newDisplay;
  }

  private function animate() {
    Actuate.tween(container, 0.1, {rotation: -60}).onComplete(function() {
      Actuate.tween(container, 0.1, {rotation: 140}).onComplete(function() {
        if(Interactive.current != null) {
          var bounds = Interactive.current.getBounds(mob.parent);

          if(Math.min(Math.abs(bounds.x - mob.x), Math.abs((bounds.x+bounds.width) - mob.x)) <= 100) {
            Interactive.current.hit(this);
          }
        }
        Actuate.tween(container, 0.1, {rotation: 0}).onComplete(function() {
          if(inAction) {
            animate();
          }
          });
        });
      });
  }

  override public function beginAction() : Void {
    super.beginAction();
    animate();
  }

}
