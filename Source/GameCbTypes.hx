package ;

import nape.callbacks.CbType;

class GameCbTypes {
  private static var _ground:CbType = null;

  public static function getGround():CbType {
    if(_ground == null) {
      _ground = new CbType();
    }

    return _ground;
  }
}
