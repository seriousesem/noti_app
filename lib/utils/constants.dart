abstract class WidgetsText {
  static const String loginScreen = 'Log In';
  static const String notificationsScreen = 'Notifications';
  static const String errorDialog = 'Error';
  static const String loginScreenHint = 'Enter current time in hh : mm format';
  static const String twoDots = ':';
  static const String confirm = 'Confirm';
  static const String oneTime = 'One-time';
  static const String recurring = 'Recurring';
  static const String addNotification = 'Add new notification';
  static const String editNewNotification = 'Edit notification';
  static const String yes = 'Yes';
  static const String time = 'Time: ';
  static const String message = 'Message';
  static const String enterMessage = 'Enter message';
  static const String typeTime = 'Type time';
  static const String icon = 'Icon';
  static const String selectIcon = 'Select icon';
  static const String iconStyle = 'Icon Style';
  static const String saveChanges = 'Save changes';
  static const String backgroundColors = 'Background colors';
  static const String selectIcons = 'Select icons';
}

abstract class AppErrors {
  static const String timeIsWrong = 'The time is wrong. Try again.';
  static const String incorrectTime = 'Incorrect time';
  static const String hoursMustBeLess = 'Hours must be less than 24';
  static const String minutesMustBeLess = 'It should be less than 60 minutes';
  static const String unknownError =
      'An unknown error has occurred, please report this error to support';
}

abstract class NotificationType {
  static const String oneTime = 'one_time';
  static const String recurring = 'Recurring';
}

abstract class RecurringNotificationType {
  static const String oneMinute = '1 Minute';
  static const String threeMinutes = '3 Minutes';
  static const String fiveMinutes = '5 Minutes';
}

abstract class NotificationEntityKey {
  static const String id = 'id';
  static const String type = 'type';
  static const String recurringType = 'recurring_type';
  static const String time = 'time';
  static const String message = 'message';
  static const String iconAssets = 'icon_assets';
  static const String iconBackgroundColor = 'icon_background_color';
}
abstract class MapKey {
  static const String notification = 'notification';
  static const String callBack = 'callBack';
}