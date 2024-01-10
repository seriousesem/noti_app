import 'package:equatable/equatable.dart';

final class NotificationModel extends Equatable {
  const NotificationModel({
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

  NotificationModel copyWith(
    int? id,
    String? type,
    String? recurringType,
    String? time,
    String? message,
    String? iconAssets,
    String? iconBackgroundColor,
  ) =>
      NotificationModel(
        id: id ?? this.id,
        type: type ?? this.type,
        recurringType: recurringType ?? this.recurringType,
        time: time ?? this.time,
        message: message ?? this.message,
        iconAssets: iconAssets ?? this.iconAssets,
        iconBackgroundColor: iconBackgroundColor ?? this.iconBackgroundColor,
      );

  @override
  List<Object?> get props => [
        id,
        type,
        recurringType,
        time,
        message,
        iconAssets,
        iconBackgroundColor,
      ];
}
