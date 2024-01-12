import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../utils/constants.dart';
import '../entity/notifications/notification_entity.dart';

class DataBaseService {
  static const _databaseVersion = 1;
  static const _databaseName = 'noti.db';
  static const _tableName = 'notifications_table';
  static const _columnId = NotificationEntityKey.id;
  static const _columnType = NotificationEntityKey.type;
  static const _columnRecurringType = NotificationEntityKey.recurringType;
  static const _columnTime = NotificationEntityKey.time;
  static const _columnMessage = NotificationEntityKey.message;
  static const _columnIconAssets = NotificationEntityKey.iconAssets;
  static const _columnIconBackgroundColor =
      NotificationEntityKey.iconBackgroundColor;
  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    try {
      return openDatabase(
        join(await getDatabasesPath(), _databaseName),
        onCreate: (db, _) async {
          await db.execute('''
          CREATE TABLE $_tableName (
            $_columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $_columnType TEXT NOT NULL,
            $_columnRecurringType TEXT,
            $_columnTime TEXT NOT NULL,
            $_columnMessage TEXT NOT NULL,
            $_columnIconAssets TEXT,
            $_columnIconBackgroundColor TEXT
          )
        ''');
        },
        version: _databaseVersion,
      );
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<NotificationEntity>> getAllNotifications() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> resultMaps = await db.query(_tableName);
      if (resultMaps.isEmpty) {
        return List.empty();
      }
      return List.generate(resultMaps.length,
          (index) => NotificationEntity.fromMap(resultMaps[index]));
    } catch (e) {
      throw e.toString();
    }
  }

  Future<int> insertNotification(NotificationEntity notificationEntity) async {
    try {
      final db = await database;
      return await db.insert(
        _tableName,
        notificationEntity.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw e.toString();
    }
  }

  Future<int> updateNotification(NotificationEntity notificationEntity) async {
    try {
      final db = await database;
      return await db.update(
        _tableName,
        notificationEntity.toMap(),
        where: '$_columnId = ?',
        whereArgs: [notificationEntity.id],
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw e.toString();
    }
  }

  Future<int> deleteNotification(NotificationEntity notificationEntity) async {
    try {
      final db = await database;
      return await db.delete(
        _tableName,
        where: '$_columnId = ?',
        whereArgs: [notificationEntity.id],
      );
    } catch (e) {
      throw e.toString();
    }
  }
}
