import "dart:math";

import "package:flutter/material.dart";
import "package:get/get.dart";
import "../classes/tiles/tile.dart";

import "../classes/algorithms/exports.dart";
import "../classes/helpers/exports.dart";

/// A controller handling the algorithm generating the grid.
///
/// It extends [GetxController] in order to be able to update the widgets
/// displaying it.
class GridController extends GetxController {
  // VARIABLES =================================================================

  /// The number of rows in the grid.
  final int rows;

  /// The number of columns in the grid.
  final int columns;

  /// The algorithm generating the grid.
  late final WaveCollapseAlgorithm<Tile> algorithm;

  // GETTERS ===================================================================

  /// Whether the algorithm is done running.
  bool get done => algorithm.collapsed;

  /// The grid resulting from the algorithm.
  ///
  /// It is possible to access it while the algorithm is still running.
  /// This means some cells might be null.
  Grid<Tile?> get grid => algorithm.resultGrid;

  // CONSTRUCTOR ===============================================================
///
  GridController({
    int size = 20,
  }) :
        rows = size,
        columns = size
  {


    algorithm = WaveCollapseAlgorithm<Tile>(
      initialGrid: _generateInitialGrid(),
      options: [
        CollapseOption(
            builder: () => TileGround(),
            id: TileGround.id,
            weight: 1.3),
        CollapseOption(
            builder: () => TileTree(),
            id: TileTree.id,
            weight: 0.1),
        CollapseOption(
            builder: () => TileWater(),
            id: TileWater.id,
            weight: 0.8),
      ],
      constraints: WaveCollapseConstraints(
          columns: columns,
          rows: rows,
          onPlaceEffects: {
            TileGround.id: [
              WaveCollapseEffect(
                pattern: RangePattern.circular(rangeMax: 4),
                setWeight: (coordinates, optionID, weight) {
                  switch (optionID) {
                    case TileGround.id:
                      return weight * (1 + .08 / coordinates.distanceFromOrigin());
                    case TileTree.id:
                      return weight * (1 + .005 / coordinates.distanceFromOrigin());
                    case TileWater.id:
                      return weight * (1 - 0.8 / coordinates.distanceFromOrigin());
                    default:
                      return weight;
                  }
                },
              ),
            ],
            TileTree.id: [
              WaveCollapseEffect(
                pattern: RangePattern.circular(rangeMax: 3),
                setWeight: (coordinates, optionID, weight) {
                  switch (optionID) {
                    case TileGround.id:
                      return weight * (1 + .04 / coordinates.distanceFromOrigin());
                    case TileTree.id:
                      return weight * (1 + .8 / coordinates.distanceFromOrigin());
                    case TileWater.id:
                      return weight * (.5 - .49 / coordinates.distanceFromOrigin());
                    default:
                      return weight;
                  }
                },
              ),
            ],
            TileWater.id: [
              WaveCollapseEffect(
                pattern: RangePattern.circular(rangeMax: 5),
                setWeight: (coordinates, optionID, weight) {
                  switch (optionID) {
                    case TileGround.id:
                      return weight * (1 - 0.7 / coordinates.distanceFromOrigin());
                    case TileTree.id:
                      return weight * (1 - 1 / coordinates.distanceFromOrigin());
                    case TileWater.id:
                      return weight * (1 + .15 / coordinates.distanceFromOrigin());
                    default:
                      return weight;
                  }
                },
              ),
            ],
          }),
    );
  }

  // METHODS ===================================================================

  Grid<String?> _generateInitialGrid () {
    Grid<String?> result = Grid.generate(rows, columns, (coordinates) {
      if (coordinates.row == 0 || coordinates.row == rows - 1) return TileWater.id;
      if (coordinates.column == 0 || coordinates.column == columns - 1) return TileWater.id;
      return null;
    });
    Random random = Random();

    for (int i = 0; i < 10; i++) {
      result.set(
        Coordinates(random.nextInt(rows), random.nextInt(columns)),
        random.nextDouble() <= 0.2 ? TileGround.id : TileWater.id,
      );
    }
    return result;
  }

  /// Runs one iteration of the algorithm.
  ///
  /// The view is then updated.
  void iterate() {
    algorithm.iterate();
    update();
  }

  /// Fully completes the algorithm.
  ///
  /// The view is then updated.
  void generate() {
    algorithm.generate();
    algorithm.clean();
    update();
  }

  /// Reset the algorithm with a new grid.
  void reset () {
    algorithm.reset(initialGrid: _generateInitialGrid());
    update();
  }

  /// Returns a widget grip representing the outline of the algorithm result.
  ///
  /// This completes the algorithm first because the outline method only works
  /// on non-null tile grids.
  Grid<Widget> outline() {
    algorithm.generate();
    algorithm.clean();
    return Grid<Tile>
      .generate(rows, columns, (coordinates) => grid.at(coordinates)!)
      .outline();
  }
}