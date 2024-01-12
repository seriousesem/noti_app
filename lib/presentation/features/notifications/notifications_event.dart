import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/models/notification/notification_model.dart';

sealed class NotificationsEvent extends Equatable {
  const NotificationsEvent();

  @override
  List<Object> get props => [];
}

class LoadingEvent extends NotificationsEvent {
  const LoadingEvent();
}

class FetchOneTimeNotificationsEvent extends NotificationsEvent {
  const FetchOneTimeNotificationsEvent();
}

class SwitchNotificationsTypeEvent extends NotificationsEvent {
  const SwitchNotificationsTypeEvent({required this.notificationsType});

  final String notificationsType;
}

class GoToCreateNotificationEvent extends NotificationsEvent {
  const GoToCreateNotificationEvent({required this.context});

  final BuildContext context;
}

class DeleteNotificationEvent extends NotificationsEvent {
  const DeleteNotificationEvent({required this.notification});

  final NotificationModel notification;
}

class GoToEditNotificationEvent extends NotificationsEvent {
  const GoToEditNotificationEvent(
      {required this.context, required this.notification});

  final BuildContext context;
  final NotificationModel notification;
}

class GoToRecurringNotificationsEvent extends NotificationsEvent {
  const GoToRecurringNotificationsEvent({
    required this.context,
    required this.recurringType,
  });

  final BuildContext context;
  final String recurringType;
}

