import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:noti_app/presentation/features/notifications/notifications_state.dart';
import 'package:noti_app/presentation/features/recurring_notifications/recurring_notifications_state.dart';
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
import 'recurring_notifications_bloc.dart';
import 'recurring_notifications_event.dart';

class RecurringNotificationsScreen extends StatelessWidget {
  const RecurringNotificationsScreen({super.key, required this.recurringNotificationType});

  final String recurringNotificationType;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RecurringNotificationsBloc>(
      create: (BuildContext context) =>
          getIt()..add(InitializeRecurringNotificationsStateEvent(recurringNotificationType: recurringNotificationType)),
      child: Builder(
        builder: (context) => Scaffold(
          appBar: buildAppBar(
            title: recurringNotificationType,
          ),
          body: const _RecurringNotificationsScreenWidget(),
        ),
      ),
    );
  }
}

class _RecurringNotificationsScreenWidget extends StatelessWidget {
  const _RecurringNotificationsScreenWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecurringNotificationsBloc, RecurringNotificationsState>(
      builder: (_, state) => const Padding(
        padding: EdgeInsets.only(bottom: 32, top: 16),
        child: _RecurringNotificationsWidget(),
      ),
    );
  }
}

class _RecurringNotificationsWidget extends StatelessWidget {
  const _RecurringNotificationsWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecurringNotificationsBloc, RecurringNotificationsState>(
        builder: (_, state) {
      if (state is RecurringNotificationsStateLoading) {
        return const Center(child: CupertinoActivityIndicator());
      }
      if (state is RecurringNotificationsStateSuccess) {
        return Column(
          children: [
            _NotificationsListWidget(
              notifications: state.notifications ?? [],
            ),
            const _AddNotificationButton(),
          ],
        );
      }
      if (state is RecurringNotificationsStateError) {
        return Center(
          child: buildErrorDialogWithOneButton(
            error: state.error ?? AppErrors.unknownError,
            yesButtonAction: () {
              context
                  .read<RecurringNotificationsBloc>()
                  .add(const FetchNotificationsEvent());
            },
          ),
        );
      }
      return const SizedBox();
    });
  }
}

class _NotificationsListWidget extends StatelessWidget {
  const _NotificationsListWidget({required this.notifications});

  final List<NotificationModel> notifications;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: notifications.length,
          itemBuilder: (_, index) {
            return buildNotificationWidget(
              time: notifications[index].time,
              message: notifications[index].message,
              iconAssets: notifications[index].iconAssets,
              iconBackgroundColor:
                  notifications[index].iconBackgroundColor,
              editButtonAction: () {
                context.read<RecurringNotificationsBloc>().add(GoToEditNotificationEvent(
                      context: context,
                      notification: notifications[index],
                    ));
              },
              deleteButtonAction: () {
                context.read<RecurringNotificationsBloc>().add(DeleteNotificationEvent(
                    notification: notifications[index]));
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
            .read<RecurringNotificationsBloc>()
            .add(GoToCreateNotificationEvent(context: context));
      },
    );
  }
}
