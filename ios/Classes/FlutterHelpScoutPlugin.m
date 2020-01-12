#import "FlutterHelpScoutPlugin.h"
#import <flutter_help_scout/flutter_help_scout-Swift.h>

@implementation FlutterHelpScoutPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterHelpScoutPlugin registerWithRegistrar:registrar];
}
@end
