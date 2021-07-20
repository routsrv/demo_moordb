import 'package:flutter/material.dart';
import 'package:moordemo/data_provider/database_manager.dart';
import 'package:moordemo/data_provider/db_helper.dart';

import 'details_page.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
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
      body: userListView(),
    );
  }

  Widget userListView() {
    return StreamBuilder(
        stream: watchUsers(),
        builder: (context, AsyncSnapshot<List<User>> snapshot) {
          return (snapshot.data != null && snapshot.data.length > 0)
              ? ListView.builder(
                  itemCount: snapshot.data.length ?? 0,
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
                                  snapshot.data[index].username ?? '',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                                subtitle: Text(
                                  snapshot.data[index].mail ?? '',
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
                                        user: snapshot.data[index],
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
                                    await deleteUser(snapshot.data[index]);
                                    shouldRefreshList.sink.add(true);
                                  }),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : Center(child: Text('No User found'));
        });
  }
}
