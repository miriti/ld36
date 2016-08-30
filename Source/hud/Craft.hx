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

    var doneButton = new Button('btn-close');
    doneButton.x = bitmap.width - doneButton.width/2 - 10;
    doneButton.y = bitmap.height - doneButton.height/2 - 10;
    addChild(doneButton);

    var craftButton = new Button('btn-craft-action');
    craftButton.x = 332 + craftButton.width / 2;
    craftButton.y = doneButton.y;
    addChild(craftButton);

    craftButton.addEventListener('action', function(e:Event) {
      var counts:Map<String, Int> = new Map<String,Int>();

      for (slot in slots) {
        if(slot.containsIcon != null) {
          var item = slot.containsIcon.item;

          if(counts.exists(item)) {
              counts[item] = counts[item] + 1;
          } else {
              counts[item] = 1;
          }
        }

        slot.putIcon(null);
      }

      if(counts.exists('wood')) {
        if(counts.exists('rock')) {
          if((counts['wood'] == 3) && (counts['rock'] == 1)) {
            GameSounds.getInstance().craft.play();

            Inventory.instance.collect('wood', -3);
            Inventory.instance.collect('rock', -1);
            Inventory.instance.collect('spear', 1);
          }
        } else {
          if(counts['wood'] == 9) {
            GameSounds.getInstance().craft.play();

            Inventory.instance.collect('bridge', 1);
            Inventory.instance.collect('wood', -9);
          }
        }
      }

      Inventory.instance.selected = null;
    });

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
