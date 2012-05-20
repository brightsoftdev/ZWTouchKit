#import <UIKit/UIKit.h>

enum {
	ZWActivityViewStyleNone = 0,
	ZWActivityViewStyleSpinner = 1 << 0,
	ZWActivityViewStyleBox = 1 << 1,
	ZWActivityViewStyleDim = 1 << 2,
};
typedef NSUInteger ZWActivityViewStyle;

@interface ZWActivityView : UIView

#pragma mark - Properties

@property (nonatomic, assign) ZWActivityViewStyle styleMask;
@property (nonatomic, strong) UIColor *dimColor;
@property (nonatomic, strong) UIColor *boxColor;
@property (nonatomic, assign) CGPoint centerOffset;

#pragma mark - Initialization

+ (id)activityViewWithStyle:(ZWActivityViewStyle)pStyleMask;
- (id)initWithStyle:(ZWActivityViewStyle)pStyleMask;

@end
