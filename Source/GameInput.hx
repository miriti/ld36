package ;

import openfl.display.Stage;
import openfl.events.EventDispatcher;
import openfl.events.KeyboardEvent;
import openfl.events.MouseEvent;

class GameInput extends EventDispatcher {

  private static var _instance:GameInput = null;

  private var keys:Array<Bool> = new Array<Bool>();
  private var mouseDown: Bool = false;

  public static function getInstance():GameInput {
    if(_instance == null) {
      _instance = new GameInput();
    }

    return _instance;
  }

  public function new() {
    super();
  }

  public function init(stage: Stage) {
    stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
    stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
    stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
    stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
  }

  private function onKeyDown(e: KeyboardEvent): Void {
    keys[e.keyCode] = true;
  }

  private function onKeyUp(e: KeyboardEvent): Void {
    keys[e.keyCode] = false;
  }

  private function onMouseDown(e: MouseEvent): Void {
    if(!mouseDown) {
      dispatchEvent(e);
    }

    mouseDown = true;
  }

  private function onMouseUp(e: MouseEvent): Void {
    if(mouseDown) {
      dispatchEvent(e);
    }

    mouseDown = false;
  }

  public function isLeft() : Bool {
    return keys[37] || keys[65];
  }

  public function isRight() : Bool {
    return keys[39] || keys[68];
  }

}
