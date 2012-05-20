#import "ZWStretchableImageView.h"
#import "UIImage+ZWTouchExtensions.h"


@implementation ZWStretchableImageView

- (void)setImage:(UIImage *)pValue {
	[super setImage:[pValue stretchableImage]];
}
- (void)awakeFromNib {
	[super awakeFromNib];
	self.image = self.image;
}

@end
