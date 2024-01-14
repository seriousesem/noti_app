import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:noti_app/domain/core/request_result.dart';
import 'package:noti_app/domain/models/notification/notification_model.dart';
import 'package:noti_app/domain/repository/notifications_repository.dart';
import '../../../core/navigation/app_navigation.dart';
import '../../../utils/constants.dart';
import 'recurring_notifications_event.dart';
import 'recurring_notifications_state.dart';

class RecurringNotificationsBloc
    extends Bloc<RecurringNotificationsEvent, RecurringNotificationsState> {
  RecurringNotificationsBloc(this._repository)
      : super(const RecurringNotificationsState(recurringNotificationType: '')) {
    on<InitializeRecurringNotificationsStateEvent>(_initializeState);
    on<FetchNotificationsEvent>(_fetchNotifications);
    on<DeleteNotificationEvent>(_deleteNotification);
    on<GoToCreateNotificationEvent>(_goToCreateNotification);
    on<GoToEditNotificationEvent>(_goToEditNotification);
  }

  final NotificationsRepository _repository;

  _initializeState(InitializeRecurringNotificationsStateEvent event,
      Emitter<RecurringNotificationsState> emit) async {
    emit(state.copyWith(
        recurringNotificationType: event.recurringNotificationType));
    add(const FetchNotificationsEvent());
  }

  _fetchNotifications(FetchNotificationsEvent event,
      Emitter<RecurringNotificationsState> emit) async {
    emit(RecurringNotificationsStateLoading(
        recurringNotificationType: state.recurringNotificationType));
    final requestResult = await _repository.fetchAllNotifications();
    if (requestResult is RequestResultError) {
      emit(RecurringNotificationsStateError(
        recurringNotificationType: state.recurringNotificationType,
        error: requestResult.error ?? AppErrors.unknownError,
      ));
    }
    if (requestResult is RequestResultSuccess) {
      final List<NotificationModel> notifications = requestResult.data
              ?.where((notifications) =>
                  notifications.recurringNotificationType ==
                  state.recurringNotificationType)
              .toList() ??
          List.empty();
      emit(RecurringNotificationsStateSuccess(
          recurringNotificationType: state.recurringNotificationType,
          notifications: notifications));
    }
  }

  _goToCreateNotification(GoToCreateNotificationEvent event,
      Emitter<RecurringNotificationsState> emit) {
    final notification = NotificationModel(
      type: NotificationType.recurring,
      recurringNotificationType: state.recurringNotificationType,
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

  _deleteNotification(DeleteNotificationEvent event,
      Emitter<RecurringNotificationsState> emit) async {
    final requestResult =
        await _repository.deleteNotification(event.notification);
    if (requestResult is RequestResultError) {
      emit(RecurringNotificationsStateError(
          recurringNotificationType: state.recurringNotificationType,
          error: requestResult.error ?? AppErrors.unknownError));
    }
    if (requestResult is RequestResultSuccess) {
      add(const FetchNotificationsEvent());
    }
  }

  _goToEditNotification(GoToEditNotificationEvent event,
      Emitter<RecurringNotificationsState> emit) async {
    Navigator.pushNamed(
        event.context, AppRoutesNames.createOrEditNotificationScreen,
        arguments: {
          MapKey.notification: event.notification,
          MapKey.callBack: () {
            add(const FetchNotificationsEvent());
          },
        });
  }
}
