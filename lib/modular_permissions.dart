
import 'package:flutter/services.dart';

class ModularPermissions {
  static const MethodChannel _channel = MethodChannel('modularPermissions');
  static const MethodChannel _channelLocation = MethodChannel('modularLocationPermissions');
  static const MethodChannel _channelContact = MethodChannel('modularContactPermissions');

  static Future<void> generate() async {
    _channel.invokeMethod("generate");
  }

  static Future<ModularPermissionInfo> checkPermissionStatusByType(
      PermissionType type) async {
    var methodName = 'check${getMethodNameFromType(type)}';
    var channel = getChannelFromType(type);

    try {
      final Map<dynamic, dynamic> requestInfo =
      await channel.invokeMethod(methodName);
      return ModularPermissionInfo(requestInfo['granted'] ?? false, requestInfo['info'] ?? '');
    } catch (err) {
      return ModularPermissionInfo(false,
          '$type request can not be handled. Do you have the correct permission module installed for $type?');
    }
  }

  static Future<ModularPermissionInfo> requestPermissionByType(PermissionType type) async {
    var methodName = 'request${getMethodNameFromType(type)}';
    var channel = getChannelFromType(type);
    print('MethodName: $methodName');
    try {
      final Map<dynamic, dynamic> requestInfo =
      await channel.invokeMethod(methodName);
      return ModularPermissionInfo(requestInfo['granted'] ?? false,
          requestInfo['info'] ?? 'Unable to grant $type');
    } catch (err) {
      return ModularPermissionInfo(false,
          '$type request can not be handled. Do you have the correct permission module installed for $type?');
    }
  }

  static Future<void> openAppSettings() async {
    try {
      await _channel.invokeMethod('openAppSettings');
    } catch (err) {}
  }

  static String getMethodNameFromType(PermissionType type){
    var methodName = "";
    switch (type) {
      case PermissionType.LOCATION_ALWAYS:
      case PermissionType.LOCATION_WHEN_IN_USE:
        methodName = "LocationPermission";
        break;

      case PermissionType.READ_CONTACTS:
        methodName = "ContactPermission";
        break;
      case PermissionType.WRITE_CONTACTS:
        methodName = "WriteContactPermission";
        break;
    }
    return methodName;
  }

  static MethodChannel getChannelFromType(PermissionType type){
    switch(type){
      case PermissionType.LOCATION_ALWAYS:
      case PermissionType.LOCATION_WHEN_IN_USE:
        return _channelLocation;
        break;
      case PermissionType.READ_CONTACTS:
      case PermissionType.WRITE_CONTACTS:
        return _channelContact;
        break;
      default:
        return null;
    }
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

enum PermissionType {
  LOCATION_ALWAYS,
  LOCATION_WHEN_IN_USE,
  READ_CONTACTS,
  WRITE_CONTACTS
}
