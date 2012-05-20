#import "UILabel+ZWTouchExtensions.h"

@implementation UILabel (ZWTouchExtensions)

- (void)sizeWidthToFit {
	if(self.text.length == 0) {
		CGRect f = self.frame;
		f.size.width = 0.0;
		self.frame = f;
	} else {
		CGRect r = [self textRectForBounds:CGRectMake(0, 0, CGFLOAT_MAX, self.frame.size.height) limitedToNumberOfLines:self.numberOfLines];
		CGRect f = self.frame;
		f.size.width = r.size.width;
		self.frame = f;
	}
}
- (void)sizeHeightToFit {
	if(self.text.length == 0) {
		CGRect f = self.frame;
		f.size.height = 0.0;
		self.frame = f;
	} else {
		CGRect r = [self textRectForBounds:CGRectMake(0, 0, self.frame.size.width, CGFLOAT_MAX) limitedToNumberOfLines:self.numberOfLines];
		CGRect f = self.frame;
		f.size.height = r.size.height;
		self.frame = f;
	}
}

@end
