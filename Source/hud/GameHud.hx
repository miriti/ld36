package hud;

import openfl.display.Sprite;
import openfl.events.Event;

import motion.Actuate;

class GameHud extends Sprite {
  var btnCraft:Button;
  var craft:Craft;
  var shade:Sprite;
  var inventory:Inventory;

  var craftMode:Bool = false;

  public function new() {
    super();

    btnCraft = new Button('btn-craft');
    addChild(btnCraft);
    btnCraft.addEventListener('action', function(e:Event) {
      showCraft();
    });

    shade = new Sprite();
    shade.visible = false;
    addChild(shade);

    craft = new Craft();
    craft.visible = false;
    craft.y = -craft.height;
    addChild(craft);

    inventory = new Inventory();

    craft.addEventListener('done', function(e:Event) {
      closeCraft();
    });

    addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
  }

  public function shadeOn(): Void {
    shade.visible = true;
    shade.alpha = 0;
    Actuate.tween(shade, 1, {alpha: 0.8});
  }

  public function shadeOff(): Void {
    Actuate.tween(shade, 1, {alpha: 0}).onComplete(function() {
      shade.visible = false;
    });
  }

  public function showCraft():Void {
    craftMode = true;
    shadeOn();
    craft.visible = true;
    Actuate.tween(craft, 1, {y: (stage.stageHeight - craft.height) / 2});
    Actuate.tween(inventory, 1, {x: (stage.stageWidth - inventory.width) / 2});
  }

  public function closeCraft(): Void {
    craftMode = false;
    shadeOff();
    Actuate.tween(craft, 0.5, {y: -craft.height}).onComplete(function() {
      craft.visible = false;
    });
    Actuate.tween(inventory, 1, {x: 30});
  }

  private function onAddedToStage(e:Event) : Void {
    shade.graphics.beginFill(0xffffff);
    shade.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
    shade.graphics.endFill();

    craft.x = (stage.stageWidth - craft.width) / 2;

    inventory.x = 30;
    inventory.y = stage.stageHeight - 50;
    addChild(inventory);

    btnCraft.x = stage.stageWidth - (btnCraft.width / 2) - 50;
    btnCraft.y = stage.stageHeight - (btnCraft.height / 2) - 25;
  }

}
