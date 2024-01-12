import 'package:equatable/equatable.dart';

import '../../../domain/models/notification/notification_model.dart';
import '../../../domain/models/time/time_model.dart';

final class CreateOrEditNotificationsState extends Equatable {
  const CreateOrEditNotificationsState({
    this.notification ,
    this.notificationId,
    this.currentTime = '',
    this.timeModel = const TimeModel(),
    this.error = '',
  });

  final NotificationModel? notification;
  final int? notificationId;
  final String currentTime;
  final TimeModel timeModel;
  final String error;

  CreateOrEditNotificationsState copyWith({
    NotificationModel? notification,
    int? notificationId,
    String? currentTime,
    TimeModel? timeModel,
    String? error,
  }) =>
      CreateOrEditNotificationsState(
        notification: notification ?? this.notification,
        notificationId: notificationId ?? this.notificationId,
        currentTime: currentTime ?? this.currentTime,
        timeModel: timeModel ?? this.timeModel,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props =>
      [notification, notificationId, currentTime, timeModel, error];
}

final class CreateOrEditNotificationsStateLoading extends CreateOrEditNotificationsState {
  const CreateOrEditNotificationsStateLoading();
}

final class CreateOrEditNotificationsStateSuccess extends CreateOrEditNotificationsState {
  const CreateOrEditNotificationsStateSuccess({required int notificationId})
      : super(notificationId: notificationId);
}

final class CreateOrEditNotificationsStateError extends CreateOrEditNotificationsState {
  const CreateOrEditNotificationsStateError({required String error})
      : super(error: error);
}