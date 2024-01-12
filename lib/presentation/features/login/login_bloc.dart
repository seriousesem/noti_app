import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../core/navigation/app_navigation.dart';
import '../../../utils/constants.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginStateLoading()) {
    on<InitializeLoginStateEvent>(_initializeLoginState);
    on<FirstHourChangedEvent>(_changeFirstHour);
    on<SecondHourChangedEvent>(_changeSecondHour);
    on<FirstMinuteChangedEvent>(_changeFirstMinute);
    on<SecondMinuteChangedEvent>(_changeSecondMinute);
    on<LoginConfirmedEvent>(_confirmLogin);
  }

  _initializeLoginState(LoginEvent event, Emitter<LoginState> emit) async {
    final currentDateTime = DateTime.now();
    final currentTime = DateFormat('HH:mm').format(currentDateTime);
    emit(state.copyWith(
        currentTime: currentTime,
        timeModel: state.timeModel.copyWith(
          secondHourFocusNode: FocusNode(),
          firstMinuteFocusNode: FocusNode(),
          secondMinuteFocusNode: FocusNode(),
        )));
  }

  _changeFirstHour(FirstHourChangedEvent event, Emitter<LoginState> emit) {
    final timeModel = state.timeModel.copyWith(
      firstHour: event.firstHour,
    );
    emit(state.copyWith(
      timeModel: timeModel,
    ));
    if (state.timeModel.firstHour.isNotEmpty) {
      _changeFocusNode(
          context: event.context,
          focusNode: state.timeModel.secondHourFocusNode);
    }
  }

  _changeSecondHour(SecondHourChangedEvent event, Emitter<LoginState> emit) {
    final timeModel = state.timeModel.copyWith(secondHour: event.secondHour);
    emit(state.copyWith(
      timeModel: timeModel,
    ));
    if (state.timeModel.secondHour.isNotEmpty) {
      _changeFocusNode(
          context: event.context,
          focusNode: state.timeModel.firstMinuteFocusNode);
    }
  }

  _changeFirstMinute(FirstMinuteChangedEvent event, Emitter<LoginState> emit) {
    final timeModel =
        state.timeModel.copyWith(firstMinute: event.firstMinute);
    emit(state.copyWith(
      timeModel: timeModel,
    ));
    if (state.timeModel.firstMinute.isNotEmpty) {
      _changeFocusNode(
          context: event.context,
          focusNode: state.timeModel.secondMinuteFocusNode);
    }
  }

  _changeSecondMinute(SecondMinuteChangedEvent event, Emitter<LoginState> emit) {
    final timeModel =
        state.timeModel.copyWith(secondMinute: event.secondMinute);
    emit(state.copyWith(
      timeModel: timeModel,
    ));
    if (state.timeModel.secondMinute.isNotEmpty) {
      FocusScope.of(event.context).unfocus();
    }
  }

  _changeFocusNode(
      {required BuildContext context, required FocusNode? focusNode}) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  _confirmLogin(LoginConfirmedEvent event, Emitter<LoginState> emit) {
    final enteredTime = state.timeModel.toString();
    if (enteredTime == state.currentTime) {
      emit(
        state.copyWith(error: ''),
      );
      Navigator.popAndPushNamed(event.context, AppRoutesNames.notificationsScreen);
    } else {
      emit(
        state.copyWith(error: AppErrors.timeIsWrong),
      );
    }
  }
}
