abstract class Titles {
  static const String loginScreen = 'Log In';
  static const String notificationsScreen = 'Notifications';
  static const String errorDialog = 'Error';
}

abstract class WidgetsText {
  static const String loginScreenHint = 'Enter current time in hh : mm format';
  static const String twoDots = ':';
  static const String confirm = 'Confirm';
  static const String oneTime = 'One-time';
  static const String recurring = 'Recurring';
  static const String addNewNotification = 'Add new notification';
  static const String yes = 'Yes';
  static const String time = 'Time: ';
  static const String message = 'Message: ';
}

abstract class AppErrors {
  static const String timeIsWrong = 'The time is wrong. Try again.';
  static const String unknownError =
      'An unknown error has occurred, please report this error to support';
}

abstract class NotificationsTypes {
  static const String oneTime = 'one_time';
  static const String recurring = 'Recurring';
}

abstract class RecurringNotificationTypes {
  static const String oneMinute = '1 Minute';
  static const String threeMinutes = '3 Minutes';
  static const String fiveMinutes = '5 Minutes';
}

abstract class NotificationEntityKeys {
  static const String id = 'id';
  static const String type = 'type';
  static const String recurringType = 'recurring_type';
  static const String time = 'time';
  static const String message = 'message';
  static const String iconAssets = 'icon_assets';
  static const String iconBackgroundColor = 'icon_background_color';
}