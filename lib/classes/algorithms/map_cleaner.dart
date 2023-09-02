import "dart:math";

import "exports.dart";

/// An extension on the wave collapse algorithm that provides a method to clean isolated cells.
extension MapCleaner<T> on WaveCollapseAlgorithm<T> {
  

  /// A function that takes the resultGrid and removes isolated cells.
  ///
  /// - Isolated cells are cells that are different from all of their lateral
  /// neighbors.
  /// - If [cleanProbability] is 0.8, then 80% of the isolated cells will be
  /// cleaned.
  void clean ({double cleanProbability = 0.8}) {
    resultGrid.setForEach((coordinates, element) {
          final neighbors = resultGrid.neighbors4(coordinates);
          if (neighbors.length < 4) return element;

          final String typicalNeighbor = neighbors.first.toString();
          for (final neighbor in neighbors) {
            if (neighbor.toString() != typicalNeighbor) return element;
          }

          if (Random().nextDouble() < cleanProbability) return element;
          return neighbors.first;
        });
  }

}