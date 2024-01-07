import 'package:equatable/equatable.dart';
import '../../../domain/models/login/login_model.dart';

final class LoginState extends Equatable {
  const LoginState({
    this.currentTime = '',
    this.loginModel = const LoginModel(),
    this.error = '',
  });

  final String currentTime;
  final LoginModel loginModel;
  final String error;

  LoginState copyWith({
    String? currentTime,
    LoginModel? loginModel,
    String? error,
  }) =>
      LoginState(
        currentTime: currentTime ?? this.currentTime,
        loginModel: loginModel ?? this.loginModel,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => [
        currentTime,
        loginModel,
        error,
      ];
}

final class LoginStateLoading extends LoginState {
  const LoginStateLoading();
}

final class LoginStateSuccess extends LoginState {
  const LoginStateSuccess(
    String currentTime,
    LoginModel loginModel,
    bool isValid,
  ) : super(
          currentTime: currentTime,
          loginModel: loginModel,
        );
}

final class LoginStateError extends LoginState {
  const LoginStateError(String error) : super(error: error);
}
