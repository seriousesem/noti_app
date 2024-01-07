import 'package:equatable/equatable.dart';

sealed class NotificationsEvent extends Equatable {
  const NotificationsEvent();
  @override
  List<Object> get props => [];
}

class InitializeNotificationState extends NotificationsEvent {
  const InitializeNotificationState();
  @override
  List<Object> get props => [];
}