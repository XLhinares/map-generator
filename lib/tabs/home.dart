import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../utils/grid_controller.dart";
import "grid.dart";
import "outline.dart";

/// The main tab of the app.
class Home extends StatelessWidget {
  // VARIABLES =================================================================

  /// A controller handling the grid generation.
  final GridController controller;


  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [Home] matching the given parameters.
  Home({
    super.key,
  }) :
      controller = Get.put(GridController(size: 60));
  

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map Generator"),
        actions: _actionButtons,
      ),
      body: GridDisplay(
        controller: controller,
      )
    );
  }

  // WIDGETS ===================================================================

  List<Widget> get _actionButtons => [
    IconButton(
      onPressed: _reset,
      icon: const Icon(Icons.loop),
    ),
    IconButton(
      onPressed: _iterate,
      icon: const Icon(Icons.play_arrow),
    ),
    IconButton(
      onPressed: _generate,
      icon: const Icon(Icons.fast_forward),
    ),
    IconButton(
      onPressed: _outline,
      icon: const Icon(Icons.gesture),
    ),
    XLayout.horizontalM,
  ];

  // METHODS ===================================================================

  void _iterate () {
    // print("iterated");
    if (controller.done) {
      print("done");
      return;
    }
    controller.iterate();
    Future.delayed(const Duration(milliseconds: 5), () => _iterate(),);
    // _iterate();
  }

  void _generate () {
    if (controller.done) controller.reset();
    controller.generate();
  }

  void _reset () {
    controller.reset();
  }

  void _outline () {
    Get.to(() => TabOutline(grid: controller.outline()));
  }
}
