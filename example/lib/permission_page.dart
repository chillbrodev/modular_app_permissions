import 'package:flutter/material.dart';
import 'package:modular_permissions/modular_permissions.dart';

class PermissionPage extends StatefulWidget {
  final String title;
  final PermissionType permissionType;
  final PermissionRequest permissionRequest;

  PermissionPage({this.title, this.permissionType, this.permissionRequest});

  @override
  _PermissionPageState createState() => _PermissionPageState();
}

class _PermissionPageState extends State<PermissionPage> {
  ModularPermissionInfo _modularPermissionInfo =
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
                  'Check ${widget.permissionType.name} Permission',
                  style: Theme.of(context).textTheme.button,
                  textAlign: TextAlign.center,
                ),
              ),
              onPressed: () async {
                final info = await ModularPermissions.checkPermissionStatus(
                    widget.permissionRequest);
                setState(() {
                  _modularPermissionInfo = info;
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
                  'Request ${widget.permissionType.name} Permission',
                  style: Theme.of(context).textTheme.button,
                  textAlign: TextAlign.center,
                ),
              ),
              onPressed: () async {
                final info = await ModularPermissions.requestPermission(
                    widget.permissionRequest);
                setState(() {
                  _modularPermissionInfo = info;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${widget.permissionType.name} Permission is ${_modularPermissionInfo.granted ? 'granted' : 'not granted'} with \n${_modularPermissionInfo.info}',
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
