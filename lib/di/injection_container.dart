import 'package:get_it/get_it.dart';
import 'package:noti_app/presentation/features/login/login_bloc.dart';
import 'package:noti_app/presentation/features/notifications/notifications_bloc.dart';

import '../data/database/database_service.dart';
import '../data/repository/notifications_repository_impl.dart';
import '../domain/repository/notifications_repository.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  // Database
  getIt.registerSingleton<DataBaseService>(
    DataBaseService(),
  );
  // Repository
  getIt.registerSingleton<NotificationsRepository>(
      NotificationsRepositoryImpl(getIt()));
  // Blocs
  getIt.registerSingleton<LoginBloc>(
    LoginBloc(),
  );
  getIt.registerSingleton<NotificationsBloc>(
    NotificationsBloc(getIt()),
  );
}
