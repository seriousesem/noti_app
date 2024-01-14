import 'package:equatable/equatable.dart';

import '../../../domain/models/notification/notification_model.dart';
import '../../../domain/models/time/time_model.dart';

final class CreateOrEditNotificationsState extends Equatable {
  const CreateOrEditNotificationsState({
    this.notification,
    this.currentTime = '',
    this.timeModel = const TimeModel(),
    this.selectedIcon = '',
    this.selectedIconBackgroundColor = '',
    this.error = '',
  });

  final NotificationModel? notification;
  final String currentTime;
  final TimeModel timeModel;
  final String selectedIconBackgroundColor;
  final String selectedIcon;
  final String error;

  CreateOrEditNotificationsState copyWith({
    NotificationModel? notification,
    String? currentTime,
    TimeModel? timeModel,
    String? selectedIconBackgroundColor,
    String? selectedIcon,
    String? error,
  }) =>
      CreateOrEditNotificationsState(
        notification: notification ?? this.notification,
        currentTime: currentTime ?? this.currentTime,
        timeModel: timeModel ?? this.timeModel,
        selectedIconBackgroundColor:
            selectedIconBackgroundColor ?? this.selectedIconBackgroundColor,
        selectedIcon: selectedIcon ?? this.selectedIcon,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => [
        notification,
        currentTime,
        timeModel,
        selectedIconBackgroundColor,
        selectedIcon,
        error
      ];
}

final class CreateOrEditNotificationsStateLoading
    extends CreateOrEditNotificationsState {
  const CreateOrEditNotificationsStateLoading();
}

final class CreateOrEditNotificationsStateSuccess
    extends CreateOrEditNotificationsState {
  const CreateOrEditNotificationsStateSuccess();
}

final class CreateOrEditNotificationsStateError
    extends CreateOrEditNotificationsState {
  const CreateOrEditNotificationsStateError({required String error})
      : super(error: error);
}
