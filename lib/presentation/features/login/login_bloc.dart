import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../core/navigation/app_navogation.dart';
import '../../../utils/constants.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginStateLoading()) {
    on<InitializeLoginState>(_onInitializeLoginState);
    on<FirstHourChanged>(_onFirstHourChanged);
    on<SecondHourChanged>(_onSecondHourChanged);
    on<FirstMinuteChanged>(_onFirstMinuteChanged);
    on<SecondMinuteChanged>(_onSecondMinuteChanged);
    on<LoginConfirmed>(_onLoginConfirmed);
  }

  _onInitializeLoginState(LoginEvent event, Emitter<LoginState> emit) async {
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

  _onFirstHourChanged(FirstHourChanged event, Emitter<LoginState> emit) {
    final loginModel = state.loginModel.copyWith(
      firstHour: event.firstHour,
    );
    emit(state.copyWith(
      loginModel: loginModel,
    ));
    if (state.loginModel.firstHour.isNotEmpty) {
      _onChangeFocusNode(
          context: event.context,
          focusNode: state.loginModel.secondHourFocusNode);
    }
  }

  _onSecondHourChanged(SecondHourChanged event, Emitter<LoginState> emit) {
    final loginModel = state.loginModel.copyWith(secondHour: event.secondHour);
    emit(state.copyWith(
      loginModel: loginModel,
    ));
    if (state.loginModel.secondHour.isNotEmpty) {
      _onChangeFocusNode(
          context: event.context,
          focusNode: state.loginModel.firstMinuteFocusNode);
    }
  }

  _onFirstMinuteChanged(FirstMinuteChanged event, Emitter<LoginState> emit) {
    final loginModel =
        state.loginModel.copyWith(firstMinute: event.firstMinute);
    emit(state.copyWith(
      loginModel: loginModel,
    ));
    if (state.loginModel.firstMinute.isNotEmpty) {
      _onChangeFocusNode(
          context: event.context,
          focusNode: state.loginModel.secondMinuteFocusNode);
    }
  }

  _onSecondMinuteChanged(SecondMinuteChanged event, Emitter<LoginState> emit) {
    final loginModel =
        state.loginModel.copyWith(secondMinute: event.secondMinute);
    emit(state.copyWith(
      loginModel: loginModel,
    ));
    if (state.loginModel.secondMinute.isNotEmpty) {
      FocusScope.of(event.context).unfocus();
    }
  }

  _onChangeFocusNode(
      {required BuildContext context, required FocusNode? focusNode}) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  _onLoginConfirmed(LoginConfirmed event, Emitter<LoginState> emit) {
    final enteredTime =
        "${state.loginModel.firstHour}${state.loginModel.secondHour}:${state.loginModel.firstMinute}${state.loginModel.secondMinute}";
    if (enteredTime == state.currentTime) {
      Navigator.pushNamed(event.context, AppRoutesNames.notificationsScreen);
    } else {
      emit(
        state.copyWith(error: AppErrors.timeIsWrong),
      );
    }
  }
}
