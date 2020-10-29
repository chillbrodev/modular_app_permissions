# modular_permissions

Modular permission plugin to request native (Android, iOS) permissions. Checkout the example to get started.

## Plugin Info

The Modular Permissions Plugin allows developers to seamlessly request mobile permissions at runtime.
Instead of packing the library with all the permissions then asking the developer to strip out what 
isn't need, this plugin takes the opposite approach by including only what is needed. Developers
include this plugin as the core entry point then include the sub module plugins for each individual
permission. 

For example:
    - A developer needs the Location permission so they include this plugin as well as
    the plugin [modular_location_permissions](https://pub.dev/packages/modular_location_permission). To check to see if the permissions is granted, The
    developer can call `checkPermissionStatus` with a `LocationAlwaysPermissionRequest` or a 
    `LocationWhenInUsePermissionRequest`. Similarly to request the permission the developer just calls
    `requestPermission` with one of the above PermissionRequests and the plugin will request the Location
    Permission. 

This approach allows the developer to have confidence that they are only including logic for the
location permission and no other permissions. 

## Functionality
NOTE: If the requested permission module is not installed correctly, you will see a *MissingPluginException* in the logs:
Example: `MissingPluginException(No implementation found for method checkLocationPermission on channel ch.upte.modularLocationPermissions)`

- checkPermissionStatus(PermissionRequest request): 
Checks the status of the permission request by returning an object called ModularPermissionInfo which
includes whether or not the permission was granted and any additional information.

- requestPermission(PermissionRequest request): 
Requests the specified permission and handles the native logic in order to facilitate the request to
the user. Returns an object called ModularPermissionInfo which includes whether or not the permission
was granted and any additional information.

- openAppSettings(PermissionRequest permissionRequest): 
This opens up the app's settings page

## Supported Permissions
- Location:
    - Android: Access Fine Location
    - iOS: When in use or Always
    
- Additional permission support is in development

## Permission Information

On mobile (Android, iOS) developers have to request permission from the user to access certain 
features at runtime. These permissions typically include the user's Location, the user's Contacts or 
a plethora of others. This plugin provides a cross-platform (Android, iOS) API to request permissions 
and check their status. You can also open the device's app settings so users can manually grant
a permission.

## Known Flutter Permission Issues

Flutter is no longer able to utilize these all in one permission solutions as they can cause your
app to be rejected from the App Store or list a multitude of un-used permissions thus confusing the
user about your app's intent. Flutter is designed to abstract away the details of the native platforms 
and empower developers with a solution for to deploy to multiple platforms with ease. The plugins 
that we developers use, should have that same design. Which is why we developed this Modular Permissions Plugin.
