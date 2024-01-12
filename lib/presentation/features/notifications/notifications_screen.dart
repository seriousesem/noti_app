import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:noti_app/presentation/features/notifications/notifications_state.dart';
import 'package:noti_app/presentation/widgets/app_bar.dart';
import 'package:noti_app/utils/constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../di/injection_container.dart';
import '../../../domain/models/notification/notification_model.dart';
import '../../../utils/images_assets.dart';
import '../../widgets/elevated_button_with_icon.dart';
import '../../widgets/error_dialog_with_one_button.dart';
import '../../widgets/notification_widget.dart';
import '../../widgets/small_elevated_button_with_icon.dart';
import '../../widgets/small_outlinedButton_button_with_icon.dart';
import 'notifications_bloc.dart';
import 'notifications_event.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotificationsBloc>(
      create: (BuildContext context) =>
          getIt()..add(const FetchOneTimeNotificationsEvent()),
      child: Builder(
        builder: (context) => Scaffold(
          appBar: buildAppBar(
            title: WidgetsText.notificationsScreen,
          ),
          body: const _NotificationsScreenWidget(),
        ),
      ),
    );
  }
}

class _NotificationsScreenWidget extends StatelessWidget {
  const _NotificationsScreenWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsBloc, NotificationsState>(
      builder: (_, state) => Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: Column(
          children: [
            const NotificationsTypeSwitcherWidget(),
            state.selectedNotificationsType == NotificationsType.oneTime
                ? const _OneTimeNotificationsWidget()
                : const _RecurringTypesListWidget(),
          ],
        ),
      ),
    );
  }
}

class NotificationsTypeSwitcherWidget extends StatelessWidget {
  const NotificationsTypeSwitcherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.mainDark,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          height: 48,
          decoration: ShapeDecoration(
            color: AppColors.veryLightGrey,
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 1,
                color: AppColors.lightGrey,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.all(4),
            child: Row(
              children: [
                _OneTimeButtonWidget(),
                _RecurringButtonWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OneTimeButtonWidget extends StatelessWidget {
  const _OneTimeButtonWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsBloc, NotificationsState>(
      builder: (_, state) =>
          state.selectedNotificationsType == NotificationsType.oneTime
              ? buildSmallElevatedButtonWithIcon(
                  buttonText: WidgetsText.oneTime,
                  iconAssets: IconsAssets.timer,
                  buttonAction: () => context.read<NotificationsBloc>().add(
                      const SwitchNotificationsTypeEvent(
                          notificationsType: NotificationsType.oneTime)),
                )
              : buildSmallOutlinedButtonWithIcon(
                  buttonText: WidgetsText.oneTime,
                  iconAssets: IconsAssets.timer,
                  buttonAction: () => context.read<NotificationsBloc>().add(
                      const SwitchNotificationsTypeEvent(
                          notificationsType: NotificationsType.oneTime)),
                ),
    );
  }
}

class _RecurringButtonWidget extends StatelessWidget {
  const _RecurringButtonWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsBloc, NotificationsState>(
      builder: (_, state) =>
          state.selectedNotificationsType == NotificationsType.recurring
              ? buildSmallElevatedButtonWithIcon(
                  buttonText: WidgetsText.recurring,
                  iconAssets: IconsAssets.history,
                  buttonAction: () => context.read<NotificationsBloc>().add(
                      const SwitchNotificationsTypeEvent(
                          notificationsType: NotificationsType.recurring)),
                )
              : buildSmallOutlinedButtonWithIcon(
                  buttonText: WidgetsText.recurring,
                  iconAssets: IconsAssets.history,
                  buttonAction: () => context.read<NotificationsBloc>().add(
                      const SwitchNotificationsTypeEvent(
                          notificationsType: NotificationsType.recurring)),
                ),
    );
  }
}

class _OneTimeNotificationsWidget extends StatelessWidget {
  const _OneTimeNotificationsWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsBloc, NotificationsState>(
        builder: (_, state) {
      if (state is NotificationsStateLoading) {
        return const Expanded(
          child: CupertinoActivityIndicator(),
        );
      }
      if (state is NotificationsStateSuccess) {
        return Expanded(
          child: Column(
            children: [
              _NotificationsListWidget(
                oneTimeNotifications: state.oneTimeNotifications ?? [],
              ),
              const _AddNotificationButton(),
            ],
          ),
        );
      }
      if (state is NotificationsStateError) {
        return Expanded(
          child: buildErrorDialogWithOneButton(
            error: state.error ?? AppErrors.unknownError,
            yesButtonAction: () {
              context
                  .read<NotificationsBloc>()
                  .add(const FetchOneTimeNotificationsEvent());
            },
          ),
        );
      }
      return const SizedBox();
    });
  }
}

class _NotificationsListWidget extends StatelessWidget {
  const _NotificationsListWidget({required this.oneTimeNotifications});

  final List<NotificationModel> oneTimeNotifications;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: oneTimeNotifications.length,
          itemBuilder: (_, index) {
            return buildNotificationWidget(
              time: oneTimeNotifications[index].time,
              message: oneTimeNotifications[index].message,
              iconAssets: oneTimeNotifications[index].iconAssets,
              iconBackgroundColor:
                  oneTimeNotifications[index].iconBackgroundColor,
              editButtonAction: () {
                context.read<NotificationsBloc>().add(GoToEditNotificationEvent(
                      context: context,
                      notification: oneTimeNotifications[index],
                    ));
              },
              deleteButtonAction: () {
                context.read<NotificationsBloc>().add(DeleteNotificationEvent(
                    notification: oneTimeNotifications[index]));
              },
            );
          },
        ),
      ),
    );
  }
}

class _AddNotificationButton extends StatelessWidget {
  const _AddNotificationButton();

  @override
  Widget build(BuildContext context) {
    return buildElevatedButtonWithIcon(
      buttonText: WidgetsText.addNotification,
      isActive: true,
      buttonAction: () {
        context
            .read<NotificationsBloc>()
            .add(GoToCreateNotificationEvent(context: context));
      },
    );
  }
}

class _RecurringTypesListWidget extends StatelessWidget {
  const _RecurringTypesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final recurringTypesList = [
      RecurringNotificationType.oneMinute,
      RecurringNotificationType.threeMinutes,
      RecurringNotificationType.fiveMinutes,
    ];

    return ListView.builder(
      shrinkWrap: true,
      itemCount: recurringTypesList.length,
      itemBuilder: (_, index) {
        return _RecurringTypeButtonWidget(
          recurringType: recurringTypesList[index],
        );
      },
    );
  }
}

class _RecurringTypeButtonWidget extends StatelessWidget {
  const _RecurringTypeButtonWidget({required this.recurringType});

  final String recurringType;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.blueGrey,
        border: Border(
          left: BorderSide(color: AppColors.lightGrey),
          top: BorderSide(color: AppColors.lightGrey),
          right: BorderSide(color: AppColors.lightGrey),
          bottom: BorderSide(width: 1, color: AppColors.lightGrey),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            recurringType,
            style: const TextStyle(
              color: AppColors.mainDark,
              fontSize: 16,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            width: 24,
            height: 24,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: SvgPicture.asset(
                IconsAssets.arrowForwardIos,
                colorFilter: const ColorFilter.mode(
                  AppColors.primaryActive,
                  BlendMode.srcIn,
                ),
              ),
              onPressed: () {
                context
                    .read<NotificationsBloc>()
                    .add(GoToRecurringNotificationsEvent(
                      context: context,
                      recurringType: recurringType,
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
