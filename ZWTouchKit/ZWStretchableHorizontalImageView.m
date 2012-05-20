#import "ZWStretchableHorizontalImageView.h"
#import "UIImage+ZWTouchExtensions.h"


@implementation ZWStretchableHorizontalImageView

- (void)setImage:(UIImage *)pValue {
	[super setImage:[pValue stretchableHorizontalImage]];
}
- (void)awakeFromNib {
	[super awakeFromNib];
	self.image = self.image;
}

@end
