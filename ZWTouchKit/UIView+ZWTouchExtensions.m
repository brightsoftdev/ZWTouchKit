#import "UIView+ZWTouchExtensions.h"
#import <ZWCoreKit/NSArray+ZWExtensions.h>

UIViewAutoresizing UIViewAutoresizingMaskAll() {
	return (UIViewAutoresizingFlexibleWidth |
			UIViewAutoresizingFlexibleHeight |
			UIViewAutoresizingFlexibleTopMargin |
			UIViewAutoresizingFlexibleBottomMargin |
			UIViewAutoresizingFlexibleLeftMargin |
			UIViewAutoresizingFlexibleRightMargin);
}

@implementation UIView (ZWTouchExtensions)

#pragma mark - Initialization

+ (id)viewWithNibName:(NSString *)pNibNameOrNil nibBundle:(NSBundle *)pNibBundleOrNil {
	if(pNibNameOrNil == nil) {
		pNibNameOrNil = NSStringFromClass([self class]);
	}
	if(pNibBundleOrNil == nil) {
		pNibBundleOrNil = [NSBundle mainBundle];
	}
	id c = [[pNibBundleOrNil loadNibNamed:pNibNameOrNil owner:nil options:nil] firstObjectWithKindOfClass:[self class]];
	NSAssert(c != nil, @"Nib couldn't find any UIViews inside");
	return c;
}
+ (id)viewWithFrame:(CGRect)pFrame {
	return [[self alloc] initWithFrame:pFrame];
}
+ (id)viewWithSize:(CGSize)pSize {
	return [self viewWithFrame:CGRectMake(0, 0, pSize.width, pSize.height)];
}

#pragma mark - Frame

static inline
CGPoint ZWGetFrameOrigin(UIView *self, CGFloat anchorX, CGFloat anchorY) {
	CGRect r = self.frame;
	return CGPointMake(r.origin.x + (r.size.width * anchorX), r.origin.y + (r.size.height * anchorY));
}
static inline
void ZWSetFrameOrigin(UIView *self, CGPoint value, CGFloat anchorX, CGFloat anchorY) {
	CGRect r = self.frame;
	r.origin.x = (value.x - r.size.width * anchorX);
	r.origin.y = (value.y - r.size.height * anchorY);
	self.frame = r;
}

@dynamic frame;
@dynamic frameOrigin;
@dynamic frameSize;

- (CGPoint)frameOrigin {
	return self.frame.origin;
}
- (void)setFrameOrigin:(CGPoint)pValue {
	CGRect r = self.frame;
	r.origin = pValue;
	self.frame = r;
}
- (CGSize)frameSize {
	return self.frame.size;
}
- (void)setFrameSize:(CGSize)pValue {
	CGRect r = self.frame;
	r.size = pValue;
	self.frame = r;
}

@dynamic frameWidth;
@dynamic frameHeight;

- (CGFloat)frameWidth {
	return self.frame.size.width;
}
- (void)setFrameWidth:(CGFloat)pValue {
	CGRect r = self.frame;
	r.size.width = pValue;
	self.frame = r;
}
- (CGFloat)frameHeight {
	return self.frame.size.height;
}
- (void)setFrameHeight:(CGFloat)pValue {
	CGRect r = self.frame;
	r.size.height = pValue;
	self.frame = r;
}

@dynamic frameMinX;
@dynamic frameCenterX;
@dynamic frameMaxX;

- (CGFloat)frameMinX {
	return self.frame.origin.x;
}
- (void)setFrameMinX:(CGFloat)pValue {
	CGRect r = self.frame;
	r.origin.x = pValue;
	self.frame = r;
}
- (CGFloat)frameCenterX {
	CGRect r = self.frame;
	return r.origin.x + (r.size.width / 2.0);
}
- (void)setFrameCenterX:(CGFloat)pValue {
	CGRect r = self.frame;
	r.origin.x = pValue - (r.size.width / 2.0);
	self.frame = r;
}
- (CGFloat)frameMaxX {
	CGRect r = self.frame;
	return r.origin.x + r.size.width;
}
- (void)setFrameMaxX:(CGFloat)pValue {
	CGRect r = self.frame;
	r.origin.x = pValue - r.size.width;
	self.frame = r;
}

