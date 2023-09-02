import "dart:math";

import "package:flutter/foundation.dart";

import "coordinates.dart";

/// An object representing a 2D matrix.
///
/// It was initially an extension of [List<List<T>>]; however this caused
/// instantiation issues as extensions can't declare constructors.
class Grid<T> {
  // GETTERS ===================================================================

  /// The actual grid object
  @protected
  final List<List<T>> grid;

  /// The number of element in that grid.
  ///
  /// Assuming the grid is rectangular, it can be represented as rows.
  int get rows => grid.length;

  /// The number of elements in the first row.
  ///
  /// Assuming the grid is rectangular, it can be represented as columns.
  int get columns => grid.first.length;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [Grid] based on the provided [List<List<T>>].
  Grid(
    List<List<T>> original,
  ) : grid = original;

  /// Create a copy of a grid.
  ///
  /// Warning: the content of the cells are not deep-copied.
  factory Grid.from(Grid<T> grid) => Grid(grid.toList());

  /// Returns a rectangular grid of dimensions rows * columns, with each cell
  /// populated according to the generator function.
  factory Grid.generate(
    int rows,
    int columns,
    T Function(Coordinates coordinates) generator,
  ) =>
      Grid(List.generate(
        rows,
        (r) => List<T>.generate(
          columns,
          (c) => generator(Coordinates(r, c)),
        ),
      ));

  // OPERATORS =================================================================

  /// The [] operator giving access to the rows.
  List<T> operator [](int index) {
    return grid[index];
  }

  /// Returns the content of the cell at the given coordinates.
  ///
  /// If the coordinates are not accessible, an error is thrown.
  T at(Coordinates coordinates) {
    assert(isInGrid(coordinates),
        "The target coordinates is not within the grid.");
    return this[coordinates.row][coordinates.column];
  }

  /// Returns the content of the cell at the given coordinates.
  ///
  /// If the coordinates are not accessible, [null] is returned.
  T? atOrNull(Coordinates coordinates) =>
      isInGrid(coordinates) ? this[coordinates.row][coordinates.column] : null;

  /// Returns the content of the cell at the given index if all the rows were chained.
  ///
  /// If the coordinates are not accessible, [null] is returned.
  T? atIndex (int index) {
    final row = index ~/ columns;
    final column = index % columns;
    final coordinates = Coordinates(row, column);

    if (isNotInGrid(coordinates)) print("r: $row & c: $column");
    return at(coordinates);
  }

  /// Set the content of the cell at the given coordinates to the given value.
  void set(Coordinates coordinates, T value) =>
      grid[coordinates.row][coordinates.column] = value;

  // METHODS ===================================================================

  /// Returns a [List<List<T>>] object matching the contents of the grid.
  List<List<T>> toList() => List.generate(rows, (row) => List.from(grid[row]));

  /// Returns a list with all the cells queued.
  List<T> flatten() {
    final result = <T>[];
    for (final row in grid) {
      result.addAll(row);
    }
    return result;
  }

  /// Whether the given coordinates are inside the grid.
  bool isInGrid(Coordinates coordinates) {
    if (coordinates.row < 0) return false;
    if (coordinates.row >= rows) return false;
    if (coordinates.column < 0) return false;
    if (coordinates.column >= this[coordinates.row].length) return false;
    return true;
  }

  /// Whether the given coordinates are NOT inside the grid.
  bool isNotInGrid(Coordinates coordinates) => !isInGrid(coordinates);

  /// Modifies each cell from the grid according to the given function.
  Grid<S> map<S>(S Function(Coordinates coordinates, T e) mapper)
  => Grid.generate(rows, columns, (coordinates) => mapper(coordinates, at(coordinates)));

  /// Returns the list of coordinates where the content of the cell match the given test.
  List<Coordinates> coordinatesWhere(bool Function(T e) test) {
    final List<Coordinates> result = [];
    for (int row = 0; row < rows; row++) {
      for (int column = 0; column < this[row].length; column++) {
        if (test(this[row][column])) result.add(Point(row, column));
      }
    }

    return result;
  }
  
  void _addValueToListIfInGrid(List list, Coordinates coordinates) {
    if (!isInGrid(coordinates)) return;
    list.add(at(coordinates));
  }
  
  void _addCoordinatesToListIfInGrid(List list, Coordinates coordinates) {
    if (!isInGrid(coordinates)) return;
    list.add(coordinates);
  }

  /// Returns the values of the direct lateral neighbors of the cell at the given coordinates.
  List<T> neighbors4(Coordinates coordinates) {
    final List<T> result = [];

    _addValueToListIfInGrid(result, coordinates.left);
    _addValueToListIfInGrid(result, coordinates.right);
    _addValueToListIfInGrid(result, coordinates.top);
    _addValueToListIfInGrid(result, coordinates.bottom);

    return result;
  }

  /// Returns the value of the direct lateral and diagonal neighbors of the cell at the given coordinates.
  List<T> neighbors8(Coordinates coordinates) {
    final List<T> result = [];

    _addValueToListIfInGrid(result, coordinates.left);
    _addValueToListIfInGrid(result, coordinates.right);
    _addValueToListIfInGrid(result, coordinates.top);
    _addValueToListIfInGrid(result, coordinates.bottom);
    _addValueToListIfInGrid(result, coordinates.topLeft);
    _addValueToListIfInGrid(result, coordinates.topRight);
    _addValueToListIfInGrid(result, coordinates.bottomLeft);
    _addValueToListIfInGrid(result, coordinates.bottomRight);

    return result;
  }

  /// Returns the coordinates of the direct lateral neighbors of the cell at the given coordinates.
  List<Coordinates> neighbors4Coordinates(Coordinates coordinates) {
    final List<Coordinates> result = [];

    _addCoordinatesToListIfInGrid(result, coordinates.left);
    _addCoordinatesToListIfInGrid(result, coordinates.right);
    _addCoordinatesToListIfInGrid(result, coordinates.top);
    _addCoordinatesToListIfInGrid(result, coordinates.bottom);

    return result;
  }

  /// Returns the coordinates of the direct lateral and diagonal neighbors of the cell at the given coordinates.
  List<Coordinates> neighbors8Coordinates(Coordinates coordinates) {
    final List<Coordinates> result = [];

    _addCoordinatesToListIfInGrid(result, coordinates.left);
    _addCoordinatesToListIfInGrid(result, coordinates.right);
    _addCoordinatesToListIfInGrid(result, coordinates.top);
    _addCoordinatesToListIfInGrid(result, coordinates.bottom);
    _addCoordinatesToListIfInGrid(result, coordinates.topLeft);
    _addCoordinatesToListIfInGrid(result, coordinates.topRight);
    _addCoordinatesToListIfInGrid(result, coordinates.bottomLeft);
    _addCoordinatesToListIfInGrid(result, coordinates.bottomRight);

    return result;
  }

  /// Loops over each cell of the grid and execute the provided function.
  void forEach(void Function(Coordinates coordinates, T element) mapper) {
    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < this[r].length; c++) {
        mapper(Coordinates(r, c), this[r][c]);
      }
    }
  }

  /// Loops over each cell of the grid and set their values to the one returned by the provided function.
  void setForEach(T Function(Coordinates coordinates, T element) mapper) {
    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < this[r].length; c++) {
        this[r][c] = mapper(Coordinates(r, c), this[r][c]);
      }
    }
  }
}
