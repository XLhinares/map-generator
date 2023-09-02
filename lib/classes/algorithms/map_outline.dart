import "package:flutter/material.dart";

import "../../utils/globals.dart";
import "../helpers/exports.dart";
import "../tiles/tile.dart";


/// An extension on the wave collapse algorithm that provides a method to turn
/// the result grid into an outline grid.
extension MapOutline on Grid<Tile> {

  /// Returns a grid using outline tiles based on the result grid.
  Grid<Widget> outline () {

    const Color landEmpty = Color(0xFFE5DCD3);
    const Color landOutline = Colors.black54;

    Grid<Widget> result = map((coordinates, element) {

      if (element.toString() != TileGround.id) {
        return const ColoredBox(
          color: Color(0xFFaa9c8f),
          child: SizedBox(
          width: cellSize,
          height: cellSize,
      ),
        );
      }

      final nonGroundNeighbor = neighbors4(coordinates)
          .where((element) => element.toString() == TileWater.id);

      final topIsGround = atOrNull(coordinates.top)?.toString() != TileWater.id;
      final bottomIsGround = atOrNull(coordinates.bottom)?.toString() != TileWater.id;
      final leftIsGround = atOrNull(coordinates.left)?.toString() != TileWater.id;
      final rightIsGround = atOrNull(coordinates.right)?.toString() != TileWater.id;

      // final topLeftIsGround = atOrNull(coordinates.topLeft)?.toString() != TileWater.id;
      // final topRightIsGround = atOrNull(coordinates.topRight)?.toString() != TileWater.id;
      // final bottomLeftIsGround = atOrNull(coordinates.bottomLeft)?.toString() != TileWater.id;
      // final bottomRightIsGround = atOrNull(coordinates.bottomRight)?.toString() != TileWater.id;

      // final isExtremityBottom = nonGroundNeighbor.length == 3 && hasTopNonGroundNeighbor;
      // final isExtremityTop = nonGroundNeighbor.length == 3 && hasBottomNonGroundNeighbor;
      // final isExtremityRight = nonGroundNeighbor.length == 3 && hasLeftNonGroundNeighbor;
      // final isExtremityLeft = nonGroundNeighbor.length == 3 && hasRightNonGroundNeighbor;

      final Widget container = Container(
        width: cellSize,
        height: cellSize,
        decoration: BoxDecoration(
          color: nonGroundNeighbor.isEmpty
            ? landEmpty
            : landOutline,
          // border: Border(
          //     top: topIsGround ? BorderSide.none : const BorderSide(width: 5, color: landOutline),
          //     bottom: bottomIsGround ? BorderSide.none : const BorderSide(width: 5, color: landOutline),
          //     left: leftIsGround ? BorderSide.none : const BorderSide(width: 5, color: landOutline),
          //     right: rightIsGround ? BorderSide.none : const BorderSide(width: 5, color: landOutline),
          // ),
          borderRadius: BorderRadius.only(
            topLeft: topIsGround || leftIsGround ? Radius.zero : const Radius.circular(cellSize),
            topRight: topIsGround || rightIsGround ? Radius.zero : const Radius.circular(cellSize),
            bottomLeft: bottomIsGround || leftIsGround ? Radius.zero : const Radius.circular(cellSize),
            bottomRight: bottomIsGround || rightIsGround ? Radius.zero : const Radius.circular(cellSize),
          )
        ),
      );

      return container;
    });

    return result;
  }

}