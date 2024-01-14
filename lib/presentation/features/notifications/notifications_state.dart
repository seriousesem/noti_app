import 'package:equatable/equatable.dart';

import '../../../domain/models/notification/notification_model.dart';
import '../../../utils/constants.dart';

final class NotificationsState extends Equatable {
  const NotificationsState({
    this.selectedNotificationsType = NotificationType.oneTime,
    this.notifications,
    this.error,
  });

  final String selectedNotificationsType;
  final List<NotificationModel>? notifications;
  final String? error;

  NotificationsState copyWith({
    String? selectedNotificationsType,
    List<NotificationModel>? notifications,
    String? error,
  }) =>
      NotificationsState(
        selectedNotificationsType:
            selectedNotificationsType ?? this.selectedNotificationsType,
        notifications: notifications ?? this.notifications,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props =>
      [selectedNotificationsType, notifications, error];
}

final class NotificationsStateLoading extends NotificationsState {
  const NotificationsStateLoading();
}

final class NotificationsStateSuccess extends NotificationsState {
  const NotificationsStateSuccess(
      {required List<NotificationModel> notifications})
      : super(notifications: notifications);
}

final class NotificationsStateError extends NotificationsState {
  const NotificationsStateError({required String error}) : super(error: error);
}
