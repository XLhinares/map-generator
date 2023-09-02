import "package:flutter/material.dart";
import "package:get/get.dart";

import "../utils/grid_controller.dart";
import "../utils/globals.dart";

/// A widget to display the grid from the controller.
class GridDisplay extends StatelessWidget {

  // VARIABLES =================================================================

  /// The controller handling the generated grid.
  final GridController controller;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [GridDisplay] matching the given parameters.
  const GridDisplay({
    super.key,
    required this.controller,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: controller,
        builder: (_) {
          return GridView.builder(
            itemCount: controller.rows * controller.columns,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: controller.rows),
            itemBuilder: (context, index) => ColoredBox(
              color: controller.grid.atIndex(index)?.color ?? Colors.grey,
              child: const SizedBox(
                width: cellSize,
                height: cellSize,
              ),
            ),
          );
        }
    );
  }

  // METHODS ===================================================================

}
