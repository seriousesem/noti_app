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

  _changeSecondHour(SecondHourChangedEvent event, Emitter<LoginState> emit) {
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

  _changeFirstMinute(FirstMinuteChangedEvent event, Emitter<LoginState> emit) {
    final timeModel =
        state.timeModel.copyWith(firstMinute: event.firstMinute);
    _checkFirstMinuteCorrectness(emit);
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

  _checkFirstHourCorrectness(Emitter<LoginState> emit) {
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

  _checkSecondHourCorrectness(Emitter<LoginState> emit) {
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

  _checkFirstMinuteCorrectness(Emitter<LoginState> emit) {
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
