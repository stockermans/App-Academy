function MovingObject (incoming) {
  this.position = incoming.pos;
  this.velocity = incoming.vel;
  this.radius = incoming.radius;
  this.color = incoming.color;
  this.game = incoming.game;
  this.isWrappable = incoming.isWrappable;
}

MovingObject.prototype.move = function() {
  this.position[0] += this.velocity[0];
  this.position[1] += this.velocity[1];
  console.log("This is wrappable: " + this.isWrappable)
  if (this.game.isOutOfBounds(this.position) && !this.isWrappable) {
    this.game.remove(this);
  } else {
    this.position = this.game.wrap(this.position);
  }
};

MovingObject.prototype.draw = function(ctx) {
  ctx.beginPath();
  ctx.arc(this.position[0], this.position[1], this.radius, 0, 2 * Math.PI);
  ctx.fillStyle = this.color;
  ctx.fill();
};

MovingObject.prototype.isCollidedWith = function(otherMovingObject) {
  let xDiff = otherMovingObject.position[0] - this.position[0];
  let yDiff = otherMovingObject.position[1] - this.position[1];

  let hypot = Math.hypot(xDiff, yDiff) ** 2;
  let radiuses = otherMovingObject.radius + this.radius;

  if (hypot <= radiuses) {
    return true;
  } else {
    return false;
  }
};

module.exports = MovingObject;