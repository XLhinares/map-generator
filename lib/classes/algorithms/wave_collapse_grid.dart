import "dart:math";

import "../helpers/exports.dart";
import "exports.dart";

/// A helper class that offers utility for collapsing a grid of [CollapseOption].
class CollapsableGrid extends Grid<WeightedList<String>?> {
  // VARIABLES =================================================================

  final double _maxWeight = 3.5;

  /// The constraints given to the parent [WaveCollapseAlgorithm].
  ///
  /// It is mainly used to know what option can be placed where.
  final WaveCollapseConstraints constraints;

  // CONSTRUCTOR ===============================================================

  /// Returns a [CollapsableGrid] matching the given parameters.
  CollapsableGrid({
    required List<CollapseOption> options,
    required this.constraints,
    required int rows,
    required int columns
  }) : super(Grid<WeightedList<String>?>.generate(rows, columns, (coordinates) => null).toList());

  /// Reset all the values from the grid.
  ///
  /// Each cell takes all possible value via a weighted list of options.
  /// If the initial grid has set cells, the matching cells are collapsed.
  void reset ({
    required Iterable<CollapseOption> options,
    required Grid<String?> initialGrid,
  }) {
    setForEach((coordinates, element) {
      final Iterable<CollapseOption> possibleOptions = options
          .where((option) =>
          constraints.allowsPosition(option.id, coordinates));

      final Iterable<WeightedValue<String>> possibleOptionsID = possibleOptions
          .map((e) => WeightedValue(e.weight, e.id));

      final WeightedList<String> result = possibleOptionsID.toList();

      return result.isEmpty ? null : result;
    });

    // Add the constraints from the original grid.
    initialGrid.forEach((coordinates, element) {
      if (element != null) collapseAt(coordinates, element);
    });
  }

  // METHODS ===================================================================

  /// Picks a likely coordinates at weighted random.
  Coordinates selectCoordinates() {
    final WeightedList<Coordinates> potentialCoordinates = [];

    forEach((coordinates, list) {
      // Skip the empty cells
      if (list == null) return;
      if (list.totalWeight == 0) return;
      potentialCoordinates
          .add(WeightedValue(list.totalWeight, coordinates));
    });

    final result = potentialCoordinates.pick();
    if (result == null) throw Exception("No possible coordinates found.");
    return result;
  }

  /// Collapses the options at a specific point in the grid.
  void collapseAt(Coordinates coordinates, String selectedOption) {

    set(coordinates, null);
    for (final WaveCollapseEffect effect in constraints.onPlaceEffects[selectedOption] ?? []) {
      for (final Coordinates cell in effect.pattern.targetCells) {
        if (isInGrid(coordinates + cell) && at(coordinates + cell) != null) {

          final WeightedList<String> options = at(coordinates + cell)!;
          final WeightedList<String> newOptions = [];

          for (final WeightedValue<String> option in options) {
            newOptions.add(WeightedValue(
              min(effect.setWeight(cell, option.value, option.weight) ?? 1, _maxWeight),
              option.value,
            ));
          }

          set(coordinates + cell, newOptions.isEmpty ? null : newOptions);
        }
      }
    }
  }
}
