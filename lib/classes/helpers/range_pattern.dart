
import "exports.dart";

/// A helping class to represent areas in a grid.
/// L<d><r><R>: Linear <direction><min range><max range>
/// C<r><R>: Circle <min range><max range>
/// A<a><A><r><R>: Arc <min angle><max angle><min range><max range>
class RangePattern {
  // VARIABLES =================================================================

  /// The
  final List<Coordinates> targetCells;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [RangePattern] matching the given parameters.
  ///
  /// The given cells are in the range.
  RangePattern([
    List<Coordinates>? targetCells,
  ]) :
        targetCells = targetCells ?? [];

  /// A range pattern including only the center cell.
  factory RangePattern.self() => RangePattern([const Coordinates(0, 0)]);
  /// A range pattern including only the cell to the right of center.
  factory RangePattern.right() => RangePattern([const Coordinates(0, 1)]);
  /// A range pattern including only the cell to the left of center.
  factory RangePattern.left() => RangePattern([const Coordinates(0, -1)]);
  /// A range pattern including only the cell to the top of center.
  factory RangePattern.top() => RangePattern([const Coordinates(-1, 0)]);
  /// A range pattern including only the cell to the bottom of center.
  factory RangePattern.bottom() => RangePattern([const Coordinates(1, 0)]);

  /// A circular range pattern around the center.
  factory RangePattern.circular({
    int rangeMin = 1,
    int rangeMax = 1,
  }) =>
      RangePattern()
        ..addCircularPattern(
          rangeMin: rangeMin,
          rangeMax: rangeMax,
        );

  // METHODS ===================================================================

  /// Adds an horizontal pattern to the range.
  void addHorizontalPattern({
    List<Direction>? directions,
    int rangeMin = 1,
    int rangeMax = 1,
  }) {}

  /// Adds a circular pattern to the range.
  void addCircularPattern({
    int rangeMin = 1,
    int rangeMax = 1,
  }) {
    // The generated grid is twice as big to account for up and left quadrants.
    final Coordinates center = Coordinates(rangeMax, rangeMax);
    Grid.generate(rangeMax * 2 + 1, rangeMax * 2 + 1, (coordinates) {
      final distance = coordinates.distanceFrom(center);
      if (distance >= rangeMin && distance <= rangeMax) {
        targetCells.add(coordinates - center);
      }
    });
  }
}
