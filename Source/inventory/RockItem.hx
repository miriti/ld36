package inventory;

import equip.RockThrow;

class RockItem extends InventoryItem  {

  public function new() {
    super();

    equipment = new RockThrow();
  }

}