@dynamic frameMinY;
@dynamic frameCenterY;
@dynamic frameMaxY;

- (CGFloat)frameMinY {
	return self.frame.origin.y;
}
- (void)setFrameMinY:(CGFloat)pValue {
	CGRect r = self.frame;
	r.origin.y = pValue;
	self.frame = r;
}
- (CGFloat)frameCenterY {
	CGRect r = self.frame;
	return r.origin.y + (r.size.height / 2.0);
}
- (void)setFrameCenterY:(CGFloat)pValue {
	CGRect r = self.frame;
	r.origin.y = pValue - (r.size.height / 2.0);
	self.frame = r;
}
- (CGFloat)frameMaxY {
	CGRect r = self.frame;
	return r.origin.y + r.size.height;
}
- (void)setFrameMaxY:(CGFloat)pValue {
	CGRect r = self.frame;
	r.origin.y = pValue - r.size.height;
	self.frame = r;
}

@dynamic frameTopLeft;
@dynamic frameTopCenter;
@dynamic frameTopRight;

- (CGPoint)frameTopLeft {
	return ZWGetFrameOrigin(self, 0, 0);
}
- (void)setFrameTopLeft:(CGPoint)pValue {
	ZWSetFrameOrigin(self, pValue, 0, 0);
}
- (CGPoint)frameTopCenter {
	return ZWGetFrameOrigin(self, 0.5, 0);
}
- (void)setFrameTopCenter:(CGPoint)pValue {
	ZWSetFrameOrigin(self, pValue, 0.5, 0);
}
- (CGPoint)frameTopRight {
	return ZWGetFrameOrigin(self, 1, 0);
}
- (void)setFrameTopRight:(CGPoint)pValue {
	ZWSetFrameOrigin(self, pValue, 1, 0);
}

@dynamic frameCenterLeft;
@dynamic frameCenter;
@dynamic frameCenterRight;

- (CGPoint)frameCenterLeft {
	return ZWGetFrameOrigin(self, 0, 0.5);
}
- (void)setFrameCenterLeft:(CGPoint)pValue {
	ZWSetFrameOrigin(self, pValue, 0.0, 0.5);
}
- (CGPoint)frameCenter {
	return ZWGetFrameOrigin(self, 0.5, 0.5);
}
- (void)setFrameCenter:(CGPoint)pValue {
	ZWSetFrameOrigin(self, pValue, 0.5, 0.5);
}
- (CGPoint)frameCenterRight {
	return ZWGetFrameOrigin(self, 1.0, 0.5);
}
- (void)setFrameCenterRight:(CGPoint)pValue {
	ZWSetFrameOrigin(self, pValue, 1.0, 0.5);
}

@dynamic frameBottomLeft;
@dynamic frameBottomCenter;
@dynamic frameBottomRight;

- (CGPoint)frameBottomLeft {
	return ZWGetFrameOrigin(self, 0, 1);
}
- (void)setFrameBottomLeft:(CGPoint)pValue {
	ZWSetFrameOrigin(self, pValue, 0, 1);
}
- (CGPoint)frameBottomCenter {
	return ZWGetFrameOrigin(self, 0.5, 1);
}
- (void)setFrameBottomCenter:(CGPoint)pValue {
	ZWSetFrameOrigin(self, pValue, 0.5, 1);
}
- (CGPoint)frameBottomRight {
	return ZWGetFrameOrigin(self, 1, 1);
}
- (void)setFrameBottomRight:(CGPoint)pValue {
	ZWSetFrameOrigin(self, pValue, 1, 1);
}

- (CGPoint)frameOriginForAnchorPoint:(CGPoint)pAnchorPoint {
	return ZWGetFrameOrigin(self, pAnchorPoint.x, pAnchorPoint.y);
}

#pragma mark - Bounds

