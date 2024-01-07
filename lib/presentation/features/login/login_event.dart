import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

final class InitializeLoginState extends LoginEvent {
  const InitializeLoginState();

  @override
  List<Object> get props => [];
}

final class FirstHourChanged extends LoginEvent {
  const FirstHourChanged(this.firstHour, this.context);

  final String firstHour;
  final BuildContext context;
}

final class SecondHourChanged extends LoginEvent {
  const SecondHourChanged(this.secondHour, this.context);

  final String secondHour;
  final BuildContext context;
}

final class FirstMinuteChanged extends LoginEvent {
  const FirstMinuteChanged(this.firstMinute, this.context);

  final String firstMinute;
  final BuildContext context;
}

final class SecondMinuteChanged extends LoginEvent {
  const SecondMinuteChanged(this.secondMinute, this.context);

  final String secondMinute;
  final BuildContext context;
}

final class ChangeSecondMinute extends LoginEvent {
  const ChangeSecondMinute(this.secondMinute, this.context);

  final String secondMinute;
  final BuildContext context;

}

final class LoginConfirmed extends LoginEvent {
  const LoginConfirmed(this.context);

  final BuildContext context;
}
