import 'package:flutter/material.dart';
import 'package:modular_permissions/modular_permissions.dart';
import 'package:modular_permissions_example/permission_button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Modular Flutter Permissions'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            PermissionButton(
                buttonText: 'Location Permission Example',
                permissionType: PermissionType.LOCATION_WHEN_IN_USE,
                permissionRequest: LocationWhenInUsePermissionRequest()),
            PermissionButton(
                buttonText: 'Microphone Permission Example',
                permissionType: PermissionType.USE_MICROPHONE,
                permissionRequest: UseMicrophonePermissionRequest()),
            PermissionButton(
              buttonText: 'Contact Permission Example',
              permissionType: PermissionType.CONTACTS,
              permissionRequest: ContactsPermissionRequest(),
              hasWritePermissions: true,
              writePermissionType: PermissionType.WRITE_CONTACTS,
              writePermissionRequest: WriteContactsPermissionRequest(),
            ),
          ],
        ),
      ),
    );
  }
}
