import "dart:core";

import "../helpers/exports.dart";
import "exports.dart";

/// An implementation of the wave collapse algorithm.
///
/// It uses a list of options and a list of constraints
class WaveCollapseAlgorithm<T> {
  /// A set of constraints to consider when generating the tiling.
  final WaveCollapseConstraints<T> constraints;

  /// The different choices for the collapse option.
  final Map<String, CollapseOption<T>> options;

  /// The grid containing all the possible state of each cells at any time.
  late final CollapsableGrid _optionGrid;

  /// The grid containing the result of the WCA.
  ///
  /// It is iteratively populated, which means you can observe the changes
  /// between iterations.
  late final Grid<T?> resultGrid;

  // GETTERS ===================================================================

  /// Whether the grid has completely collapsed, meaning the algorithm is over.
  bool get collapsed => resultGrid.coordinatesWhere((e) => e == null).isEmpty;

  // CONSTRUCTOR ===============================================================

  /// Returns a [Scheme]
  WaveCollapseAlgorithm({
    required Grid<String?> initialGrid,
    required List<CollapseOption<T>> options,
    required this.constraints,
  }) :
      options = {}
  {
    for (final option in options) {
      this.options[option.id] = option;
    }

    resultGrid = initialGrid.map((_, id) => this.options[id]?.builder());
    _optionGrid = CollapsableGrid(
        options: options,
        constraints: constraints,
        rows: initialGrid.rows,
        columns: initialGrid.columns,
    );

    reset(initialGrid: initialGrid);
  }

  /// Clears the result of the algorithm and set the grid to match the provided [initialGrid].
  void reset ({
    required Grid<String?> initialGrid,
  }) {
    resultGrid.setForEach((coordinates, element) => options[initialGrid.at(coordinates)]?.builder());
    _optionGrid.reset(options: options.values, initialGrid: initialGrid);
  }

  // METHODS ===================================================================

  /// Run one step of the algorithm.
  void iterate() {
    final Coordinates coordinates = _optionGrid.selectCoordinates();
    final String selectedOptionID = _optionGrid.at(coordinates)!.pick()!;
    _collapse(coordinates, selectedOptionID);
  }

  void _collapse (Coordinates coordinates, String selectedOptionID) {
    final CollapseOption<T> selectedOption = options[selectedOptionID]!;
    _optionGrid.collapseAt(coordinates, selectedOptionID);
    resultGrid.set(coordinates, selectedOption.builder());
  }

  /// Iterates the algorithm until the grid is fully collapsed.
  Grid<T> generate() {
    while (!collapsed) {
      iterate();
    }
    return Grid<T>.generate(
      resultGrid.rows,
      resultGrid.columns,
          (coordinates) => resultGrid.at(coordinates)!,
    );
  }
}
