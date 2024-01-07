import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noti_app/core/theme/app_colors.dart';
import 'package:noti_app/presentation/features/login/login_state.dart';
import 'package:noti_app/presentation/widgets/app_bar.dart';
import '../../../utils/constants.dart';
import '../../widgets/elevated_button_without_icon.dart';
import 'login_bloc.dart';
import 'login_event.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginBloc()..add(const InitializeLoginState()),
      child: Builder(
        builder: (context) => Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: buildAppBar(
            title: Titles.loginScreen,
          ),
          body: const _LoginScreenWidget(),
        ),
      ),
    );
  }
}

class _LoginScreenWidget extends StatelessWidget {
  const _LoginScreenWidget();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 72, bottom: 32),
      child: Column(
        children: [
          _ScreenTitleWidget(),
          _ScreenHintWidget(),
          _CurrentTimeWidget(),
          _TimePlaceholderWidget(),
          Spacer(),
          _ErrorWidget(),
          _ConfirmButton(),
        ],
      ),
    );
  }
}

class _ScreenTitleWidget extends StatelessWidget {
  const _ScreenTitleWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        Titles.loginScreen,
        style: TextStyle(
          color: AppColors.mainDark,
          fontSize: 24,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _ScreenHintWidget extends StatelessWidget {
  const _ScreenHintWidget();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 16, bottom: 42),
      child: Text(
        WidgetsText.loginScreenHint,
        style: TextStyle(
          color: AppColors.darkGrey,
          fontSize: 16,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

class _CurrentTimeWidget extends StatelessWidget {
  const _CurrentTimeWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (_, state) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 42),
          child: Text(
            state.currentTime,
            style: const TextStyle(
              color: AppColors.mainDark,
              fontSize: 32,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
            ),
          ),
        );
      },
    );
  }
}

class _TimePlaceholderWidget extends StatelessWidget {
  const _TimePlaceholderWidget();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _FirstHourWidget(),
        _SecondHourWidget(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: Text(
            WidgetsText.twoDots,
            style: TextStyle(
              color: AppColors.greyB8,
              fontSize: 32,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        _FirstMinuteWidget(),
        _SecondMinuteWidget(),
      ],
    );
  }
}

class _FirstHourWidget extends StatelessWidget {
  const _FirstHourWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (_, state) => _TimeInputWidget(
        focusNode: null,
        onChangeAction: (firstHour) =>
            context.read<LoginBloc>().add(FirstHourChanged(firstHour = firstHour, context = context)),
      ),
    );
  }
}

class _SecondHourWidget extends StatelessWidget {
  const _SecondHourWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (_, state) => _TimeInputWidget(
        focusNode: state.loginModel.secondHourFocusNode,
        onChangeAction: (secondHour) =>
            context.read<LoginBloc>().add(SecondHourChanged(secondHour = secondHour, context = context)),
      ),
    );
  }
}

class _FirstMinuteWidget extends StatelessWidget {
  const _FirstMinuteWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (_, state) => _TimeInputWidget(
        focusNode: state.loginModel.firstMinuteFocusNode,
        onChangeAction: (firstMinute) =>
            context.read<LoginBloc>().add(FirstMinuteChanged(firstMinute = firstMinute, context = context)),
      ),
    );
  }
}

class _SecondMinuteWidget extends StatelessWidget {
  const _SecondMinuteWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (_, state) => _TimeInputWidget(
        focusNode: state.loginModel.secondMinuteFocusNode,
        onChangeAction: (secondMinute) =>
            context.read<LoginBloc>().add(SecondMinuteChanged(secondMinute = secondMinute, context = context)),
      ),
    );
  }
}

class _TimeInputWidget extends StatelessWidget {
  const _TimeInputWidget({required this.onChangeAction, required this.focusNode});

  final FocusNode? focusNode;
  final Function(String value) onChangeAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: SizedBox(
        width: 44,
        height: 48,
        child: TextFormField(
          onChanged: (value) {
            onChangeAction(value);
          },
          focusNode: focusNode,
          keyboardType: TextInputType.number,
          buildCounter: null,
          maxLength: 1,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.mainWhite,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.greyE6),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primaryActive),
            ),
            counterText: "",
            contentPadding: EdgeInsets.zero,
          ),
          style: const TextStyle(
            color: AppColors.mainDark,
            fontSize: 16,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) => previous.error != current.error,
        builder: (_, state) {
          return state.error.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: Container(
                    width: double.infinity,
                    height: 48,
                    decoration: const BoxDecoration(color: Color(0xFFF3F3F4)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: AppColors.mainRed,
                            size: 24,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 6),
                            child: Text(
                              state.error,
                              style: const TextStyle(
                                color: AppColors.mainRed,
                                fontSize: 14,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink();
        });
  }
}

class _ConfirmButton extends StatelessWidget {
  const _ConfirmButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (_, state) {
      final isActive = state.loginModel.firstHour.isNotEmpty &&
          state.loginModel.secondHour.isNotEmpty &&
          state.loginModel.firstMinute.isNotEmpty &&
          state.loginModel.secondMinute.isNotEmpty;
      return buildElevatedButtonWithoutIcon(
        buttonText: WidgetsText.confirm,
        isActive: isActive,
        buttonAction: () {
          context.read<LoginBloc>().add(LoginConfirmed(context));
        },
      );
    });
  }
}
