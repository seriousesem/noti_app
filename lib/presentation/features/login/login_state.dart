import 'package:equatable/equatable.dart';

import '../../../domain/models/time/time_model.dart';


final class LoginState extends Equatable {
  const LoginState({
    this.currentTime = '',
    this.timeModel = const TimeModel(),
    this.error = '',
  });

  final String currentTime;
  final TimeModel timeModel;
  final String error;

  LoginState copyWith({
    String? currentTime,
    TimeModel? timeModel,
    String? error,
  }) =>
      LoginState(
        currentTime: currentTime ?? this.currentTime,
        timeModel: timeModel ?? this.timeModel,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => [
        currentTime,
        timeModel,
        error,
      ];
}

final class LoginStateLoading extends LoginState {
  const LoginStateLoading();
}

final class LoginStateSuccess extends LoginState {
  const LoginStateSuccess(
    String currentTime,
    TimeModel timeModel,
    bool isValid,
  ) : super(
          currentTime: currentTime,
          timeModel: timeModel,
        );
}

final class LoginStateError extends LoginState {
  const LoginStateError(String error) : super(error: error);
}
