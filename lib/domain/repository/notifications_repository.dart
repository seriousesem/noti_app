
import '../core/request_result.dart';
import '../models/notification/notification_model.dart';

abstract class NotificationsRepository{
  Future<RequestResult<List<NotificationModel>>> fetchAllNotifications();
  Future<RequestResult<int>> addNotification(NotificationModel notificationModel);
  Future<RequestResult<int>> editNotification(NotificationModel notificationModel);
  Future<RequestResult<int>> deleteNotification(NotificationModel notificationModel);
}