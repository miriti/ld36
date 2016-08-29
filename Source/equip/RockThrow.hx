package equip;

import openfl.display.Sprite;

import hud.Inventory;

class RockThrow extends ThrowEquipment {

  public function new() {
    super();

    display = new Sprite();
  }

  override public function generateProjectile(): PhysicsObject {
    return new ThrowableRock();
  }

  override public function endAction(): Void {
    super.endAction();

    Inventory.instance.collect('rock', -1);

    if(Inventory.instance.icons['rock'].count == 0) {
      mob.equipment = null;
    }
  }

}
