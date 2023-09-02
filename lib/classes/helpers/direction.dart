import "dart:math";

import "exports.dart";

/// A helper class that implements direction.
class Direction {
  // CONST =====================================================================

  /// No direction, just stays on place.
  static const Direction none = Direction._internal(Coordinates(0, 0));

  /// A direction going 1 step up.
  static const Direction up = Direction._internal(Coordinates(0, 1));
  /// A direction going 1 step down.
  static const Direction down = Direction._internal(Coordinates(0, -1));
  /// A direction going 1 step to the left.
  static const Direction left = Direction._internal(Coordinates(-1, 0));
  /// A direction going 1 step to the right.
  static const Direction right = Direction._internal(Coordinates(1, 0));

  // VARIABLES =================================================================

  // GETTERS ===================================================================

  /// Whether this direction is up.
  bool get isUp => this == Direction.up;

  /// Whether this direction is down.
  bool get isDown => this == Direction.down;

  /// Whether this direction is left.
  bool get isLeft => this == Direction.left;

  /// Whether this direction is right.
  bool get isRight => this == Direction.right;

  /// Whether this direction follows a vertical axis.
  bool get isVertical => isUp || isDown;

  /// Whether this direction follows an horizontal axis.
  bool get isHorizontal => isLeft || isRight;

  /// Whether this direction is none.
  bool get isNone => this == Direction.none;

  /// The opposite direction to this one.
  Direction get opposite {
    if (isUp) return Direction.down;
    if (isDown) return Direction.up;
    if (isRight) return Direction.left;
    if (isLeft) return Direction.right;
    return Direction.none;
  }

  // CONSTRUCTOR ===============================================================

  const Direction._internal(Coordinates point);

  /// Returns the cardinal direction most closely matching the given vector.
  factory Direction.approximate(num x, num y) {
    // Movement is mainly horizontal.
    if (x * x > y * y) {
      if (x > 0) return Direction.right;
      if (x < 0) return Direction.left;
    }

    // Movement is mostly vertical
    if (x > 0) return Direction.up;
    if (x < 0) return Direction.down;
    return Direction.none;
  }

  /// Returns the cardinal direction most closely matching the vector going from
  /// the source coordinates to the target coordinates.
  factory Direction.fromSourceToTarget(
      Coordinates source, Coordinates target) =>
      Direction.approximate(
          target.column - source.column, target.row - source.row);

  /// Returns the next point in this direction.
  Coordinates nextPoint(Coordinates point) => Point(
    point.x + (isUp ? 1 : 0) - (isDown ? 1 : 0),
    point.y + (isRight ? 1 : 0) - (isLeft ? 1 : 0),
  );
}
