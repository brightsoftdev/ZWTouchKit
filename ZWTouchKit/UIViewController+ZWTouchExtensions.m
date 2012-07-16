#import "UIViewController+ZWTouchExtensions.h"
#import "UIView+ZWTouchExtensions.h"
#import <ZWCoreKit/NSObject+ZWExtensions.h>

id imp_presentingViewController(id self, SEL _cmd, ...);
id imp_presentingViewController(id self, SEL _cmd, ...) {
	return [self parentViewController];
}

@implementation UIViewController (ZWTouchExtensions)

#pragma mark - Load

+ (void)load {
#if !OBJC_ARC_WEAK
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
#endif
		@autoreleasepool {
			if(!iOS5) {
				[self addInstanceMethodForSelector:@selector(presentingViewController)
									implementation:imp_presentingViewController
									 typeEncodings:"@@:"];
			}
		}
#if !OBJC_ARC_WEAK
	});
#endif
}

#pragma mark - Properties

@dynamic isViewLoaded;
@dynamic isViewVisible;
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_5_0 || __IPHONE_OS_VERSION_MAX_ALLOWED <= __IPHONE_4_3
@dynamic presentingViewController;
#endif

+ (id)viewController {
	return [self viewControllerWithNibName:NSStringFromClass([self class]) bundle:nil];
}
+ (id)viewControllerWithNibName:(NSString *)pNibNameOrNil bundle:(NSBundle *)pNibBundleOrNil {
	return [[self alloc] initWithNibName:pNibNameOrNil bundle:pNibBundleOrNil];
}

- (id)presentModalViewControllerWithClassName:(NSString *)pClassName nibName:(NSString *)pNibNameOrNil bundle:(NSBundle *)pBundleOrNil animated:(BOOL)pAnimated {
	Class instantiateClass = NSClassFromString(pClassName);
	if(instantiateClass == nil) {
		return nil;
	}
	UIViewController *vc = (UIViewController *)[[instantiateClass alloc] initWithNibName:((pNibNameOrNil == nil) ? pClassName : pNibNameOrNil)
																				  bundle:pBundleOrNil];
	if(vc == nil) {
		return nil;
	}
	[self presentModalViewController:vc animated:pAnimated];
	return vc;
}

- (BOOL)isViewVisible {
	if([self isViewLoaded]) {
		return (self.view.window != nil && self.view.superview != nil);
	}
	return NO;
}

- (void)dismissModalViewControllerWithoutAnimation:(id)pSender {
	[self.presentingViewController dismissModalViewControllerAnimated:NO];
}
- (void)dismissModalViewControllerWithAnimation:(id)pSender {
	[self.presentingViewController dismissModalViewControllerAnimated:YES];
}

@end
