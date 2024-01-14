import 'package:equatable/equatable.dart';
import '../../../domain/models/notification/notification_model.dart';

final class RecurringNotificationsState extends Equatable {
  const RecurringNotificationsState({
    required this.recurringNotificationType,
    this.notifications,
    this.error = '',
  });

  final String recurringNotificationType;
  final List<NotificationModel>? notifications;
  final String? error;

  RecurringNotificationsState copyWith({
    String? recurringNotificationType,
    List<NotificationModel>? notifications,
    String? error,
  }) =>
      RecurringNotificationsState(
        recurringNotificationType:
            recurringNotificationType ?? this.recurringNotificationType,
        notifications: notifications ?? this.notifications,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => [recurringNotificationType, notifications, error];
}

final class RecurringNotificationsStateLoading
    extends RecurringNotificationsState {
  const RecurringNotificationsStateLoading({required String recurringNotificationType})
      : super(recurringNotificationType: recurringNotificationType);
}

final class RecurringNotificationsStateSuccess
    extends RecurringNotificationsState {
  const RecurringNotificationsStateSuccess(
      {required String recurringNotificationType,
      required List<NotificationModel> notifications})
      : super(
            recurringNotificationType: recurringNotificationType,
            notifications: notifications);
}

final class RecurringNotificationsStateError
    extends RecurringNotificationsState {
  const RecurringNotificationsStateError(
      {required String recurringNotificationType, required String error})
      : super(
            recurringNotificationType: recurringNotificationType, error: error);
}
