import 'package:flutter/material.dart';
import 'package:modular_permissions/modular_permissions.dart';
import 'package:modular_permissions_example/permission_page.dart';
import 'package:modular_permissions_example/read_write_permission_page.dart';

class PermissionButton extends StatelessWidget {
  final String buttonText;
  final PermissionType permissionType;
  final PermissionRequest permissionRequest;

  final bool hasWritePermissions;
  final PermissionType writePermissionType;
  final PermissionRequest writePermissionRequest;

  PermissionButton(
      {@required this.buttonText,
      @required this.permissionType,
      @required this.permissionRequest,
      bool hasWritePermissions,
      this.writePermissionType,
      this.writePermissionRequest})
      : assert(buttonText != null),
        assert(permissionType != null),
        assert(permissionRequest != null),
        hasWritePermissions = hasWritePermissions ?? false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlineButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0)),
              borderSide: BorderSide(color: Colors.red),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  buttonText,
                  style: Theme.of(context).textTheme.button,
                  textAlign: TextAlign.center,
                ),
              ),
              onPressed: () {
                if (hasWritePermissions) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ReadWritePermissionPage(
                            title: buttonText,
                            readPermissionType: permissionType,
                            readPermissionRequest: permissionRequest,
                            writePermissionRequest: writePermissionRequest,
                            writePermissionType: writePermissionType,
                          )));
                } else {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PermissionPage(
                            title: buttonText,
                            permissionType: permissionType,
                            permissionRequest: permissionRequest,
                          )));
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
