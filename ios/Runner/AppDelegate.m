#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import "GoogleMaps/GoogleMaps.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  [GMSServices provideAPIKey: @"AIzaSyCm3GkrQWPQbkBuf_UJebHWk0hM4011H3M"];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
