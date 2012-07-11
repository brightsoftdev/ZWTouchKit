#import "AppDelegate.h"

@interface AppDelegate() <UIApplicationDelegate> {
	UIWindow *window;
}
@end
@implementation AppDelegate

- (BOOL)application:(UIApplication *)pApplication didFinishLaunchingWithOptions:(NSDictionary *)pLaunchOptions {
    window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    window.backgroundColor = [UIColor whiteColor];
    [window makeKeyAndVisible];
	
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
		[ZWActivityIndicatorController presentInWindow:window];
	});
	
    return YES;
}

@end
