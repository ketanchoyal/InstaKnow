import 'package:get_it/get_it.dart';
import 'package:instaknown/Core/Services/Api.dart';
import 'package:instaknown/Core/ViewModel/HomePageViewModel.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // locator.registerLazySingleton(() => MainPageModel());
  // locator.registerSingleton(Services());

  locator.registerLazySingleton(() => Api());
  locator.registerFactory(() => HomePageViewModel());
}
