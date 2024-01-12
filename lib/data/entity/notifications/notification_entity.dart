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
        id: map[NotificationEntityKey.id],
        type: map[NotificationEntityKey.type],
        recurringType: map[NotificationEntityKey.recurringType],
        time: map[NotificationEntityKey.time],
        message: map[NotificationEntityKey.message],
        iconAssets: map[NotificationEntityKey.iconAssets],
        iconBackgroundColor: map[NotificationEntityKey.iconBackgroundColor],
      );

  Map<String, dynamic> toMap() => {
        NotificationEntityKey.id: id,
        NotificationEntityKey.type: type,
        NotificationEntityKey.recurringType: recurringType,
        NotificationEntityKey.time: time,
        NotificationEntityKey.message: message,
        NotificationEntityKey.iconAssets: iconAssets,
        NotificationEntityKey.iconBackgroundColor: iconBackgroundColor,
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
