import 'package:noti_app/domain/core/request_result.dart';

import 'package:noti_app/domain/models/notification/notification_model.dart';

import '../../domain/repository/notifications_repository.dart';
import '../database/database_service.dart';
import '../entity/notifications/notification_entity.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  NotificationsRepositoryImpl(this._dataBaseService);

  final DataBaseService _dataBaseService;

  @override
  Future<RequestResult<List<NotificationModel>>> fetchAllNotifications() async {
    try {
      final allNotificationsEntity =
          await _dataBaseService.getAllNotifications();
      final allNotificationsModel = List.generate(allNotificationsEntity.length,
          (index) => allNotificationsEntity[index].toModel());
      return RequestResultSuccess(allNotificationsModel);
    } catch (e) {
      return RequestResultError(e.toString());
    }
  }

  @override
  Future<RequestResult<int>> createNotification(
      NotificationModel notificationModel) async {
    try {
      final notificationId = await _dataBaseService
          .insertNotification(NotificationEntity.fromModel(notificationModel));
      return RequestResultSuccess(notificationId);
    } catch (e) {
      return RequestResultError(e.toString());
    }
  }

  @override
  Future<RequestResult<int>> editNotification(
      NotificationModel notificationModel) async {
    try {
      final notificationId = await _dataBaseService
          .updateNotification(NotificationEntity.fromModel(notificationModel));
      return RequestResultSuccess(notificationId);
    } catch (e) {
      return RequestResultError(e.toString());
    }
  }

  @override
  Future<RequestResult<int>> deleteNotification(
      NotificationModel notificationModel) async {
    try {
      final notificationId = await _dataBaseService
          .deleteNotification(NotificationEntity.fromModel(notificationModel));
      return RequestResultSuccess(notificationId);
    } catch (e) {
      return RequestResultError(e.toString());
    }
  }
}
