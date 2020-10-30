import 'package:flutter/services.dart';

class ModularPermissions {
  static const MethodChannel _channelLocation =
      MethodChannel('ch.upte.modularLocationPermissions');

  static const MethodChannel _channelSelf =
      MethodChannel('ch.upte.modular_permissions');

  static const String _UNKNOWN = "unknown";
  static const String _NOT_GRANTED = "not_granted";
  static const String _DENIED = "denied";
  static const String _RESTRICTED = "restricted";
  static const String _GRANTED = "granted";

  static Future<ModularPermissionInfo> checkPermissionStatus(
      PermissionRequest request) async {
    var methodName = 'check${_getMethodNameFromType(request.permissionType)}';
    var channel = _getChannelFromType(request.permissionType);

    try {
      //Arguments are ignored in Android
      //Arguments are used in iOS only for Location
      final String result = await channel
          .invokeMethod(methodName, {'permissionArgs': request.arguments});
      return _permissionInfoFromType(request.permissionType, result);
    } catch (err) {
      return _handleError(err, request);
    }
  }

  static Future<ModularPermissionInfo> requestPermission(
      PermissionRequest request) async {
    var methodName = 'request${_getMethodNameFromType(request.permissionType)}';
    var channel = _getChannelFromType(request.permissionType);
    try {
      //Arguments are ignored in Android
      //Arguments are used in iOS only for Location
      final String result = await channel
          .invokeMethod(methodName, {'permissionArgs': request.arguments});
      return _permissionInfoFromType(request.permissionType, result);
    } catch (err) {
      return _handleError(err, request);
    }
  }

  static Future<void> openAppSettings() async {
    try {
      //On iOS this will open root settings. Limitation of iOS
      //On Android this will open the specific app's settings page.
      await _channelSelf.invokeMethod('openAppSettings');
    } catch (err) {}
  }

  static String _getMethodNameFromType(PermissionType type) {
    var methodName = "";
    switch (type) {
      case PermissionType.LOCATION_ALWAYS:
      case PermissionType.LOCATION_WHEN_IN_USE:
        methodName = "LocationPermission";
        break;
    }
    return methodName;
  }

  static MethodChannel _getChannelFromType(PermissionType type) {
    switch (type) {
      case PermissionType.LOCATION_ALWAYS:
      case PermissionType.LOCATION_WHEN_IN_USE:
        return _channelLocation;
        break;
      default:
        return null;
    }
  }

  static ModularPermissionInfo _permissionInfoFromType(
      PermissionType type, String result) {
    String permissionName = '';
    switch (type) {
      case PermissionType.LOCATION_ALWAYS:
      case PermissionType.LOCATION_WHEN_IN_USE:
        permissionName = 'Location';
        break;
    }
    return _handleResultForPermission(permissionName, result);
  }

  static ModularPermissionInfo _handleResultForPermission(String permissionName, String result) {
    switch (result) {
      case _DENIED:
        return ModularPermissionInfo(
            false, "The $permissionName permission request was denied.");
      case _RESTRICTED:
        return ModularPermissionInfo(false,
            "The $permissionName permission request was permanently denied or restricted.");
      case _GRANTED:
        return ModularPermissionInfo(
            true, "The $permissionName permission request was granted.");
      case _NOT_GRANTED:
        return ModularPermissionInfo(
            false, "The $permissionName permission is not granted");
      case _UNKNOWN:
      default:
        return ModularPermissionInfo(
            false, "Unable to determine status of $permissionName permission request");
    }
  }

  static ModularPermissionInfo _handleError(
      dynamic error, PermissionRequest request) {
    print(error.toString());
    return ModularPermissionInfo(false,
        '${request.permissionType} request can not be handled. Do you have the correct permission module installed for ${request.permissionType}?');
  }
}

class ModularPermissionInfo {
  final bool granted;
  final String info;

  ModularPermissionInfo(this.granted, this.info);

  @override
  String toString() {
    return 'ModularPermissionInfo{granted: $granted, info: $info}';
  }
}

abstract class PermissionRequest {
  PermissionType permissionType;
  String arguments;
}

enum PermissionType {
  LOCATION_ALWAYS, //Android = FINE_LOCATION
  LOCATION_WHEN_IN_USE, //Android = FINE_LOCATION
}

class LocationAlwaysPermissionRequest extends PermissionRequest {
  @override
  PermissionType get permissionType => PermissionType.LOCATION_ALWAYS;

  @override
  String get arguments => "LocationAlways";
}

class LocationWhenInUsePermissionRequest extends PermissionRequest {
  @override
  PermissionType get permissionType => PermissionType.LOCATION_WHEN_IN_USE;

  @override
  String get arguments => "LocationWhenInUse";
}
