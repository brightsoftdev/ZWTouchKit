#import "UIDevice+ZWTouchExtensions.h"

@implementation UIDevice (ZWTouchExtensions)

@dynamic phoneSupported;

- (BOOL)isPhoneSupported {
	return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://5555555555"]];
}

@end
