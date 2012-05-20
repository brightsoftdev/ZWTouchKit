#import "UIColor+ZWTouchExtensions.h"

@implementation UIColor (ZWTouchExtensions)

+ (UIColor *)colorWithRGB:(NSUInteger)pRGB {
	return [self colorWithRGB:pRGB alpha:1.0];
}
+ (UIColor *)colorWithRGBA:(NSUInteger)pRGBA {
	return [UIColor colorWithRed:(((pRGBA >> 24) & 0xFF) / 255.0) 
						   green:(((pRGBA >> 16) & 0xFF) / 255.0)
							blue:(((pRGBA >> 8) & 0xFF) / 255.0)
						   alpha:(((pRGBA >> 0) & 0xFF) / 255.0)];
}
+ (UIColor *)colorWithRGB:(NSUInteger)pRGB alpha:(CGFloat)pAlpha {
	return [UIColor colorWithRed:(((pRGB >> 16) & 0xFF) / 255.0) 
						   green:(((pRGB >> 8) & 0xFF) / 255.0)
							blue:(((pRGB >> 0) & 0xFF) / 255.0)
						   alpha:pAlpha];
}

@end
