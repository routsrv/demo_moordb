import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moordemo/bloc/state.dart';
import 'package:moordemo/data_provider/db_helper.dart';

import 'event.dart';

class GetUserListBloc extends Bloc<FetchDataEvent, FetchDataState> {
  GetUserListBloc() : super(null);

  @override
  Stream<FetchDataState> mapEventToState(FetchDataEvent event) async* {
    if (event is GetUserListEvent) {
      yield GetUserLoadingState();
      try {
        var userList = await fetchUser();
        yield GetUserCompletedState(userList);
      } catch (e) {
        yield UserErrorState();
      }
    }
  }
}
