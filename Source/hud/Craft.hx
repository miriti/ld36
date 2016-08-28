package hud;

import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.Assets;

class Craft extends Sprite {

  var slots:Array<CraftSlot> = new Array<CraftSlot>();

  public function new() {
    super();

    var bitmap = new Bitmap(Assets.getBitmapData("assets/craft-window.png"));
    addChild(bitmap);

    for(i in 0...3) {
      for(j in 0...3) {
        var newSlot:CraftSlot = new CraftSlot();

        newSlot.x = 18 + i * (90+15);
        newSlot.y = 93 + j * (90+15);

        addChild(newSlot);

        slots.push(newSlot);
      }
    }

    var doneButton = new Button('btn-done');
    doneButton.x = bitmap.width - doneButton.width/2 - 15;
    doneButton.y = bitmap.height - doneButton.height/2 - 15;
    addChild(doneButton);

    doneButton.addEventListener('action', function(e:Event) {
      for(slot in slots) {
        slot.putIcon(null);
      }
      Inventory.instance.selected = null;
      dispatchEvent(new Event('done'));
    });
  }

  public function craft() : Void {
    
  }

}
