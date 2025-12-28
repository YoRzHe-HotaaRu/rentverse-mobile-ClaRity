class PropertyTypesState {
  final bool isLoading;
  final List<String> categories;
  final String? error;

  const PropertyTypesState({
    required this.isLoading,
    required this.categories,
    this.error,
  });

  factory PropertyTypesState.initial() => const PropertyTypesState(
    isLoading: false,
    categories: ['All'],
    error: null,
  );

  PropertyTypesState copyWith({
    bool? isLoading,
    List<String>? categories,
    String? error,
  }) {
    return PropertyTypesState(
      isLoading: isLoading ?? this.isLoading,
      categories: categories ?? this.categories,
      error: error,
    );
  }
}
