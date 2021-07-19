import 'package:moordemo/data_provider/database_manager.dart';

abstract class FetchDataState {}

class UserErrorState extends FetchDataState {}

class GetUserLoadingState extends FetchDataState {}

class GetUserCompletedState extends FetchDataState {
  final List<User> userList;

  GetUserCompletedState(this.userList);
}
