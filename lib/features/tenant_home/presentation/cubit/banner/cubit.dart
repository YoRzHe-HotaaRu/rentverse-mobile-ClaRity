import 'package:flutter_bloc/flutter_bloc.dart';

import 'state.dart';

class BannerCubit extends Cubit<BannerState> {
  BannerCubit()
    : super(
        const BannerState(
          images: [
            'assets/banner.png',
            'assets/banner1.png',
            'assets/banner2.png',
          ],
        ),
      );

  void onPageChanged(int index) {
    emit(state.copyWith(currentIndex: index));
  }
}
