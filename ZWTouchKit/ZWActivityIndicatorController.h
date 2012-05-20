#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


enum {
	ZWActivityIndicatorControllerStyleNone = 0,
	ZWActivityIndicatorControllerStyleBox = 1 << 0,
	ZWActivityIndicatorControllerStyleDim = 1 << 1,
};
typedef NSUInteger ZWActivityIndicatorControllerStyle;

@interface ZWActivityIndicatorController : NSObject {
}

#pragma mark - Properties

@property (nonatomic, assign) ZWActivityIndicatorControllerStyle styleMask;
@property (nonatomic, strong) UIColor *dimColor;
@property (nonatomic, strong) UIColor *boxColor;
@property (nonatomic, assign) CGPoint centerOffset;

+ (ZWActivityIndicatorControllerStyle)defaultStyleMask;
+ (void)setDefaultStyleMask:(ZWActivityIndicatorControllerStyle)pValue;

#pragma mark - Initialization

+ (id)presentInViewController:(UIViewController *)pViewController;
+ (id)presentInViewController:(UIViewController *)pViewController styleMask:(ZWActivityIndicatorControllerStyle)pStyleMask;
+ (void)dismissInViewController:(UIViewController *)pViewController;

+ (id)presentInWindow:(UIWindow *)pWindow;
+ (id)presentInWindow:(UIWindow *)pWindow styleMask:(ZWActivityIndicatorControllerStyle)pStyleMask;
+ (void)dismissInWindow:(UIWindow *)pWindow;

@end
