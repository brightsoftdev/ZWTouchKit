#import "ZWFirstResponderView.h"
#import "UIView+ZWTouchExtensions.h"


@implementation ZWFirstResponderView

- (BOOL)canBecomeFirstResponder {
	return YES;
}
- (BOOL)canResignFirstResponder {
	return YES;
}
- (BOOL)becomeFirstResponder {
	return YES;
}
- (BOOL)resignFirstResponder {
	return YES;
}
- (id)init {
	if((self = [super init])) {
		self.userInteractionEnabled = YES;
		self.multipleTouchEnabled = NO;
	}
	return self;
}
- (id)initWithCoder:(NSCoder *)pCoder {
	if((self = [super initWithCoder:pCoder])) {
		self.userInteractionEnabled = YES;
		self.multipleTouchEnabled = NO;
	}
	return self;
}
- (id)initWithFrame:(CGRect)pFrame {
	if((self = [super initWithFrame:pFrame])) {
		self.userInteractionEnabled = YES;
		self.multipleTouchEnabled = NO;
	}
	return self;
}

#pragma mark - Touches

- (void)touchesBegan:(NSSet *)pTouches withEvent:(UIEvent *)pEvent {
	UITouch *touch = [pTouches anyObject];
	if(CGRectContainsPoint(self.bounds, [touch locationInView:self])) {
		UIResponder *firstResponder = [self.window closestFirstResponder];
		if(firstResponder != nil) {
			dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
				[firstResponder resignFirstResponder];
				[self becomeFirstResponder];
			});
		}
	}
}

@end
