import 'package:equatable/equatable.dart';

final class NotificationsState  extends Equatable{
  @override
  List<Object?> get props => [];
}

final class NotificationsStateLoading extends NotificationsState{
  NotificationsStateLoading();
}

final class NotificationsStateSuccess extends NotificationsState{
  NotificationsStateSuccess();
}
final class NotificationsStateError extends NotificationsState{
  NotificationsStateError();
}