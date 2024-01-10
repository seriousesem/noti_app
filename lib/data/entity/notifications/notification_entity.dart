import '../../../domain/models/notification/notification_model.dart';
import '../../../utils/constants.dart';

class NotificationEntity {
  const NotificationEntity({
    this.id,
    required this.type,
    this.recurringType,
    required this.time,
    required this.message,
    this.iconAssets,
    this.iconBackgroundColor,
  });

  final int? id;
  final String type;
  final String? recurringType;
  final String time;
  final String message;
  final String? iconAssets;
  final String? iconBackgroundColor;

  factory NotificationEntity.fromMap(Map<String, dynamic> map) =>
      NotificationEntity(
        id: map[NotificationEntityKeys.id],
        type: map[NotificationEntityKeys.type],
        recurringType: map[NotificationEntityKeys.recurringType],
        time: map[NotificationEntityKeys.time],
        message: map[NotificationEntityKeys.message],
        iconAssets: map[NotificationEntityKeys.iconAssets],
        iconBackgroundColor: map[NotificationEntityKeys.iconBackgroundColor],
      );

  Map<String, dynamic> toMap() => {
        NotificationEntityKeys.id: id,
        NotificationEntityKeys.type: type,
        NotificationEntityKeys.recurringType: recurringType,
        NotificationEntityKeys.time: time,
        NotificationEntityKeys.message: message,
        NotificationEntityKeys.iconAssets: iconAssets,
        NotificationEntityKeys.iconBackgroundColor: iconBackgroundColor,
      };

  factory NotificationEntity.fromModel(NotificationModel notificationModel) =>
      NotificationEntity(
        id: notificationModel.id,
        type: notificationModel.type,
        recurringType: notificationModel.recurringType,
        time: notificationModel.time,
        message: notificationModel.message,
        iconAssets: notificationModel.iconAssets,
        iconBackgroundColor: notificationModel.iconBackgroundColor,
      );

  NotificationModel toModel() => NotificationModel(
        id: id,
        type: type,
        recurringType: recurringType,
        time: time,
        message: message,
        iconAssets: iconAssets,
        iconBackgroundColor: iconBackgroundColor,
      );

}
