#import <UIKit/UIKit.h>


@interface UINavigationController (ZWTouchExtensions)

+ (id)navigationControllerWithRootViewController:(UIViewController *)pViewController;
+ (id)navigationControllerWithRootViewControllerClassName:(NSString *)pClassName nibName:(NSString *)pNibNameOrNil bundle:(NSBundle *)pBundleOrNil;
- (id)pushViewControllerWithClassName:(NSString *)pClassName nibName:(NSString *)pNibNameOrNil bundle:(NSBundle *)pBundleOrNil animated:(BOOL)pAnimated;

@end
