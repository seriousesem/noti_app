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
        loginModel: state.loginModel.copyWith(
          secondHourFocusNode: FocusNode(),
          firstMinuteFocusNode: FocusNode(),
          secondMinuteFocusNode: FocusNode(),
        )));
  }

  _changeFirstHour(FirstHourChangedEvent event, Emitter<LoginState> emit) {
    final loginModel = state.loginModel.copyWith(
      firstHour: event.firstHour,
    );
    emit(state.copyWith(
      loginModel: loginModel,
    ));
    if (state.loginModel.firstHour.isNotEmpty) {
      _changeFocusNode(
          context: event.context,
          focusNode: state.loginModel.secondHourFocusNode);
    }
  }

  _changeSecondHour(SecondHourChangedEvent event, Emitter<LoginState> emit) {
    final loginModel = state.loginModel.copyWith(secondHour: event.secondHour);
    emit(state.copyWith(
      loginModel: loginModel,
    ));
    if (state.loginModel.secondHour.isNotEmpty) {
      _changeFocusNode(
          context: event.context,
          focusNode: state.loginModel.firstMinuteFocusNode);
    }
  }

  _changeFirstMinute(FirstMinuteChangedEvent event, Emitter<LoginState> emit) {
    final loginModel =
        state.loginModel.copyWith(firstMinute: event.firstMinute);
    emit(state.copyWith(
      loginModel: loginModel,
    ));
    if (state.loginModel.firstMinute.isNotEmpty) {
      _changeFocusNode(
          context: event.context,
          focusNode: state.loginModel.secondMinuteFocusNode);
    }
  }

  _changeSecondMinute(SecondMinuteChangedEvent event, Emitter<LoginState> emit) {
    final loginModel =
        state.loginModel.copyWith(secondMinute: event.secondMinute);
    emit(state.copyWith(
      loginModel: loginModel,
    ));
    if (state.loginModel.secondMinute.isNotEmpty) {
      FocusScope.of(event.context).unfocus();
    }
  }

  _changeFocusNode(
      {required BuildContext context, required FocusNode? focusNode}) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  _confirmLogin(LoginConfirmedEvent event, Emitter<LoginState> emit) {
    final enteredTime =
        "${state.loginModel.firstHour}${state.loginModel.secondHour}:${state.loginModel.firstMinute}${state.loginModel.secondMinute}";
    if (enteredTime == state.currentTime) {
      emit(
        state.copyWith(error: ''),
      );
      Navigator.pushNamed(event.context, AppRoutesNames.notificationsScreen);
    } else {
      emit(
        state.copyWith(error: AppErrors.timeIsWrong),
      );
    }
  }
}
