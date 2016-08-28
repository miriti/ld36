package ;

import openfl.display.Stage;
import openfl.events.EventDispatcher;
import openfl.events.KeyboardEvent;
import openfl.events.MouseEvent;
import openfl.Lib;

class GameInput extends EventDispatcher {

  private static var _instance:GameInput = null;

  public static inline var KEY_A = 37;
  public static inline var KEY_LEFT = 65;
  public static inline var KEY_D = 39;
  public static inline var KEY_RIGHT = 68;
  public static inline var KEY_SPACE = 32;
  public static inline var KEY_W = 87;
  public static inline var KEY_UP = 38;


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
    if(!keys[e.keyCode]) {
      dispatchEvent(e);
    }

    keys[e.keyCode] = true;
  }

  private function onKeyUp(e: KeyboardEvent): Void {
    if(keys[e.keyCode]) {
      dispatchEvent(e);
    }

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
    return keys[KEY_A] || keys[KEY_LEFT];
  }

  public function isRight() : Bool {
    return keys[KEY_D] || keys[KEY_RIGHT];
  }

}
