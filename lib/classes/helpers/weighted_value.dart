// Framework dependencies
import "dart:math";

/// An convenient abbreviation for [List<WeightedValue>].
typedef WeightedList<T> = List<WeightedValue<T>>;

/// A set of tools for [WeightedList].
extension WeightedListTools<T> on WeightedList<T> {
  
  /// The sum of all the weights in the list.
  double get totalWeight => reduce((value, next) => WeightedValue(
        value.weight + next.weight,
        value.value,
      )).weight;

  /// Picks a random value while accounting for their weight.
  T? pick() {
    if (isEmpty) return null;

    // We pick a random weight between 0 and [totalWeight].
    double randomWeight = Random().nextDouble() * totalWeight;

    // We loop on every element deducing its weight each time.
    // When the random weight is negative, then we select the element it stopped on.
    for (final element in this) {
      randomWeight -= element.weight;
      if (randomWeight <= 0 && element.weight > 0) return element.value;
    }

    throw Exception("The random value was out of bounds.\n"
        "Total weight: $totalWeight");
  }
}

/// A dataclass for storing values that have a likeliness of being chosen.
class WeightedValue<T> {
  // VARIABLES =================================================================

  /// The weighted associated with the value.
  ///
  /// The higher it is, the more likely it is to be picked.
  final double weight;

  /// The actual value.
  final T value;

  // CONSTRUCTOR ===============================================================

  /// Returns a [WeightedValue].
  const WeightedValue(this.weight, this.value);

// METHODS ===================================================================
}
