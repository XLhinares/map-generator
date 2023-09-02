// Framework dependencies
import "direction.dart";

/// An convenient abbreviation for [List<DirectionValue>].
typedef DirectionList<T> = List<DirectionValue<T>>;

// /// A set of tools for [DirectionList].
// extension DirectionListTools<T> on DirectionList<T> {
//
//   /// Picks a random value while accounting for their weight.
//   T pick (List<Direction> directions) {
//
//     return firstWhere((element) => element.directions == directions).value;
//   }
// }

/// A dataclass that combines a value and a set of directions.
class DirectionValue<T> {
  // VARIABLES =================================================================

  /// All the directions which match the value.
  final Direction direction;

  /// The actual value.
  final T value;

  // GETTERS ===================================================================

  /// Whether the value goes towards up.
  bool get up => direction == Direction.up;

  /// Whether the value goes towards down.
  bool get down => direction == Direction.down;

  /// Whether the value goes towards the left.
  bool get left => direction == Direction.left;

  /// Whether the value goes towards the right.
  bool get right => direction == Direction.right;

  /// Whether the value goes towards in no specific direction.
  bool get center => direction == Direction.none;

  // CONSTRUCTOR ===============================================================

  /// Returns a [DirectionValue] matching the given parameters.
  ///
  /// It requires:
  /// - [directions]: All the matching [Direction].
  /// - [value]: The actual value.
  const DirectionValue({
    required this.direction,
    required this.value,
  });

  /// Parses the [DirectionValue] from the direction string.
  ///
  /// - u means [up]
  /// - d means [down]
  /// - l means [left]
  /// - r means [right]
  /// - c means [center]
  factory DirectionValue.parse(
    String direction,
    T value,
  ) {
    final List<Direction> directions = [];
    if (direction.contains("u")) directions.add(Direction.up);
    if (direction.contains("d")) directions.add(Direction.down);
    if (direction.contains("l")) directions.add(Direction.left);
    if (direction.contains("r")) directions.add(Direction.right);
    if (direction.contains("c")) directions.add(Direction.none);

    return DirectionValue(direction: directions.first, value: value);
  }

// METHODS ===================================================================
}
