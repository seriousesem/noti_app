import 'package:get_it/get_it.dart';
import 'package:noti_app/presentation/features/login/login_bloc.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  // Repository
  // getIt.registerSingleton<WeatherRepository>(
  //     WeatherRepositoryImpl(getIt(), getIt()));
  // UseCases
  // getIt.registerSingleton<FetchWeatherUseCase>(FetchWeatherUseCase(getIt()));
  // Blocs
  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(),
  );
}
