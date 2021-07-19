import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moordemo/bloc/bloc.dart';
import 'package:moordemo/bloc/event.dart';
import 'package:moordemo/bloc/state.dart';
import 'package:moordemo/data_provider/database_manager.dart';
import 'package:moordemo/data_provider/db_helper.dart';

import 'details_page.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _userBloc = GetUserListBloc();

  @override
  void initState() {
    super.initState();
    _userBloc.add(GetUserListEvent());

    shouldRefreshList.stream.listen((event) {
      _userBloc.add(GetUserListEvent());
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        leading: Container(),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              child: Center(
                child: Text(
                  'Add',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailsPage()),
                );
              },
            ),
          )
        ],
      ),
      body: BlocBuilder(
          bloc: _userBloc,
          builder: (context, FetchDataState state) {
            if (state is GetUserCompletedState) {
              return userListView(state.userList);
            } else if (state is GetUserLoadingState) {
              return CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              );
            } else {
              return Container();
            }
          }),
    );
  }

  Widget userListView(List<User> userList) {
    return ListView.builder(
      itemCount: userList.length ?? 0,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.all(10.0),
          child: Container(
            child: Row(
              children: [
                Flexible(
                  flex: 4,
                  child: ListTile(
                    contentPadding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                    title: Text(
                      userList[index].username ?? '',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      userList[index].mail ?? '',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsPage(
                            user: userList[index],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: GestureDetector(
                      child: Text('Delete'),
                      onTap: () async {
                        await deleteUser(userList[index]);
                        shouldRefreshList.sink.add(true);
                      }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
