import 'package:flutter/material.dart';
import 'package:modular_permissions/modular_permissions.dart';
import 'package:modular_permissions_example/permission_page.dart';

class PermissionButton extends StatelessWidget {
  final String buttonText;
  final PermissionType permissionType;
  final PermissionRequest permissionRequest;

  PermissionButton(
      {@required this.buttonText,
      @required this.permissionType,
      @required this.permissionRequest})
      : assert(buttonText != null),
        assert(permissionType != null),
        assert(permissionRequest != null);

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
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PermissionPage(
                          title: buttonText,
                          permissionType: permissionType,
                          permissionRequest: permissionRequest,
                        )));
              },
            ),
          ),
        ),
      ],
    );
  }
}
