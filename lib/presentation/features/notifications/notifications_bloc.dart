import 'package:bloc/bloc.dart';

import 'notifications_event.dart';
import 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc() : super(NotificationsStateLoading()) {
    on<InitializeNotificationState>(_onInitializeNotificationsState);
  }

  _onInitializeNotificationsState(
      NotificationsEvent event, Emitter<NotificationsState> emit) async {}
}
