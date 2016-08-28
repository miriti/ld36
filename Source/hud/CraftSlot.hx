package hud;

import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.Assets;

class CraftSlot extends Sprite {

  public var containsIcon: InventoryIcon = null;
  public var largeIcon:Bitmap = null;

  public function new() {
    super();

    buttonMode = true;

    graphics.beginFill(0x999999);
    graphics.drawRect(0, 0, 90, 90);
    graphics.endFill();

    addEventListener(MouseEvent.MOUSE_DOWN, function(e: MouseEvent) {
      putIcon(Inventory.instance.selected);
    });
  }

  public function putIcon(icon:InventoryIcon): Void {
    if(containsIcon != null) {
      removeChild(largeIcon);
      Inventory.instance.collect(containsIcon.item, 1);
      containsIcon = null;
    } else {
      if ((icon != null) && (icon.count > 0)) {
        containsIcon = icon;
        largeIcon = new Bitmap(Assets.getBitmapData("assets/icon-" + containsIcon.item + "-lg.png"));
        addChild(largeIcon);
        Inventory.instance.collect(containsIcon.item, -1);
      }
    }
  }

}
