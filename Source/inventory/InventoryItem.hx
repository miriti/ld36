package inventory;

import equip.Equipment;

class InventoryItem  {

  public var equipment:Equipment = null;

  public function new() {
  }

  public static function factory(id:String):InventoryItem {
    switch id {
      case 'basic-tool':
        return new BasicToolItem();
      case 'spear':
        return new SpearItem();
      case 'rock':
        return new RockItem();
      }

    return null;

  }

}
