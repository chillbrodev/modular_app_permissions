# Contributing to Modular App Permissions Plugin

## Welcome

Thank you for your interest in contributing to the modular permission suite! Everyone is welcome to contribute code via pull requests, file issues on GitHub, help triage, reproduce or fix bugs that have been reported or add support for additional permissions. By contributing, you agree to [UpTech's code of conduct](CODE_OF_CONDUCT.md).

## Supporting new permissions

Our goal is to support every permission that requires direct user interaction. It is fantastic that you are interested in helping us achieve this goal. To get started, you should familiarize yourself with the repo and the [modular_location_permission](https://pub.dev/packages/modular_location_permission) plugin. These repos will help you understand the contracts that are in place to facilitate this modularity. You will need to create a repo that contains your permission implementation and fork and submit a PR to the main modular app permissions repo to support your new permission.

## Dart to Native Contract

When creating a new modular permission plugin, you must adhere to the following API. Failure to do so will result in invalid usage, and Modular Permissions will not support your plugin. For the sake of this guide, let's assume we are developing a plugin to include the new Unicorn permission. 

### Method Channel
Your module must use a method channel with the name ch.upte.modular[permissionType]Permissions. Referring to our Unicorn permission, our method channel would be `ch.upte.modularUnicornPermissions`. This structure helps organize the method channels used and prevents any conflicts with other plugins.

### Function API
Your module must include the following functions concerning the information passed back in the Method Result. Remember that we are using the imaginary Unicorn permission for the examples.

**Status Definitions**
"unknown"
"not_granted"
"denied"
"restricted"
"granted"

`checkUnicornPermission` must either return "granted" or "denied".
`requestUnicornPermission` must return "granted" if the permission has been granted. This function must initiate the permission request flow if the user does not consent.
You may include any of the other status definitions as you see fit.

In our case, the Unicorn permission does not require additional configuration arguments. Still, if the permission you are adding support for does, you must handle these arguments in each of your functions. It would help if you documented these arguments and what they are required. This information will is needed when adding support to the Modular App Permissions repo.

For Android permissions, you must include the *uses-permission* in your plugin's AndroidManifest.xml.
For iOS permissions, you must document the required NSUSAGE key(s) in your plugin's README.MD.
Failure to do the above will cause your PR to be rejected.

## Modular App Permissions Support
After you have created your sweet permission plugin, you are now ready to add the support to the main plugin. This support is pretty simple; you will need your `method channel name` and the information for any optional arguments.

Open up `modular_permissions.dart` in the Modular App Permissions repo and include a new channel definition at the top of the file near the others. Ensure you follow the naming conventions of the others. In our case, we would add the following code:

```dart
static const MethodChannel _channelUnicorn =
      MethodChannel('ch.upte.modularUnicornPermissions');
```

Add a new enum value to the `PermissionType.` This is demonstrated with a before and after block.
**Before:**
```dart
enum PermissionType {
  LOCATION_ALWAYS, //Android = FINE_LOCATION
  LOCATION_WHEN_IN_USE, //Android = FINE_LOCATION
}    
```
**After:**
```dart
enum PermissionType {
  LOCATION_ALWAYS, //Android = FINE_LOCATION
  LOCATION_WHEN_IN_USE, //Android = FINE_LOCATION
  UNICORN,
}
```
You will need to handle your new enum in the following functions.
- _getMethodNameFromType(PermissionType type): takes in an enum and returns a methodName. For our Unicorn example this function would return **UnicornPermission**
- _getChannelFromType(PermissionType type): takes in an enum and returns a methodChannel. For our Unicorn example, this function would return **_channelUnicorn**, which we defined at the top of the file.

Then extend the `PermissionRequest` abstract class to include your new permission.
```dart
class UnicornPermissionRequest extends PermissionRequest {
  @override
  PermissionType get permissionType => PermissionType.UNICORN;

  //This can return an empty string if arguments are unused.
  @override
  String get arguments => "UnicornArgs"; 
}
```

Finally, we need to transform the result from our new Unicorn plugin module to a ModularPermissionInfo object. We do this by including our new Unicorn enum and returning the string Unicorn. This is shown below using the before and after blocks.
**Before:**
```dart
  static ModularPermissionInfo _permissionInfoFromType(PermissionType type, String result) {
    String permissionName = '';
    switch (type) {
      case PermissionType.LOCATION_ALWAYS:
      case PermissionType.LOCATION_WHEN_IN_USE:
        permissionName = 'Location';
        break;
    }
    return _handleResultForPermission(permissionName, result);
  }
```
**After:**
```dart
  static ModularPermissionInfo _permissionInfoFromType(PermissionType type, String result) {
    String permissionName = '';
    switch (type) {
      case PermissionType.LOCATION_ALWAYS:
      case PermissionType.LOCATION_WHEN_IN_USE:
        permissionName = 'Location';
        break;
      case PermissionType.UNICORN:
        permissionName = 'Unicorn';
        break;
    }
    return _handleResultForPermission(permissionName, result);
  }
```

Once you have included the above functionality for your new permission, please open up a PR that consists of a link to your new permission plugin. An UpTech employee will review your PR along with your new permission plugin repo. The UpTech reviewer will provide information or change requests on your PR. If your PR is approved, UpTech will include your new permission repo on our approved permission list and reach out to get your new repo published on pub.dev. Once again, thank you for learning how to contribute to the Modular App Permissions. 