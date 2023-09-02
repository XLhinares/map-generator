import "dart:math";

/// A simple type for [Point<int>] in order to easily navigate through grids.
typedef Coordinates = Point<int>;

/// A set of extensions for [Coordinates] objects.
extension CoordinatesGetters on Coordinates {
  // GETTERS ===================================================================

  /// A rename for the first coordinate.
  int get row => x;
  
  /// A rename for the second coordinate.
  int get column => y;

  /// The coordinates to the left of this.
  Coordinates get left => Coordinates(row, column - 1);
  /// The coordinates to the right of this.
  Coordinates get right => Coordinates(row, column + 1);
  /// The coordinates to the top of this.
  Coordinates get top => Coordinates(row - 1, column);
  /// The coordinates to the bottom of this.
  Coordinates get bottom => Coordinates(row + 1, column);

  /// The coordinates to the top-left of this.
  Coordinates get topLeft => Coordinates(row - 1, column - 1);
  /// The coordinates to the top-right of this.
  Coordinates get topRight => Coordinates(row - 1, column + 1);
  /// The coordinates to the bottom-left of this.
  Coordinates get bottomLeft => Coordinates(row + 1, column - 1);
  /// The coordinates to the bottom-right of this.
  Coordinates get bottomRight => Coordinates(row + 1, column + 1);

  // CONSTRUCTOR ===============================================================

  /// A pseudo-constructor for centered coordinates;
  static Coordinates zero() => const Coordinates(0, 0);

  // METHODS ===================================================================

  /// Returns the distance from this to the target.
  double distanceFrom(Coordinates target) =>
      sqrt(pow(x - target.x, 2) + pow(y - target.y, 2));

  /// Returns the distance from this to the origin of the grid.
  double distanceFromOrigin() => sqrt(pow(x, 2) + pow(y, 2));
}
