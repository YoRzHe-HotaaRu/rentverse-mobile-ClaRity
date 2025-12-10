import 'package:equatable/equatable.dart';
import 'package:rentverse/features/bookings/domain/entity/res/booking_list_entity.dart';

enum LandlordBookingRequestStatus { initial, loading, success, failure }

class LandlordBookingRequestState extends Equatable {
  final LandlordBookingRequestStatus status;
  final List<BookingListItemEntity> requests;
  final List<BookingListItemEntity> pendingPayments;
  final List<BookingListItemEntity> paidPayments;
  final List<BookingListItemEntity> confirmed;
  final List<BookingListItemEntity> rejected;
  final bool isActionLoading;
  final String? actionBookingId;
  final String? error;

  const LandlordBookingRequestState({
    this.status = LandlordBookingRequestStatus.initial,
    this.requests = const [],
    this.pendingPayments = const [],
    this.paidPayments = const [],
    this.confirmed = const [],
    this.rejected = const [],
    this.isActionLoading = false,
    this.actionBookingId,
    this.error,
  });

  LandlordBookingRequestState copyWith({
    LandlordBookingRequestStatus? status,
    List<BookingListItemEntity>? requests,
    List<BookingListItemEntity>? pendingPayments,
    List<BookingListItemEntity>? paidPayments,
    List<BookingListItemEntity>? confirmed,
    List<BookingListItemEntity>? rejected,
    bool? isActionLoading,
    String? actionBookingId,
    String? error,
  }) {
    return LandlordBookingRequestState(
      status: status ?? this.status,
      requests: requests ?? this.requests,
      pendingPayments: pendingPayments ?? this.pendingPayments,
      paidPayments: paidPayments ?? this.paidPayments,
      confirmed: confirmed ?? this.confirmed,
      rejected: rejected ?? this.rejected,
      isActionLoading: isActionLoading ?? this.isActionLoading,
      actionBookingId: actionBookingId ?? this.actionBookingId,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
    status,
    requests,
    pendingPayments,
    paidPayments,
    confirmed,
    rejected,
    isActionLoading,
    actionBookingId,
    error,
  ];
}
