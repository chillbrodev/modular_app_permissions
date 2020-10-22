#import "ModularPermissionsPlugin.h"
#if __has_include(<modular_permissions/modular_permissions-Swift.h>)
#import <modular_permissions/modular_permissions-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "modular_permissions-Swift.h"
#endif

@implementation ModularPermissionsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftModularPermissionsPlugin registerWithRegistrar:registrar];
}
@end
