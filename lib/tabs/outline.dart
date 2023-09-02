import "package:flutter/material.dart";

import "../classes/helpers/exports.dart";

/// A tab to display a grid.
class TabOutline extends StatelessWidget {

  // VARIABLES =================================================================

  /// The grid to be displayed.
  final Grid<Widget> grid;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [TabOutline] matching the given parameters.
  const TabOutline({super.key, required this.grid,});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map outline"),
      ),
      body: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: grid.columns),
        children: grid.flatten(),
      ),
    );
  }

  // METHODS ===================================================================

}
