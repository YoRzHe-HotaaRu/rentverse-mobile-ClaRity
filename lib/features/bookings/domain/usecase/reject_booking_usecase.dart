import 'package:rentverse/core/usecase/usecase.dart';
import 'package:rentverse/features/bookings/domain/entity/res/booking_response_entity.dart';
import 'package:rentverse/features/bookings/domain/repository/bookings_repository.dart';

class RejectBookingUseCase implements UseCase<BookingResponseEntity, String> {
  RejectBookingUseCase(this._repository);

  final BookingsRepository _repository;

  @override
  Future<BookingResponseEntity> call({String? param}) {
    if (param == null || param.isEmpty) {
      throw ArgumentError('bookingId cannot be null or empty');
    }
    return _repository.rejectBooking(param);
  }
}
