import "package:flutter/material.dart";
import "package:get/get.dart";

import "home.dart";

void main() {
  runApp(const MyApp());
}

/// The flutter app.
class MyApp extends StatelessWidget {
  
  /// Returns an instance of [MyApp] matching the given parameters.
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Map Generator",
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
