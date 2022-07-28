#import "LodashFlutterPlugin.h"
#if __has_include(<lodash_flutter/lodash_flutter-Swift.h>)
#import <lodash_flutter/lodash_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "lodash_flutter-Swift.h"
#endif

@implementation LodashFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLodashFlutterPlugin registerWithRegistrar:registrar];
}
@end
