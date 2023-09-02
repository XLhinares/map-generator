/// An option in the [WaveCollapseGrid]
class CollapseOption<T> {
  // VARIABLES =================================================================

  /// The generator for the option.
  ///
  /// It is called once the option has been selected to be placed.
  final T Function() builder;

  /// The identifier of the option.
  ///
  /// It is used to
  final String id;

  /// The initial weight of the option
  final double weight;

  // GETTERS ===================================================================
  //
  // T? get value {
  //   if (content == null) return null;
  //   content!["generator_type"] = type;
  //   return Entity.fromJson(T, content!) as T;
  // }

  // CONSTRUCTOR ===============================================================

  /// Returns a [CollapseOption] matching the given parameters.
  CollapseOption({
    required this.builder,
    required this.id,
    required this.weight,
  });
}
