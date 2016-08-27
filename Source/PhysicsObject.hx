package ;

import nape.space.Space;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.geom.Vec2;

class PhysicsObject extends GameObject  {
  public var space(default, set):Space;
  public var body:Body;
  public var position(get, set):Vec2;

  public function get_position():Vec2 {
    return body.position;
  }

  public function set_position(newpos: Vec2):Vec2 {
    body.position.set(newpos);
    return body.position;
  }

  public function set_space(new_space: Space):Space {
    return this.body.space = new_space;
  }

  /**
   * Constructor
   */
  public function new(bodyType:BodyType) {
    super();
    body = new Body(bodyType);
  }

  override function update(delta:Float) {
    this.x = body.position.x;
    this.y = body.position.y;
    this.rotation = (180 / Math.PI) * body.rotation;
  }

}
