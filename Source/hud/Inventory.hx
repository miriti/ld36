package hud;

import openfl.display.Sprite;

class Inventory extends Sprite {
  public static var instance:Inventory;
  public var selected:InventoryIcon;
  public var icons:Map<String, InventoryIcon> = new Map<String, InventoryIcon>();

  var nextInconX:Int = 0;

  public function new() {
    super();

    instance = this;
  }

  public function collect(item:String, count:Int) : Void {
    var icon:InventoryIcon;

    if(icons.exists(item)) {
      icon = icons[item];
    } else {
      icon = new InventoryIcon(item);
      icon.x = nextInconX;
      nextInconX += 50;
      icons[item] = icon;
      addChild(icon);
    }

    icon.count += count;
  }

}
