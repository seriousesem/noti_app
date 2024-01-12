import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:noti_app/presentation/widgets/app_bar.dart';
import 'package:noti_app/utils/constants.dart';
import 'package:path/path.dart';
import '../../../core/theme/app_colors.dart';
import '../../../di/injection_container.dart';
import '../../../domain/models/notification/notification_model.dart';
import '../../../utils/images_assets.dart';
import '../../widgets/button_back_widget.dart';
import '../../widgets/button_text.dart';
import '../../widgets/elevated_button_without_icon.dart';
import '../../widgets/error_message.dart';
import 'create_edit_notification_bloc.dart';
import 'create_edit_notification_event.dart';
import 'create_edit_notification_state.dart';

class CreateOrEditNotificationScreen extends StatelessWidget {
  const CreateOrEditNotificationScreen({super.key, required this.notification});

  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateOrEditNotificationBloc>(
      create: (BuildContext context) => getIt()
        ..add(InitializeAddNotificationEvent(notification: notification)),
      child: Builder(
        builder: (context) => Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: buildAppBar(
            title: notification.id != null
                ? WidgetsText.editNewNotification
                : WidgetsText.addNotification,
            leading: buildButtonBackWidget(context: context),
          ),
          body: const _CreateOrEditNotificationScreenWidget(),
        ),
      ),
    );
  }
}

class _CreateOrEditNotificationScreenWidget extends StatelessWidget {
  const _CreateOrEditNotificationScreenWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateOrEditNotificationBloc,
        CreateOrEditNotificationsState>(
      builder: (_, state) => Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: Column(
          children: [
            const _MessageWidget(),
            state.notification?.type == NotificationsType.oneTime
                ? const _TimePlaceholderWidget()
                : const SizedBox.shrink(),
            const _SelectIconPlaceholderWidget(),
            const Spacer(),
            const _ErrorMessageWidget(),
            const _ConfirmButtonWidget(),
          ],
        ),
      ),
    );
  }
}

class _MessageWidget extends StatelessWidget {
  const _MessageWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateOrEditNotificationBloc,
        CreateOrEditNotificationsState>(
      builder: (_, state) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _TitleWidget(title: WidgetsText.message),
            TextFormField(
              keyboardType: TextInputType.text,
              buildCounter: null,
              onChanged: (message) => context
                  .read<CreateOrEditNotificationBloc>()
                  .add(
                    MessageChangedEvent(message = message, context = context),
                  ),
              maxLines: 4,
              decoration: InputDecoration(
                filled: true,
                hintText: WidgetsText.enterMessage,
                hintStyle: const TextStyle(
                  color: AppColors.greyB8,
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
                fillColor: AppColors.mainWhite,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.lightGrey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.primaryActive),
                ),
                counterText: "",
                contentPadding: const EdgeInsets.all(16),
              ),
              style: const TextStyle(
                color: AppColors.mainDark,
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimePlaceholderWidget extends StatelessWidget {
  const _TimePlaceholderWidget();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 6),
            child: _TitleWidget(title: WidgetsText.typeTime),
          ),
          Row(
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
          ),
        ],
      ),
    );
  }
}

class _FirstHourWidget extends StatelessWidget {
  const _FirstHourWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateOrEditNotificationBloc,
        CreateOrEditNotificationsState>(
      builder: (_, state) => _TimeInputWidget(
        focusNode: null,
        onChangeAction: (firstHour) => context
            .read<CreateOrEditNotificationBloc>()
            .add(
              FirstHourChangedEvent(firstHour = firstHour, context = context),
            ),
      ),
    );
  }
}

class _SecondHourWidget extends StatelessWidget {
  const _SecondHourWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateOrEditNotificationBloc,
        CreateOrEditNotificationsState>(
      builder: (_, state) => _TimeInputWidget(
        focusNode: state.timeModel.secondHourFocusNode,
        onChangeAction: (secondHour) => context
            .read<CreateOrEditNotificationBloc>()
            .add(SecondHourChangedEvent(
                secondHour = secondHour, context = context)),
      ),
    );
  }
}

class _FirstMinuteWidget extends StatelessWidget {
  const _FirstMinuteWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateOrEditNotificationBloc,
        CreateOrEditNotificationsState>(
      builder: (_, state) => _TimeInputWidget(
        focusNode: state.timeModel.firstMinuteFocusNode,
        onChangeAction: (firstMinute) => context
            .read<CreateOrEditNotificationBloc>()
            .add(FirstMinuteChangedEvent(
                firstMinute = firstMinute, context = context)),
      ),
    );
  }
}