static inline
CGPoint ZWGetBoundsOrigin(UIView *self, CGFloat anchorX, CGFloat anchorY) {
	CGRect r = self.bounds;
	return CGPointMake(r.origin.x + (r.size.width * anchorX), r.origin.y + (r.size.height * anchorY));
}
static inline
void ZWSetBoundsOrigin(UIView *self, CGPoint value, CGFloat anchorX, CGFloat anchorY) {
	CGRect r = self.bounds;
	r.origin.x = r.origin.x + (value.x - r.size.width * anchorX);
	r.origin.y = r.origin.y + (value.y - r.size.height * anchorY);
	self.bounds = r;
}

@dynamic bounds;
@dynamic boundsOrigin;
@dynamic boundsSize;

- (CGPoint)boundsOrigin {
	return self.bounds.origin;
}
- (void)setBoundsOrigin:(CGPoint)pValue {
	CGRect r = self.bounds;
	r.origin = pValue;
	self.bounds = r;
}
- (CGSize)boundsSize {
	return self.bounds.size;
}
- (void)setBoundsSize:(CGSize)pValue {
	CGRect r = self.bounds;
	r.size = pValue;
	self.bounds = r;
}

@dynamic boundsWidth;
@dynamic boundsHeight;

- (CGFloat)boundsWidth {
	return self.bounds.size.width;
}
- (void)setBoundsWidth:(CGFloat)pValue {
	CGRect r = self.bounds;
	r.size.width = pValue;
	self.bounds = r;
}
- (CGFloat)boundsHeight {
	return self.bounds.size.height;
}
- (void)setBoundsHeight:(CGFloat)pValue {
	CGRect r = self.bounds;
	r.size.height = pValue;
	self.bounds = r;
}

@dynamic boundsMinX;
@dynamic boundsCenterX;
@dynamic boundsMaxX;

- (CGFloat)boundsMinX {
	return self.bounds.origin.x;
}
- (void)setBoundsMinX:(CGFloat)pValue {
	CGRect r = self.bounds;
	r.origin.x = pValue;
	self.bounds = r;
}
- (CGFloat)boundsCenterX {
	CGRect r = self.bounds;
	return r.origin.x + (r.size.width / 2.0);
}
- (void)setBoundsCenterX:(CGFloat)pValue {
	CGRect r = self.bounds;
	r.origin.x = pValue - (r.size.width / 2.0);
	self.bounds = r;
}
- (CGFloat)boundsMaxX {
	CGRect r = self.bounds;
	return r.origin.x + r.size.width;
}
- (void)setBoundsMaxX:(CGFloat)pValue {
	CGRect r = self.bounds;
	r.origin.x = pValue - r.size.width;
	self.bounds = r;
}

@dynamic boundsMinY;
@dynamic boundsCenterY;
@dynamic boundsMaxY;

- (CGFloat)boundsMinY {
	return self.bounds.origin.y;
}
- (void)setBoundsMinY:(CGFloat)pValue {
	CGRect r = self.bounds;
	r.origin.y = pValue;
	self.bounds = r;
}
- (CGFloat)boundsCenterY {
	CGRect r = self.bounds;
	return r.origin.y + (r.size.height / 2.0);
}
- (void)setBoundsCenterY:(CGFloat)pValue {
	CGRect r = self.bounds;
	r.origin.y = pValue - (r.size.height / 2.0);
	self.bounds = r;
}
- (CGFloat)boundsMaxY {
	CGRect r = self.bounds;
	return r.origin.y + r.size.height;
}
- (void)setBoundsMaxY:(CGFloat)pValue {
	CGRect r = self.bounds;
	r.origin.y = pValue - r.size.height;
	self.bounds = r;
}

@dynamic boundsTopLeft;
@dynamic boundsTopCenter;
@dynamic boundsTopRight;

