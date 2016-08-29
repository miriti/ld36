package interactive;

import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.Assets;

import equip.Equipment;
import nape.geom.Vec2;

class Tree extends Interactive {
  var hits:Int = 4;
  var woodCount:Int;

  private static var treeTopData:BitmapData = null;
  private static var treeBaseData:BitmapData = null;
  private static var treeTrunkData:BitmapData = null;
  private static var treeBranchData:BitmapData = null;

  public function new(atx:Int, aty:Int, nwidth:Int, nheight:Int, woodCount:Int=4) {
    super();

    if(treeTopData == null)
      treeTopData = Assets.getBitmapData('assets/tree-top.png');

    if(treeBaseData == null)
      treeBaseData = Assets.getBitmapData('assets/tree-base.png');

    if(treeTrunkData == null)
      treeTrunkData = Assets.getBitmapData('assets/tree-trunk.png');

    if(treeBranchData == null)
      treeBranchData = Assets.getBitmapData('assets/tree-branch.png');

    var treeTop:Bitmap = new Bitmap(treeTopData);
    var treeBase:Bitmap = new Bitmap(treeBaseData);

    this.woodCount = woodCount;

    var segments = nheight / 30;

    treeTop.x = (30 - treeTop.width) / 2;

    segments--;

    var nextTop = 30;

    while(segments > 1) {
      var treeTrunk:Bitmap = new Bitmap(treeTrunkData);
      treeTrunk.y = nextTop;
      addChild(treeTrunk);

      var treeBranch:Bitmap = new Bitmap(treeBranchData);
      treeBranch.x = x + 15;
      treeBranch.y = nextTop;
      treeBranch.scaleX = segments % 2 == 0 ? 1 : -1;
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

    if(--hits <= 0) {
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
