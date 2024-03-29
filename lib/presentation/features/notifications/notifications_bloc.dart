import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:noti_app/domain/core/request_result.dart';
import 'package:noti_app/domain/models/notification/notification_model.dart';
import 'package:noti_app/domain/repository/notifications_repository.dart';
import '../../../core/navigation/app_navigation.dart';
import '../../../utils/constants.dart';
import 'notifications_event.dart';
import 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc(this._repository) : super(const NotificationsState()) {
    on<FetchNotificationsEvent>(_fetchNotifications);
    on<SwitchNotificationsTypeEvent>(_switchNotificationsType);
    on<DeleteNotificationEvent>(_deleteNotification);
    on<GoToCreateNotificationEvent>(_goToCreateNotification);
    on<GoToEditNotificationEvent>(_goToEditNotification);
    on<GoToRecurringNotificationsEvent>(_goToRecurringNotificationsEvent);
  }

  final NotificationsRepository _repository;

  _fetchNotifications(
      FetchNotificationsEvent event, Emitter<NotificationsState> emit) async {
    emit(const NotificationsStateLoading());
    final requestResult = await _repository.fetchAllNotifications();
    if (requestResult is RequestResultError) {
      emit(NotificationsStateError(
          error: requestResult.error ?? AppErrors.unknownError));
    }
    if (requestResult is RequestResultSuccess) {
      final List<NotificationModel> notifications = requestResult.data
              ?.where((notifications) =>
                  notifications.type == NotificationType.oneTime)
              .toList() ??
          List.empty();
      emit(NotificationsStateSuccess(
          notifications: notifications));
    }
  }

  _switchNotificationsType(SwitchNotificationsTypeEvent event,
      Emitter<NotificationsState> emit) async {
    emit(state.copyWith(selectedNotificationsType: event.notificationsType));
    if (event.notificationsType == NotificationType.oneTime) {
      add(const FetchNotificationsEvent());
    }
  }

  _goToCreateNotification(
      GoToCreateNotificationEvent event, Emitter<NotificationsState> emit) {
    const notification = NotificationModel(
      type: NotificationType.oneTime,
      time: '',
      message: '',
    );
    Navigator.pushNamed(
      event.context,
      AppRoutesNames.createOrEditNotificationScreen,
      arguments: {
        MapKey.notification: notification,
        MapKey.callBack: () {
          add(const FetchNotificationsEvent());
        },
      },
    );
  }

  _deleteNotification(
      DeleteNotificationEvent event, Emitter<NotificationsState> emit) async {
    final requestResult =
        await _repository.deleteNotification(event.notification);
    if (requestResult is RequestResultError) {
      emit(NotificationsStateError(
          error: requestResult.error ?? AppErrors.unknownError));
    }
    if (requestResult is RequestResultSuccess) {
      add(const FetchNotificationsEvent());
    }
  }

  _goToEditNotification(
      GoToEditNotificationEvent event, Emitter<NotificationsState> emit) async {
    Navigator.pushNamed(
        event.context, AppRoutesNames.createOrEditNotificationScreen,
        arguments: {
          MapKey.notification: event.notification,
          MapKey.callBack: () {
            add(const FetchNotificationsEvent());
          },
        });
  }

  _goToRecurringNotificationsEvent(GoToRecurringNotificationsEvent event,
      Emitter<NotificationsState> emit) {
    Navigator.pushNamed(event.context, AppRoutesNames.recurringNotificationsScreen, arguments: event.recurringType);
  }
}
