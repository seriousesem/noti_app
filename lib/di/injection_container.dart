import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  // Repository
  // getIt.registerSingleton<WeatherRepository>(
  //     WeatherRepositoryImpl(getIt(), getIt()));
  // UseCases
  // getIt.registerSingleton<FetchWeatherUseCase>(FetchWeatherUseCase(getIt()));
  // Blocs
  // getIt.registerFactory<WeatherBloc>(
  //   () => WeatherBloc(getIt()),
  // );
}
