import 'package:get_it/get_it.dart';
import 'package:moordemo/src/database/database/shared.dart';


GetIt locator = GetIt.instance;

Future setupLocator() async {
  locator.registerSingleton(openConnection());
}