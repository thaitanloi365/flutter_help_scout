import 'package:flutter/material.dart';
import 'package:flutter_help_scout/flutter_help_scout.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    FlutterHelpScout.init('12cb2b55-5ff1-4852-8aef-90e0294460ef');
    FlutterHelpScout.identify(
        email: "thaitanloi365@gmail.com",
        name: "test",
        attributes: {
          "appVersion": "1.0.0",
          "token": "aaaa",
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            FlatButton(
              child: Text("Open"),
              onPressed: () => FlutterHelpScout.open(),
            ),
            FlatButton(
              child: Text("Logout"),
              onPressed: () => FlutterHelpScout.logout(),
            )
          ],
        )),
      ),
    );
  }
}
