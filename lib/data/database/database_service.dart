import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../utils/constants.dart';
import '../entity/notifications/notification_entity.dart';

class DataBaseService {
  static const _databaseVersion = 1;
  static const _databaseName = 'noti.db';
  static const _tableName = 'notifications_table';
  static const _columnId = NotificationEntityKeys.id;
  static const _columnType = NotificationEntityKeys.type;
  static const _columnRecurringType = NotificationEntityKeys.recurringType;
  static const _columnTime = NotificationEntityKeys.time;
  static const _columnMessage = NotificationEntityKeys.message;
  static const _columnIconAssets = NotificationEntityKeys.iconAssets;
  static const _columnIconBackgroundColor =
      NotificationEntityKeys.iconBackgroundColor;
  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, _) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            $_columnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
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
  }

  Future<List<NotificationEntity>> getAllNotifications() async {
    final db = await database;
    final List<Map<String, dynamic>> resultMaps = await db.query(_tableName);
    if (resultMaps.isEmpty) {
      return List.empty();
    }
    return List.generate(resultMaps.length,
        (index) => NotificationEntity.fromMap(resultMaps[index]));
  }

  Future<int> insertNotification(NotificationEntity notificationEntity) async {
    final db = await database;
    return await db.insert(
      _tableName,
      notificationEntity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateNotification(NotificationEntity notificationEntity) async {
    final db = await database;
    return await db.update(
      _tableName,
      notificationEntity.toMap(),
      where: '$_columnId = ?',
      whereArgs: [notificationEntity.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> deleteNotification(NotificationEntity notificationEntity) async {
    final db = await database;
    return await db.delete(
      _tableName,
      where: '$_columnId = ?',
      whereArgs: [notificationEntity.id],
    );
  }
}
