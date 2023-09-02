import "../helpers/exports.dart";
import "exports.dart";

/// A data-class containing the different constraints
class WaveCollapseConstraints<T> {
  // VARIABLES =================================================================

  /// The number of columns of the grid.
  final int rows;

  /// The number of rows of the grid.
  final int columns;

  /// The ID of the default option.
  /// If non-null, it can appear anywhere, regardless of neighbors or uses.
  final String? defaultOptionID;

  /// A map listing the maximum number of uses of an option, if there is one.
  ///
  /// The options are identified through their ID;
  final Map<String, int> optionMaxUses;

  /// A map listing the effects to be applied when an option is placed.
  ///
  /// The options are identified through their ID;
  final Map<String, List<WaveCollapseEffect<T>>> onPlaceEffects;

  final bool Function(String source, String target, Direction direction)?
      _allowsNeighbor;

  final bool Function(String id, Coordinates coordinates)? _allowsPosition;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [WaveCollapseConstraints] matching the given parameters.
  ///
  /// - [rows] and [columns] define the size of the resulting grid.
  /// - [optionMaxUses] gives the maximum number of use per option, if an option
  /// is not listed then it has no use limit.
  /// - [defaultOption] is the default tile that can appear anywhere, regardless
  /// of neighbors or uses. If set, it guarantees that the algorithm will return
  /// a [Grid] with no null elements.
  /// - [allowsNeighbor] tests whether it is legal to place the target next
  /// to the source in the given direction. If not set, all neighbors are
  /// allowed in all directions.
  /// - [allowsPosition] test whether it is legal to place an option at the
  /// given coordinates. If not set, all positions are okay for all options.
  WaveCollapseConstraints({
    required this.rows,
    required this.columns,
    Map<String, int>? optionMaxUses,
    Map<String, List<WaveCollapseEffect<T>>>? onPlaceEffects,
    bool Function(String source, String target, Direction direction)?
        allowsNeighbor,
    bool Function(String id, Coordinates coordinates)? allowsPosition,
    this.defaultOptionID,
  })  : optionMaxUses = optionMaxUses ?? {},
        onPlaceEffects = onPlaceEffects ?? {},
        _allowsNeighbor = allowsNeighbor,
        _allowsPosition = allowsPosition;

  // METHODS ===================================================================

  /// Returns whether it is legal to place the target next to the source in the
  /// given direction.
  bool allowsNeighbor(
    String source,
    String target,
    Direction direction, {
    bool checkSymmetric = false,
  }) {
    if (_allowsNeighbor == null) return true;
    if (!checkSymmetric) return _allowsNeighbor!(source, target, direction);
    return _allowsNeighbor!(source, target, direction) &&
        _allowsNeighbor!(target, source, direction.opposite);
  }

  /// Returns whether it is legal to place the option at the given coordinates.
  bool allowsPosition(String id, Coordinates coordinates) {
    if (_allowsPosition == null) return true;
    return _allowsPosition!(id, coordinates);
  }
}
