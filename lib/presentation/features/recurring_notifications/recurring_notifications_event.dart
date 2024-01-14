import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/models/notification/notification_model.dart';

sealed class RecurringNotificationsEvent extends Equatable {
  const RecurringNotificationsEvent();

  @override
  List<Object> get props => [];
}

final class InitializeRecurringNotificationsStateEvent
    extends RecurringNotificationsEvent {
  const InitializeRecurringNotificationsStateEvent({required this.recurringNotificationType});

  final String recurringNotificationType;
}

class LoadingEvent extends RecurringNotificationsEvent {
  const LoadingEvent();
}

class FetchNotificationsEvent extends RecurringNotificationsEvent {
  const FetchNotificationsEvent();
}

class GoToCreateNotificationEvent extends RecurringNotificationsEvent {
  const GoToCreateNotificationEvent({required this.context});

  final BuildContext context;
}

class DeleteNotificationEvent extends RecurringNotificationsEvent {
  const DeleteNotificationEvent({required this.notification});

  final NotificationModel notification;
}

class GoToEditNotificationEvent extends RecurringNotificationsEvent {
  const GoToEditNotificationEvent(
      {required this.context, required this.notification});

  final BuildContext context;
  final NotificationModel notification;
}

