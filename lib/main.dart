import 'package:flutter/material.dart';
import 'package:moordemo/plugin/desktop/desktop.dart';

import 'src/home_page.dart';
import 'data_provider/service_locator.dart';

Future<void> main() async {

  setTargetPlatformForDesktop();

  await setupLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: Home(),
    );
  }
}
