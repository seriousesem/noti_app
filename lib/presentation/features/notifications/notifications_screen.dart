import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noti_app/presentation/widgets/app_bar.dart';
import 'package:noti_app/utils/constants.dart';

import 'notifications_bloc.dart';
import 'notifications_event.dart';
import 'notifications_state.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
      NotificationsBloc()
        ..add(const InitializeNotificationState()),
      child: Builder(
        builder: (context) =>
            Scaffold(
              appBar: buildAppBar(title: Titles.notificationsScreen),
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
    final bloc = BlocProvider.of<NotificationsBloc>(context);
    return const Placeholder();
  }
}

