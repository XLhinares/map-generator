import "../helpers/exports.dart";

/// A class implementing the effect from placing a tile during the WCA.
class WaveCollapseEffect<T> {
  
  /// The pattern of affected tiles.
  final RangePattern pattern;
  
  /// A function that returns the new weight of a cell based on it's coordinates, its ID and its current weight.
  /// 
  /// It is recommended to make change the weight by a factor, rather than adding/subtracting a value as it would disrupt previous changes. 
  final double? Function(Coordinates coordinates, String optionID, double currentWeight) setWeight;

  /// Returns an instance of [WaveCollapseEffect] matching the given parameters.
  WaveCollapseEffect({
    required this.pattern,
    required this.setWeight,
  });
}
