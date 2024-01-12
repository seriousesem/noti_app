import 'package:equatable/equatable.dart';

import '../../../domain/models/notification/notification_model.dart';
import '../../../utils/constants.dart';

final class NotificationsState extends Equatable {
  const NotificationsState({
    this.selectedNotificationsType = NotificationsType.oneTime,
    this.oneTimeNotifications,
    this.error,
  });

  final String selectedNotificationsType;
  final List<NotificationModel>? oneTimeNotifications;
  final String? error;

  NotificationsState copyWith({
    String? selectedNotificationsType,
    List<NotificationModel>? oneTimeNotifications,
    String? error,
  }) =>
      NotificationsState(
        selectedNotificationsType:
            selectedNotificationsType ?? this.selectedNotificationsType,
        oneTimeNotifications: oneTimeNotifications ?? this.oneTimeNotifications,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props =>
      [selectedNotificationsType, oneTimeNotifications, error];
}

final class NotificationsStateLoading extends NotificationsState {
  const NotificationsStateLoading();
}

final class NotificationsStateSuccess extends NotificationsState {
  const NotificationsStateSuccess(
      {required List<NotificationModel> oneTimeNotifications})
      : super(oneTimeNotifications: oneTimeNotifications);
}

final class NotificationsStateError extends NotificationsState {
  const NotificationsStateError({required String error}) : super(error: error);
}
