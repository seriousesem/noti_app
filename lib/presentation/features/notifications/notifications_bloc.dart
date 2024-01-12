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
    on<FetchOneTimeNotificationsEvent>(_fetchOneTimeNotifications);
    on<SwitchNotificationsTypeEvent>(_switchNotificationsType);
    on<DeleteNotificationEvent>(_deleteNotification);
    on<GoToCreateNotificationEvent>(_goToCreateNotification);
    on<GoToEditNotificationEvent>(_goToEditNotification);
    on<GoToRecurringNotificationsEvent>(_goToRecurringNotificationsEvent);
  }

  final NotificationsRepository _repository;

  _fetchOneTimeNotifications(
      NotificationsEvent event, Emitter<NotificationsState> emit) async {
    emit(const NotificationsStateLoading());
    final requestResult = await _repository.fetchAllNotifications();
    if (requestResult is RequestResultError) {
      emit(NotificationsStateError(
          error: requestResult.error ?? AppErrors.unknownError));
    }
    if (requestResult is RequestResultSuccess) {
      emit(NotificationsStateSuccess(
          oneTimeNotifications: requestResult.data ?? List.empty()));
    }
  }

  _switchNotificationsType(SwitchNotificationsTypeEvent event,
      Emitter<NotificationsState> emit) async {
    emit(state.copyWith(selectedNotificationsType: event.notificationsType));
    if (event.notificationsType == NotificationsType.oneTime) {
      add(const FetchOneTimeNotificationsEvent());
    }
  }

  _goToCreateNotification(
      GoToCreateNotificationEvent event, Emitter<NotificationsState> emit) {
    const notification = NotificationModel(
      type: NotificationsType.oneTime,
      time: '',
      message: '',
    );
    Navigator.pushNamed(
      event.context,
      AppRoutesNames.createOrEditNotificationScreen,
      arguments: notification,
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
      add(const FetchOneTimeNotificationsEvent());
    }
  }

  _goToEditNotification(
      GoToEditNotificationEvent event, Emitter<NotificationsState> emit) async {
    Navigator.pushNamed(event.context, AppRoutesNames.createOrEditNotificationScreen,
        arguments: event.notification);
  }

  _goToRecurringNotificationsEvent(GoToRecurringNotificationsEvent event,
      Emitter<NotificationsState> emit) async {}
}
