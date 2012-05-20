#import "UIImageView+ZWTouchExtensions.h"


@implementation UIImageView (ZWTouchExtensions)

+ (id)imageViewWithImage:(UIImage *)pImage {
	return [[self alloc] initWithImage:pImage];
}
+ (id)imageViewWithImageNamed:(NSString *)pImageName {
	return [self imageViewWithImage:[UIImage imageNamed:pImageName]];
}

@end
