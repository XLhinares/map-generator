import "weighted_value.dart";

///
class ProbaHelper {
  /// Short for [randomWeightedIndex]: Picks an index from the list at random.
  ///
  /// - The weights provided proportionally increase the likeliness of the
  /// matching index to be selected. For instance, with [0.1, 0.9], the
  /// function has 10% chance of returning 0 and 90% of returning 1.
  /// - The offset is substracted from the chosen index, to make it easy to
  /// return negative numbers. For instance `rwi([_,_,_,_], offset = 2)` will
  /// return a value between -2 and 1.
  static int rwi(List<double> weights, {int offset = 0}) {
    final WeightedList<int> weightedList = [];
    for (int i = 0; i < weights.length; i++) {
      weightedList.add(WeightedValue(weights[i], i - offset));
    }
    return weightedList.pick() ?? offset;
  }
}
