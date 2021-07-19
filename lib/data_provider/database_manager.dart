import 'package:moor/moor.dart';

import 'users.dart';

part 'database_manager.g.dart';

@UseMoor(tables: [Users])
class AppDatabase extends _$AppDatabase {
  AppDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) {
        print('onCreate DB!!!');
        print('m.toString() : ${m.toString()}');
        return m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {},
      beforeOpen: (details) async {
        if (details.wasCreated) {
          print('DB was created!!!');
        }
      },
    );
  }

  Future<List<User>> getAllUsers() => select(users).get();

  Stream<List<User>> watchAllUsers() => select(users).watch();

  // Add user
  Future insertUser(User user) => into(users).insert(user);

  // Update user
  Future updateUser(User user) => update(users).replace(user);

  // Delete user
  Future deleteUser(User user) => delete(users).delete(user);
}
