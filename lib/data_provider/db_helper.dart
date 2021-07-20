import 'package:rxdart/rxdart.dart';

import 'database_manager.dart';
import 'service_locator.dart';


PublishSubject<bool> shouldRefreshList = PublishSubject<bool>();

void createUser({String username, String mail}) async {
  User user = User(id: null, username: username, mail: mail);

  await locator<AppDatabase>().insertUser(user);
}

Future<List<User>> fetchUser() async {
  return await locator<AppDatabase>().getAllUsers();
}

Stream<List<User>> watchUsers() {
  return locator<AppDatabase>().watchAllUsers();
}

Future<int> deleteUser(User user) async {
  return await locator<AppDatabase>().deleteUser(user);
}

Future<bool> updateUser(User user) async {
  return await locator<AppDatabase>().updateUser(user);
}