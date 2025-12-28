import 'package:equatable/equatable.dart';

class BannerState extends Equatable {
  final List<String> images;
  final int currentIndex;

  const BannerState({required this.images, this.currentIndex = 0});

  BannerState copyWith({List<String>? images, int? currentIndex}) {
    return BannerState(
      images: images ?? this.images,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  List<Object?> get props => [images, currentIndex];
}
