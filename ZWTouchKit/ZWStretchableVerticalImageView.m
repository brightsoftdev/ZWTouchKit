#import "ZWStretchableVerticalImageView.h"
#import "UIImage+ZWTouchExtensions.h"


@implementation ZWStretchableVerticalImageView

- (void)setImage:(UIImage *)pValue {
	[super setImage:[pValue strechableVerticalImage]];
}
- (void)awakeFromNib {
	[super awakeFromNib];
	self.image = self.image;
}

@end
