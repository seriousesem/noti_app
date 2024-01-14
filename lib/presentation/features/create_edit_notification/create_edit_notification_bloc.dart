import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:noti_app/domain/core/request_result.dart';
import '../../../domain/models/notification/notification_model.dart';
import '../../../domain/models/time/time_model.dart';
import '../../../domain/repository/notifications_repository.dart';
import '../../../utils/constants.dart';
import 'create_edit_notification_event.dart';
import 'create_edit_notification_state.dart';

class CreateOrEditNotificationBloc extends Bloc<CreateOrEditNotificationEvent,
    CreateOrEditNotificationsState> {
  CreateOrEditNotificationBloc(this._repository)
      : super(const CreateOrEditNotificationsState()) {
    on<InitializeStateEvent>(_initializeLoginState);
    on<FirstHourChangedEvent>(_changeFirstHour);
    on<SecondHourChangedEvent>(_changeSecondHour);
    on<FirstMinuteChangedEvent>(_changeFirstMinute);
    on<SecondMinuteChangedEvent>(_changeSecondMinute);
    on<MessageChangedEvent>(_changeMessage);
    on<IconSelectedEvent>(_selectIcon);
    on<IconBackgroundColorSelectedEvent>(_selectIconBackgroundColor);
    on<IconStyleSavedEvent>(_saveIconStyle);
    on<ConfirmedEvent>(_confirm);
  }

  final NotificationsRepository _repository;

  _initializeLoginState(InitializeStateEvent event,
      Emitter<CreateOrEditNotificationsState> emit) async {
    final currentDateTime = DateTime.now();
    final currentTime = DateFormat('HH:mm').format(currentDateTime);
    final timeModel = event.notification.time;
    emit(state.copyWith(
        currentTime: currentTime,
        notification: event.notification,
        timeModel: timeModel.isNotEmpty
            ? TimeModel.fromString(timeModel).copyWith(
                secondHourFocusNode: FocusNode(),
                firstMinuteFocusNode: FocusNode(),
                secondMinuteFocusNode: FocusNode(),
              )
            : TimeModel(
                secondHourFocusNode: FocusNode(),
                firstMinuteFocusNode: FocusNode(),
                secondMinuteFocusNode: FocusNode(),
              )));
  }

  _changeFirstHour(FirstHourChangedEvent event,
      Emitter<CreateOrEditNotificationsState> emit) {
    final timeModel = state.timeModel.copyWith(
      firstHour: event.firstHour,
    );
    emit(state.copyWith(
      timeModel: timeModel,
    ));
    _checkFirstHourCorrectness(emit);
    if (state.timeModel.firstHour.isNotEmpty && state.error.isEmpty) {
      _changeFocusNode(
          context: event.context,
          focusNode: state.timeModel.secondHourFocusNode);
    }
    if (state.timeModel.firstHour.isNotEmpty && state.error.isNotEmpty) {
      FocusScope.of(event.context).unfocus();
    }
  }

  _changeSecondHour(SecondHourChangedEvent event,
      Emitter<CreateOrEditNotificationsState> emit) {
    final timeModel = state.timeModel.copyWith(secondHour: event.secondHour);
    emit(state.copyWith(
      timeModel: timeModel,
    ));
    _checkSecondHourCorrectness(emit);
    if (state.timeModel.secondHour.isNotEmpty && state.error.isEmpty) {
      _changeFocusNode(
          context: event.context,
          focusNode: state.timeModel.firstMinuteFocusNode);
    }
    if (state.timeModel.secondHour.isNotEmpty && state.error.isNotEmpty) {
      FocusScope.of(event.context).unfocus();
    }
  }

  _changeFirstMinute(FirstMinuteChangedEvent event,
      Emitter<CreateOrEditNotificationsState> emit) {
    final timeModel = state.timeModel.copyWith(firstMinute: event.firstMinute);
    emit(state.copyWith(
      timeModel: timeModel,
    ));
    _checkFirstMinuteCorrectness(emit);
    if (state.timeModel.firstMinute.isNotEmpty && state.error.isEmpty) {
      _changeFocusNode(
          context: event.context,
          focusNode: state.timeModel.secondMinuteFocusNode);
    }
    if (state.timeModel.firstMinute.isNotEmpty && state.error.isNotEmpty) {
      FocusScope.of(event.context).unfocus();
    }
  }

  _changeSecondMinute(SecondMinuteChangedEvent event,
      Emitter<CreateOrEditNotificationsState> emit) {
    final timeModel =
        state.timeModel.copyWith(secondMinute: event.secondMinute);
    emit(state.copyWith(
      timeModel: timeModel,
    ));
    if (state.timeModel.secondMinute.isNotEmpty) {
      FocusScope.of(event.context).unfocus();
    }
  }

  _changeMessage(
      MessageChangedEvent event, Emitter<CreateOrEditNotificationsState> emit) {
    emit(state.copyWith(
        notification: state.notification?.copyWith(message: event.message)));
  }

  _changeFocusNode(
      {required BuildContext context, required FocusNode? focusNode}) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  _checkFirstHourCorrectness(Emitter<CreateOrEditNotificationsState> emit) {
    if (!['0', '1', '2'].contains(state.timeModel.firstHour)) {
      emit(state.copyWith(
        error: AppErrors.hoursMustBeLess,
      ));
    } else {
      emit(state.copyWith(
        error: '',
      ));
    }
  }

  _checkSecondHourCorrectness(Emitter<CreateOrEditNotificationsState> emit) {
    if (state.timeModel.firstHour == '2' &&
        !['0', '1', '2', '3', '4'].contains(state.timeModel.secondHour)) {
      emit(state.copyWith(
        error: AppErrors.hoursMustBeLess,
      ));
    } else {
      emit(state.copyWith(
        error: '',
      ));
    }
  }

  _checkFirstMinuteCorrectness(Emitter<CreateOrEditNotificationsState> emit) {
    if (!['0', '1', '2', '3', '4', '5'].contains(state.timeModel.firstMinute)) {
      emit(state.copyWith(
        error: AppErrors.minutesMustBeLess,
      ));
    } else {
      emit(state.copyWith(
        error: '',
      ));
    }
  }

  _selectIcon(
      IconSelectedEvent event, Emitter<CreateOrEditNotificationsState> emit) {
    emit(state.copyWith(selectedIcon: event.iconAssets));
  }

  _selectIconBackgroundColor(IconBackgroundColorSelectedEvent event,
      Emitter<CreateOrEditNotificationsState> emit) {
    emit(
        state.copyWith(selectedIconBackgroundColor: event.iconBackgroundColor));
  }

  _saveIconStyle(
      IconStyleSavedEvent event, Emitter<CreateOrEditNotificationsState> emit) {
    emit(state.copyWith(
        notification: state.notification?.copyWith(
            iconAssets: state.selectedIcon,
            iconBackgroundColor: state.selectedIconBackgroundColor)));
  }

  _confirm(ConfirmedEvent event,
      Emitter<CreateOrEditNotificationsState> emit) async {
    if (state.notification?.id != null) {
      final notification = NotificationModel(
        id: state.notification?.id,
        type: state.notification!.type,
        recurringNotificationType: state.notification?.recurringNotificationType,
        time: state.notification?.type == NotificationType.oneTime
            ? state.timeModel.toString()
            : state.notification?.time ?? state.currentTime,
        message: state.notification!.message,
        iconAssets: state.notification?.iconAssets,
        iconBackgroundColor: state.notification?.iconBackgroundColor,
      );
      final requestResult = await _repository.editNotification(notification);
      if(requestResult is RequestResultSuccess){
        await event.callback();
      }
      if(requestResult is RequestResultError){
        emit(state.copyWith(
          error: requestResult.error
        ));
      }
    } else {
      final notification = NotificationModel(
        id: state.notification?.id,
        type: state.notification!.type,
        recurringNotificationType: state.notification?.recurringNotificationType,
        time: state.notification?.type == NotificationType.oneTime
        ? state.timeModel.toString()
        : state.currentTime,
        message: state.notification!.message,
        iconAssets: state.notification?.iconAssets,
        iconBackgroundColor: state.notification?.iconBackgroundColor,
      );
      final requestResult = await _repository.createNotification(notification);
      if(requestResult is RequestResultSuccess){
        await event.callback();
      }
      if(requestResult is RequestResultError){
        emit(state.copyWith(
            error: requestResult.error
        ));
      }
    }
  }
}
