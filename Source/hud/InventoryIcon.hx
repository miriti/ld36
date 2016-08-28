package hud;

import openfl.events.Event;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import openfl.Assets;

import motion.Actuate;

import inventory.InventoryItem;

import mobs.Player;

class InventoryIcon extends Button {
  public var inventoryItem:InventoryItem;
  public var count(default, set):Int = 0;
  public var item:String;
  var countText:TextField;

  function set_count(value:Int):Int {
    scaleX = scaleY = 1.2;
    countText.text = Std.string(value);

    Actuate.tween(this, 1, {
      scaleX: 1,
      scaleY: 1
    });

    return count = value;
  }

  public function new(item: String) {
    super("icon-" + item);

    inventoryItem = InventoryItem.factory(item);

    this.item = item;

    var textFormat:TextFormat = new TextFormat("sans-serif", 18, 0x000000, true);
    textFormat.align = TextFormatAlign.CENTER;

    countText = new TextField();
    countText.text = "0";
    countText.defaultTextFormat = textFormat;
    countText.y = bitmap.height / 2;
    countText.x = -bitmap.width / 2;
    countText.width = bitmap.width;

    addChild(countText);

    addEventListener('action', function(e: Event) {
      if(inventoryItem != null) {
        if(inventoryItem.equipment != null) {
          Player.getInstance().equipment = inventoryItem.equipment;
        }
      }
      Inventory.instance.selected = this;
    });
  }

}
