package interactive;

import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.Assets;

import equip.Equipment;
import nape.geom.Vec2;

class Tree extends Interactive {
  var hits:Int = 4;
  var woodCount:Int;

  public function new(atx:Int, aty:Int, nwidth:Int, nheight:Int, woodCount:Int=4) {
    super();

    var treeTop:Bitmap = new Bitmap(Assets.getBitmapData('assets/tree-top.png'));
    var treeBase:Bitmap = new Bitmap(Assets.getBitmapData('assets/tree-base.png'));

    this.woodCount = woodCount;

    var segments = nheight / 30;

    treeTop.x = (30 - treeTop.width) / 2;

    segments--;

    var nextTop = 30;

    while(segments > 1) {
      var treeTrunk:Bitmap = new Bitmap(Assets.getBitmapData('assets/tree-trunk.png'));
      treeTrunk.y = nextTop;
      addChild(treeTrunk);

      var treeBranch:Bitmap = new Bitmap(Assets.getBitmapData('assets/tree-branch.png'));
      treeBranch.x = x + 15;
      treeBranch.y = nextTop;
      treeBranch.scaleX = segments%2==0 ? 1 : -1;
      addChild(treeBranch);

      nextTop += 30;
      segments--;
    }

    addChild(treeTop);

    treeBase.y = nextTop;
    treeBase.x = (30 - treeBase.width) / 2;
    addChild(treeBase);

    x = atx;
    y = aty;
  }

  override public function hit(with:Equipment) : Void {
    super.hit(with);

    if(--hits<=0) {
      for(i in 0...woodCount) {
        var wood:Wood = new Wood();
        wood.position = Vec2.get(x + width/2,  y + i * (height/woodCount));
        wood.body.velocity = Vec2.get(Math.random()*100, Math.random()*100);
        parent.addChild(wood);
        wood.space = space;
      }

      space = null;
      visible = false;

      Interactive.current = null;
    }
  }

}
