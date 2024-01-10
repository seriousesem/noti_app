import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

final class InitializeLoginStateEvent extends LoginEvent {
  const InitializeLoginStateEvent();
}

final class FirstHourChangedEvent extends LoginEvent {
  const FirstHourChangedEvent(this.firstHour, this.context);

  final String firstHour;
  final BuildContext context;
}

final class SecondHourChangedEvent extends LoginEvent {
  const SecondHourChangedEvent(this.secondHour, this.context);

  final String secondHour;
  final BuildContext context;
}

final class FirstMinuteChangedEvent extends LoginEvent {
  const FirstMinuteChangedEvent(this.firstMinute, this.context);

  final String firstMinute;
  final BuildContext context;
}

final class SecondMinuteChangedEvent extends LoginEvent {
  const SecondMinuteChangedEvent(this.secondMinute, this.context);

  final String secondMinute;
  final BuildContext context;
}

final class ChangeSecondMinuteEvent extends LoginEvent {
  const ChangeSecondMinuteEvent(this.secondMinute, this.context);

  final String secondMinute;
  final BuildContext context;
}

final class LoginConfirmedEvent extends LoginEvent {
  const LoginConfirmedEvent(this.context);

  final BuildContext context;
}