- (CGPoint)boundsTopLeft {
	return ZWGetBoundsOrigin(self, 0, 0);
}
- (void)setBoundsTopLeft:(CGPoint)pValue {
	ZWSetBoundsOrigin(self, pValue, 0, 0);
}
- (CGPoint)boundsTopCenter {
	return ZWGetBoundsOrigin(self, 0.5, 0);
}
- (void)setBoundsTopCenter:(CGPoint)pValue {
	ZWSetBoundsOrigin(self, pValue, 0.5, 0);
}
- (CGPoint)boundsTopRight {
	return ZWGetBoundsOrigin(self, 1, 0);
}
- (void)setBoundsTopRight:(CGPoint)pValue {
	ZWSetBoundsOrigin(self, pValue, 1, 0);
}

@dynamic boundsCenterLeft;
@dynamic boundsCenter;
@dynamic boundsCenterRight;

- (CGPoint)boundsCenterLeft {
	return ZWGetBoundsOrigin(self, 0, 0.5);
}
- (void)setBoundsCenterLeft:(CGPoint)pValue {
	ZWSetBoundsOrigin(self, pValue, 0.0, 0.5);
}
- (CGPoint)boundsCenter {
	return ZWGetBoundsOrigin(self, 0.5, 0.5);
}
- (void)setBoundsCenter:(CGPoint)pValue {
	ZWSetBoundsOrigin(self, pValue, 0.5, 0.5);
}
- (CGPoint)boundsCenterRight {
	return ZWGetBoundsOrigin(self, 1, 0.5);
}
- (void)setBoundsCenterRight:(CGPoint)pValue {
	ZWSetBoundsOrigin(self, pValue, 1.0, 0.5);
}

@dynamic boundsBottomLeft;
@dynamic boundsBottomCenter;
@dynamic boundsBottomRight;

- (CGPoint)boundsBottomLeft {
	return ZWGetBoundsOrigin(self, 0, 1);
}
- (void)setBoundsBottomLeft:(CGPoint)pValue {
	ZWSetBoundsOrigin(self, pValue, 0, 1);
}
- (CGPoint)boundsBottomCenter {
	return ZWGetBoundsOrigin(self, 0.5, 1);
}
- (void)setBoundsBottomCenter:(CGPoint)pValue {
	ZWSetBoundsOrigin(self, pValue, 0.5, 1);
}
- (CGPoint)boundsBottomRight {
	return ZWGetBoundsOrigin(self, 1, 1);
}
- (void)setBoundsBottomRight:(CGPoint)pValue {
	ZWSetBoundsOrigin(self, pValue, 1, 1);
}

- (CGPoint)boundsOriginForAnchorPoint:(CGPoint)pAnchorPoint {
	return ZWGetBoundsOrigin(self, pAnchorPoint.x, pAnchorPoint.y);
}

#pragma mark - Utility

- (void)moveFrameToWholePixelsByRounding {
	self.frame = CGRectMake(round(self.frame.origin.x),
							round(self.frame.origin.y),
							self.frame.size.width,
							self.frame.size.height);
}
- (void)moveFrameToWholePixelsByFlooring {
	self.frame = CGRectMake(floor(self.frame.origin.x),
							floor(self.frame.origin.y),
							self.frame.size.width,
							self.frame.size.height);
}
- (void)moveFrameToWholePixelsByCeiling {
	self.frame = CGRectMake(ceil(self.frame.origin.x),
							ceil(self.frame.origin.y),
							self.frame.size.width,
							self.frame.size.height);
}

#pragma mark - Sizing

- (void)sizeWidthToFit {
	CGSize size = self.frameSize;
	[self sizeToFit];
	self.frameHeight = size.height;
}
- (void)sizeHeightToFit {
	CGSize size = self.frameSize;
	[self sizeToFit];
	self.frameWidth = size.width;
}

#pragma mark - Responder

@dynamic closestFirstResponder;

- (UIResponder *)closestFirstResponder {
	if([self isFirstResponder]) {
		return self;
	}
	for(UIView *sv in self.subviews) {
		if([sv isFirstResponder]) {
			return sv;
		}
	}
	for(UIView *sv in self.subviews) {
		UIResponder *r = [sv closestFirstResponder];
		if(r != nil) {
			return r;
		}
	}
	return nil;
}

@end
