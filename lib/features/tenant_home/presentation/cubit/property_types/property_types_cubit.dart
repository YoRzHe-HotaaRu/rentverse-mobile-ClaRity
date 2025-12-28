import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentverse/features/rental/domain/usecase/get_rent_references_usecase.dart';
import 'property_types_state.dart';

class PropertyTypesCubit extends Cubit<PropertyTypesState> {
  PropertyTypesCubit(this._getRentReferencesUseCase)
    : super(PropertyTypesState.initial());

  final GetRentReferencesUseCase _getRentReferencesUseCase;

  Future<void> fetch() async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final res = await _getRentReferencesUseCase();
      final labels = res.propertyTypes.map((e) => e.label).toList();
      final categories = ['All', ...labels];
      emit(
        state.copyWith(isLoading: false, categories: categories, error: null),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
