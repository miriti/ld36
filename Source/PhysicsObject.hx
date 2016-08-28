package ;

import nape.space.Space;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.geom.Vec2;

class PhysicsObject extends GameObject  {
  public var space(default, set):Space;
  public var body:Body;
  public var position(get, set):Vec2;
  public var enabled:Bool = true;

  public function get_position():Vec2 {
    return body.position;
  }

  public function set_position(newpos: Vec2):Vec2 {
    body.position.set(newpos);
    return body.position;
  }

  public function set_space(new_space: Space):Space {
    if(enabled) {
      return space = this.body.space = new_space;
    }

    return space = new_space;
  }

  /**
   * Constructor
   */
  public function new(bodyType:BodyType) {
    super();
    body = new Body(bodyType);
  }

  override function update(delta:Float) {
    if(enabled) {
      if(body.allowMovement) {
        this.x = body.position.x;
        this.y = body.position.y;
      }

      if(body.allowRotation) {
        this.rotation = (180 / Math.PI) * body.rotation;
      }
    }
  }

}
