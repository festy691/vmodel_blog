import 'package:blog/core/data/session_manager.dart';
import 'package:blog/core/network/url_config.dart';
import 'package:blog/core/services/news_service.dart';
import 'package:blog/core/state_managers/news_provider.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init({required Environment environment}) async {
  UrlConfig.environment = environment;
  await initCore();
  initProviders();
  await initServices();
}

Future<void> initCore() async {
  final sessionManager = SessionManager();
  await sessionManager.init();
  sl.registerLazySingleton<SessionManager>(() => sessionManager);
}

void initProviders() {
  sl.registerFactory(() => NewsProvider(sl()));
}

Future<void> initServices() async {
  sl.registerFactory<NewsService>(() => NewsService());
}
