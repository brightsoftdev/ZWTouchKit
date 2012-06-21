#import "ZWStretchableVerticalImageView.h"
#import "UIImage+ZWTouchExtensions.h"


@implementation ZWStretchableVerticalImageView

- (void)setImage:(UIImage *)pValue {
	[super setImage:[pValue stretchableVerticalImage]];
}
- (void)awakeFromNib {
	[super awakeFromNib];
	self.image = self.image;
}

@end
