const MovingObject = require("./moving_object.js");
const Utils = require("./utils.js");

function Asteroid(pos, game) {
  this.COLOR = "red";
  this.RADIUS = "20";

  MovingObject.call(this, {
    pos: [pos[0], pos[1]],
    vel: Utils.randomVec(10),
    radius: this.RADIUS,
    color: this.COLOR,
    game: game
  });
}

Utils.inherits(Asteroid, MovingObject);

module.exports = Asteroid;