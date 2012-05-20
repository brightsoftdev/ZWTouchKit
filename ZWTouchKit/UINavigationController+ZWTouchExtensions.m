#import "UINavigationController+ZWTouchExtensions.h"
#import "UIViewController+ZWTouchExtensions.h"
#import <objc/message.h>


@implementation UINavigationController (ZWTouchExtensions)

+ (id)navigationControllerWithRootViewController:(UIViewController *)pViewController {
	return [[self alloc] initWithRootViewController:pViewController];
}
+ (id)navigationControllerWithRootViewControllerClassName:(NSString *)pClassName nibName:(NSString *)pNibNameOrNil bundle:(NSBundle *)pBundleOrNil {
	return [[self alloc] initWithRootViewController:[NSClassFromString(pClassName) viewControllerWithNibName:pNibNameOrNil bundle:pBundleOrNil]];
}
- (id)pushViewControllerWithClassName:(NSString *)pClassName nibName:(NSString *)pNibNameOrNil bundle:(NSBundle *)pBundleOrNil animated:(BOOL)pAnimated {
	Class c = NSClassFromString(pClassName);
	if(c != nil) {
		id vc = [c alloc];
		if([vc respondsToSelector:@selector(initWithNibName:bundle:)]) {
			vc = objc_msgSend(vc, @selector(initWithNibName:bundle:), ((pNibNameOrNil == nil) ? pClassName : pNibNameOrNil), pBundleOrNil);
		}
		if([vc isKindOfClass:[UIViewController class]]) {
			[self pushViewController:vc animated:pAnimated];
			return vc;
		}
	}
	return nil;
}

@end
