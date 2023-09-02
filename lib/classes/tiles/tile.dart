import "package:flutter/material.dart";

/// In-app representation of a tile
abstract class Tile {
  /// The class ID.
  static const id = "tile";

  /// The color of the tile when displayed.
  abstract final Color color;
}

/// A tile representing ground.
class TileGround extends Tile {
  /// The class ID.
  static const id = "ground";

  @override
  String toString() => TileGround.id;

  @override
  final Color color = Colors.brown;
}

/// A tile representing trees.
class TileTree extends Tile {
  /// The class ID.
  static const id = "tree";

  @override
  String toString() => TileGround.id;

  @override
  final Color color = Colors.green;
}

/// A tile representing water.
class TileWater extends Tile {
  /// The class ID.
  static const id = "water";

  @override
  String toString() => TileWater.id;

  @override
  final Color color = Colors.blue;
}

/// A tile representing outline.
class TileOutline extends Tile {
  /// The class ID.
  static const id = "outline";

  @override
  String toString() => TileOutline.id;

  @override
  final Color color = Colors.black54;
}

/// A tile representing continuous space.
///
/// This clearer version is used for land areas.
class TileEmptyClear extends Tile {
  /// The class ID.
  static const id = "empty";

  @override
  String toString() => TileEmpty.id;

  @override
  final Color color = const Color(0xFFE5DCD3);
}

/// A tile representing continuous space.
///
/// This clearer version is used for water areas.
class TileEmpty extends Tile {
  /// The class ID.
  static const id = "empty";

  @override
  String toString() => TileEmpty.id;

  @override
  final Color color = const Color(0xFFaa9c8f);
}