class _SecondMinuteWidget extends StatelessWidget {
  const _SecondMinuteWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateOrEditNotificationBloc,
        CreateOrEditNotificationsState>(
      builder: (_, state) => _TimeInputWidget(
        focusNode: state.timeModel.secondMinuteFocusNode,
        onChangeAction: (secondMinute) => context
            .read<CreateOrEditNotificationBloc>()
            .add(SecondMinuteChangedEvent(
                secondMinute = secondMinute, context = context)),
      ),
    );
  }
}

class _TimeInputWidget extends StatelessWidget {
  const _TimeInputWidget(
      {required this.onChangeAction, required this.focusNode});

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
              borderSide: const BorderSide(color: AppColors.lightGrey),
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

class _SelectIconPlaceholderWidget extends StatelessWidget {
  const _SelectIconPlaceholderWidget();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TitleWidget(title: WidgetsText.icon),
          Row(
            children: [
              _IconPreviewWidget(),
              _SelectIconButtonWidget(),
            ],
          ),
        ],
      ),
    );
  }
}

class _IconPreviewWidget extends StatelessWidget {
  const _IconPreviewWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateOrEditNotificationBloc,
        CreateOrEditNotificationsState>(
      buildWhen: (previous, current) =>
          previous.notification?.iconAssets !=
              current.notification?.iconAssets ||
          previous.notification?.iconBackgroundColor !=
              current.notification?.iconBackgroundColor,
      builder: (_, state) => Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Container(
          width: 80,
          height: 80,
          decoration: ShapeDecoration(
            color: state.notification?.iconBackgroundColor != null
                ? iconBackgroundColors[state.notification?.iconBackgroundColor]
                : AppColors.mainWhite,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: AppColors.greyB8),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              state.notification?.iconAssets != null
                  ? SvgPicture.asset(
                      state.notification?.iconAssets ?? IconsAssets.image,
                      width: 40,
                      height: 40,
                      colorFilter: const ColorFilter.mode(
                          AppColors.primaryActive, BlendMode.srcIn),
                    )
                  : SvgPicture.asset(
                      IconsAssets.image,
                      width: 48,
                      height: 48,
                      colorFilter: const ColorFilter.mode(
                          AppColors.gray, BlendMode.srcIn),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SelectIconButtonWidget extends StatelessWidget {
  const _SelectIconButtonWidget();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: OutlinedButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (innerContext) {
                return BlocProvider.value(
                  value: context.read<CreateOrEditNotificationBloc>(),
                  child: const _IconStyleBottomSheetWidget(),
                );
              },
              isDismissible: false,
              backgroundColor: AppColors.mainWhite);
        },
        child: const Text(
          WidgetsText.selectIcon,
          style: TextStyle(
            color: AppColors.primaryActive,
            fontSize: 14,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.mainDark,
          fontSize: 14,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateOrEditNotificationBloc,
            CreateOrEditNotificationsState>(
        buildWhen: (previous, current) => previous.error != current.error,
        builder: (_, state) {
          return buildErrorMessageWidget(errorMessage: state.error);
        });
  }
}

class _ConfirmButtonWidget extends StatelessWidget {
  const _ConfirmButtonWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateOrEditNotificationBloc,
        CreateOrEditNotificationsState>(
      builder: (context, state) {
        final isActive = state.timeModel.firstHour.isNotEmpty &&
            state.timeModel.secondHour.isNotEmpty &&
            state.timeModel.firstMinute.isNotEmpty &&
            state.timeModel.secondMinute.isNotEmpty &&
            state.notification!.message.isNotEmpty &&
            state.error.isEmpty;
        return buildElevatedButtonWithoutIcon(
          buttonText: WidgetsText.confirm,
          isActive: isActive,
          buttonAction: () {
            context
                .read<CreateOrEditNotificationBloc>()
                .add(CreateNotificationEvent(context: context));
          },
        );
      },
    );
  }
}

class _IconStyleBottomSheetWidget extends StatelessWidget {
  const _IconStyleBottomSheetWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                WidgetsText.iconStyle,
                style: TextStyle(
                  color: AppColors.mainDark,
                  fontSize: 20,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                width: 30,
                height: 30,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  padding: EdgeInsets.zero,
                  icon: SvgPicture.asset(
                    IconsAssets.cancelCircle,
                    width: 30,
                    height: 30,
                    colorFilter: const ColorFilter.mode(
                        AppColors.primaryActive, BlendMode.srcIn),
                  ),
                ),
              )
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Divider(
            color: AppColors.lightGrey,
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            WidgetsText.backgroundColors,
            style: TextStyle(
              color: AppColors.darkGrey,
              fontSize: 16,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const _IconBackgroundColorsListWidget(),
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            WidgetsText.selectIcons,
            style: TextStyle(
              color: AppColors.darkGrey,
              fontSize: 16,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const _IconsListWidget(),
        const Spacer(),
        const _SaveChangesButtonWidget(),
        const SizedBox(height: 32)
      ],
    );
  }
}

class _IconBackgroundColorsListWidget extends StatelessWidget {
  const _IconBackgroundColorsListWidget();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        itemCount: iconBackgroundColors.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return _IconBackgroundColorItemWidget(
            iconBackgroundColor: iconBackgroundColors.keys.elementAt(index),
          );
        },
      ),
    );
  }
}

