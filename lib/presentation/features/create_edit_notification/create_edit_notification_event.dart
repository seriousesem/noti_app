import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/models/notification/notification_model.dart';

sealed class CreateOrEditNotificationEvent extends Equatable {
  const CreateOrEditNotificationEvent();

  @override
  List<Object> get props => [];
}

class LoadingEvent extends CreateOrEditNotificationEvent {
  const LoadingEvent();
}

final class InitializeStateEvent
    extends CreateOrEditNotificationEvent {
  const InitializeStateEvent({required this.notification});

  final NotificationModel notification;
}

final class FirstHourChangedEvent extends CreateOrEditNotificationEvent {
  const FirstHourChangedEvent(this.firstHour, this.context);

  final String firstHour;
  final BuildContext context;
}

final class SecondHourChangedEvent extends CreateOrEditNotificationEvent {
  const SecondHourChangedEvent(this.secondHour, this.context);

  final String secondHour;
  final BuildContext context;
}

final class FirstMinuteChangedEvent extends CreateOrEditNotificationEvent {
  const FirstMinuteChangedEvent(this.firstMinute, this.context);

  final String firstMinute;
  final BuildContext context;
}

final class SecondMinuteChangedEvent extends CreateOrEditNotificationEvent {
  const SecondMinuteChangedEvent(this.secondMinute, this.context);

  final String secondMinute;
  final BuildContext context;
}

final class MessageChangedEvent extends CreateOrEditNotificationEvent {
  const MessageChangedEvent(this.message, this.context);

  final String message;
  final BuildContext context;
}

final class IconSelectedEvent extends CreateOrEditNotificationEvent {
  const IconSelectedEvent(this.iconAssets);

  final String iconAssets;
}

final class IconBackgroundColorSelectedEvent
    extends CreateOrEditNotificationEvent {
  const IconBackgroundColorSelectedEvent(this.iconBackgroundColor);

  final String iconBackgroundColor;
}

class IconStyleSavedEvent extends CreateOrEditNotificationEvent {
  const IconStyleSavedEvent();
}

final class ConfirmedEvent extends CreateOrEditNotificationEvent {
  const ConfirmedEvent({required this.callback});
  final Function() callback;
}
