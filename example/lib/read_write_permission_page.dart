import 'package:flutter/material.dart';
import 'package:modular_permissions/modular_permissions.dart';

class ReadWritePermissionPage extends StatefulWidget {
  final String title;
  final PermissionType readPermissionType;
  final PermissionRequest readPermissionRequest;
  final PermissionType writePermissionType;
  final PermissionRequest writePermissionRequest;

  ReadWritePermissionPage(
      {this.title,
      this.readPermissionType,
      this.readPermissionRequest,
      this.writePermissionType,
      this.writePermissionRequest});

  @override
  _ReadWritePermissionPageState createState() =>
      _ReadWritePermissionPageState();
}

class _ReadWritePermissionPageState extends State<ReadWritePermissionPage> {
  ModularPermissionInfo _modularPermissionInfo =
      ModularPermissionInfo(false, 'Unknown');
  ModularPermissionInfo _modularWritePermissionInfo =
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
                  'Check ${widget.readPermissionType.name} Permission',
                  style: Theme.of(context).textTheme.button,
                  textAlign: TextAlign.center,
                ),
              ),
              onPressed: () async {
                final info = await ModularPermissions.checkPermissionStatus(
                    widget.readPermissionRequest);
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
                  'Request ${widget.readPermissionType.name} Permission',
                  style: Theme.of(context).textTheme.button,
                  textAlign: TextAlign.center,
                ),
              ),
              onPressed: () async {
                final info = await ModularPermissions.requestPermission(
                    widget.readPermissionRequest);
                setState(() {
                  _modularPermissionInfo = info;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${widget.readPermissionType.name} Permission is ${_modularPermissionInfo.granted ? 'granted' : 'not granted'} with \n${_modularPermissionInfo.info}',
                textAlign: TextAlign.center,
              ),
            ),
///WRITE SECTION
            OutlineButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0)),
              borderSide: BorderSide(color: Colors.red),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Check ${widget.writePermissionType.name} Permission',
                  style: Theme.of(context).textTheme.button,
                  textAlign: TextAlign.center,
                ),
              ),
              onPressed: () async {
                final info = await ModularPermissions.checkPermissionStatus(
                    widget.writePermissionRequest);
                setState(() {
                  _modularWritePermissionInfo = info;
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
                  'Request ${widget.writePermissionType.name} Permission',
                  style: Theme.of(context).textTheme.button,
                  textAlign: TextAlign.center,
                ),
              ),
              onPressed: () async {
                final info = await ModularPermissions.requestPermission(
                    widget.writePermissionRequest);
                setState(() {
                  _modularWritePermissionInfo = info;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${widget.writePermissionType.name} Permission is ${_modularWritePermissionInfo.granted ? 'granted' : 'not granted'} with \n${_modularWritePermissionInfo.info}',
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
