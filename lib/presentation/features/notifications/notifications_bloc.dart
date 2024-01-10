import 'package:bloc/bloc.dart';
import 'package:noti_app/domain/core/request_result.dart';
import 'package:noti_app/domain/repository/notifications_repository.dart';
import '../../../utils/constants.dart';
import 'notifications_event.dart';
import 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc(this._repository) : super(const NotificationsState()) {
    on<FetchOneTimeNotificationsEvent>(_fetchOneTimeNotifications);
    on<SwitchNotificationsTypeEvent>(_switchNotificationsType);
    on<DeleteNotificationEvent>(_deleteNotification);
    on<EditNotificationEvent>(_editNotification);
    on<GoToRecurringNotificationsEvent>(_goToRecurringNotificationsEvent);
  }

  final NotificationsRepository _repository;

  _fetchOneTimeNotifications(
      NotificationsEvent event, Emitter<NotificationsState> emit) async {
    final requestResult = await _repository.fetchAllNotifications();
    if(requestResult is RequestResultError){
      emit(
        state.copyWith(
          error: requestResult.error
        )
      );
    }
    if(requestResult is RequestResultSuccess){
      emit(
          state.copyWith(
             oneTimeNotifications: requestResult.data
          )
      );
    }
  }

  _switchNotificationsType(SwitchNotificationsTypeEvent event,
      Emitter<NotificationsState> emit) async {
    emit(state.copyWith(selectedNotificationsType: event.notificationsType));
    if (event.notificationsType == NotificationsTypes.oneTime) {
      add(const FetchOneTimeNotificationsEvent());
    }
  }

  _deleteNotification(
      DeleteNotificationEvent event, Emitter<NotificationsState> emit) async {}

  _editNotification(
      EditNotificationEvent event, Emitter<NotificationsState> emit) async {}

  _goToRecurringNotificationsEvent(
      GoToRecurringNotificationsEvent event, Emitter<NotificationsState> emit) async {}
}
