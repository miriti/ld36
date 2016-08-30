package;

import openfl.media.Sound;
import openfl.Assets;

class GameSounds  {

  public var craft:Sound;

  private static var _instance:GameSounds = null;

  public static function getInstance():GameSounds {
    if(_instance == null) {
      _instance = new GameSounds();
    }

    return _instance;
  }

  public function new() {
    craft = Assets.getSound('sfx/craft.wav');
  }

}
