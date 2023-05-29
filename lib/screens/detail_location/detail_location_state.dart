class DetailLocationState {
  final bool showLoading;

  const DetailLocationState({
    this.showLoading = false,
  });

  DetailLocationState copyWith({
    bool? showLoading,
  }) {
    return DetailLocationState(
      showLoading: showLoading ?? this.showLoading,
    );
  }
}
