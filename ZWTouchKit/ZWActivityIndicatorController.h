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

#pragma mark - Class Properties

+ (ZWActivityIndicatorControllerStyle)defaultStyleMask;
+ (void)setDefaultStyleMask:(ZWActivityIndicatorControllerStyle)pValue;

+ (NSArray *)defaultDimColors;
+ (void)setDefaultDimColors:(NSArray *)pValue;
+ (NSArray *)defaultDimColorsLocations;
+ (void)setDefaultDimColorsLocations:(NSArray *)pValue;
+ (UIColor *)defaultBoxColor;
+ (void)setDefaultBoxColor:(UIColor *)pColor;

#pragma mark - Properties

@property (nonatomic, assign) ZWActivityIndicatorControllerStyle styleMask;
@property (nonatomic, strong) NSArray *dimColors;
@property (nonatomic, strong) NSArray *dimColorsLocations;
@property (nonatomic, strong) UIColor *boxColor;
@property (nonatomic, assign) CGPoint centerOffset;
#pragma mark - Initialization

+ (id)presentInViewController:(UIViewController *)pViewController;
+ (id)presentInViewController:(UIViewController *)pViewController styleMask:(ZWActivityIndicatorControllerStyle)pStyleMask;
+ (void)dismissInViewController:(UIViewController *)pViewController;

+ (id)presentInWindow:(UIWindow *)pWindow;
+ (id)presentInWindow:(UIWindow *)pWindow styleMask:(ZWActivityIndicatorControllerStyle)pStyleMask;
+ (void)dismissInWindow:(UIWindow *)pWindow;

@end
