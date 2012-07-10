#import <UIKit/UIKit.h>


@interface UIViewController (ZWTouchExtensions)

@property (nonatomic, readonly) BOOL isViewLoaded;
@property (nonatomic, readonly) BOOL isViewVisible;
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_5_0 || __IPHONE_OS_VERSION_MAX_ALLOWED <= __IPHONE_4_3
@property(nonatomic,readonly) UIViewController *presentingViewController;
#endif

+ (id)viewController;
+ (id)viewControllerWithNibName:(NSString *)pNibNameOrNil bundle:(NSBundle *)pNibBundleOrNil;

- (id)presentModalViewControllerWithClassName:(NSString *)pClassName nibName:(NSString *)pNibNameOrNil bundle:(NSBundle *)pBundleOrNil animated:(BOOL)pAnimated;

- (void)dismissModalViewControllerWithoutAnimation:(id)pSender;
- (void)dismissModalViewControllerWithAnimation:(id)pSender;

@end
