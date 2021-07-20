import 'package:flutter/material.dart';
import 'package:moordemo/data_provider/database_manager.dart';

import '../data_provider/db_helper.dart';
import 'custom_textfield.dart';

class DetailsPage extends StatefulWidget {
  final User user;

  const DetailsPage({Key key, this.user}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final usernameController = TextEditingController();
  final mailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      usernameController.text = widget.user.username;
      mailController.text = widget.user.mail;
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    mailController.dispose();
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
                  'Close',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: MediaQuery.of(context).size.height),
            child: Center(
              child: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //user name
                      Padding(
                        padding: EdgeInsets.only(
                            top: 0.0, bottom: 0.0, left: 30.0, right: 30.0),
                        child: CustomTextField(
                          hintText: 'Username',
                          controller: usernameController,
                        ),
                      ),
                      //mail
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 0.0, left: 30.0, right: 30.0),
                        child: CustomTextField(
                          hintText: 'Mail',
                          controller: mailController,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 50.0, bottom: 0.0, right: 50.0, left: 50.0),
                        child: RaisedButton(
                          onPressed: () async {
                            if (widget.user != null) {
                              final newUSer = User(
                                  id: widget.user.id,
                                  username: usernameController.text,
                                  mail: mailController.text);
                              await updateUser(newUSer);
                            } else {
                              createUser(
                                username: usernameController.text,
                                mail: mailController.text,
                              );
                            }
                            Navigator.pop(context);
                          },
                          child: Text(
                              widget.user != null ? 'Update User' : 'Add User',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