class _IconBackgroundColorItemWidget extends StatelessWidget {
  const _IconBackgroundColorItemWidget({required this.iconBackgroundColor});

  final String iconBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateOrEditNotificationBloc,
        CreateOrEditNotificationsState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: IconButton(
            onPressed: () {
              context
                  .read<CreateOrEditNotificationBloc>()
                  .add(IconBackgroundColorSelectedEvent(iconBackgroundColor));
            },
            icon: Container(
              width: 70,
              height: 70,
              padding: const EdgeInsets.all(2),
              decoration:
                  state.selectedIconBackgroundColor == iconBackgroundColor
                      ? const ShapeDecoration(
                          shape: OvalBorder(
                            side: BorderSide(
                                width: 3, color: AppColors.primaryActive),
                          ),
                        )
                      : null,
              child: Container(
                width: 60,
                height: 60,
                decoration: ShapeDecoration(
                  color: iconBackgroundColors[iconBackgroundColor],
                  shape: const OvalBorder(
                    side: BorderSide(width: 1, color: AppColors.lightGrey),
                  ),
                ),
              ),
            ),
            padding: EdgeInsets.zero,
          ),
        );
      },
    );
  }
}

class _IconsListWidget extends StatelessWidget {
  const _IconsListWidget();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        itemCount: allIconsAssets.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return _IconItemWidget(
            iconAssets: allIconsAssets.elementAt(index),
          );
        },
      ),
    );
  }
}

class _IconItemWidget extends StatelessWidget {
  const _IconItemWidget({required this.iconAssets});

  final String iconAssets;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateOrEditNotificationBloc,
        CreateOrEditNotificationsState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: IconButton(
            onPressed: () {
              context
                  .read<CreateOrEditNotificationBloc>()
                  .add(IconSelectedEvent(iconAssets));
            },
            icon: Container(
              width: 70,
              height: 70,
              padding: const EdgeInsets.all(2),
              decoration: state.selectedIcon == iconAssets
                  ? const ShapeDecoration(
                      shape: OvalBorder(
                        side: BorderSide(
                            width: 3, color: AppColors.primaryActive),
                      ),
                    )
                  : null,
              child: Container(
                width: 60,
                height: 60,
                decoration: const ShapeDecoration(
                  shape: OvalBorder(
                    side: BorderSide(width: 1, color: AppColors.lightGrey),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      iconAssets,
                      width: 40,
                      height: 40,
                      colorFilter: const ColorFilter.mode(
                          AppColors.primaryActive, BlendMode.srcIn),
                    ),
                  ],
                ),
              ),
            ),
            padding: EdgeInsets.zero,
          ),
        );
      },
    );
  }
}

class _SaveChangesButtonWidget extends StatelessWidget {
  const _SaveChangesButtonWidget();

  @override
  Widget build(BuildContext context) {
    return buildElevatedButtonWithoutIcon(
      buttonText: WidgetsText.saveChanges,
      isActive: true,
      buttonAction: () {
        context
            .read<CreateOrEditNotificationBloc>()
            .add(const IconStyleSavedEvent());
        Navigator.pop(context);
      },
    );
  }
}
