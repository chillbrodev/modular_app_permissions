import 'package:flutter/material.dart';
import 'package:modular_permissions/modular_permissions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Modular Flutter Permissions'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ModularPermissionInfo _locationPermissionStatus =
      ModularPermissionInfo(false, 'Unknown');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OutlineButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0)),
              borderSide: BorderSide(color: Colors.red),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Check Location Permission',
                  style: Theme.of(context).textTheme.button,
                  textAlign: TextAlign.center,
                ),
              ),
              onPressed: () async {
                final info = await ModularPermissions.checkPermissionStatus(
                    LocationWhenInUsePermissionRequest());
                setState(() {
                  _locationPermissionStatus = info;
                });
              },
            ),
            OutlineButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0)),
              borderSide: BorderSide(color: Colors.red),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Request Location Permission',
                  style: Theme.of(context).textTheme.button,
                  textAlign: TextAlign.center,
                ),
              ),
              onPressed: () async {
                final info = await ModularPermissions.requestPermission(
                    LocationWhenInUsePermissionRequest());
                setState(() {
                  _locationPermissionStatus = info;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Location Permission is ${_locationPermissionStatus.granted ? 'granted' : 'not granted'} with \n${_locationPermissionStatus.info}',
                textAlign: TextAlign.center,
              ),
            ),
            OutlineButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0)),
              borderSide: BorderSide(color: Colors.red),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Open App Settings',
                  style: Theme.of(context).textTheme.button,
                  textAlign: TextAlign.center,
                ),
              ),
              onPressed: () async {
                await ModularPermissions.openAppSettings();
              },
            ),
          ],
        ),
      ),
    );
  }
}
