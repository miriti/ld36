package inventory;

import equip.BridgeBuilder;

class BridgeItem extends InventoryItem {

  public function new() {
    super();
    equipment = new BridgeBuilder();
  }

}
