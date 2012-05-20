#import "UIBarButtonItem+ZWTouchExtensions.h"


@implementation UIBarButtonItem (ZWTouchExtensions)

+ (id)flexibleSpaceBarButtonItem {
	return [[self alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
}
+ (id)fixedSpaceBarButtonItemWithWidth:(CGFloat)pWidth {
	UIBarButtonItem *bbi = [[self alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
	bbi.width = pWidth;
	return bbi;
}
+ (id)barButtonItemWithBarButtonSystemItem:(UIBarButtonSystemItem)pSystemItem target:(id)pTarget action:(SEL)pAction {
	return [(UIBarButtonItem *)[self alloc] initWithBarButtonSystemItem:pSystemItem target:pTarget action:pAction];
}
+ (id)barButtonItemWithTitle:(NSString *)pTitle style:(UIBarButtonItemStyle)pStyle target:(id)pTarget action:(SEL)pAction {
	return [(UIBarButtonItem *)[self alloc] initWithTitle:pTitle style:pStyle target:pTarget action:pAction];
}
+ (id)barButtonItemWithImage:(UIImage *)pImage style:(UIBarButtonItemStyle)pStyle target:(id)pTarget action:(SEL)pAction {
	return [(UIBarButtonItem *)[self alloc] initWithImage:pImage style:pStyle target:pTarget action:pAction];
}
+ (id)barButtonItemWithCustomView:(UIView *)pCustomView target:(id)pTarget action:(SEL)pAction {
	UIBarButtonItem *bbi = [[self alloc] initWithCustomView:pCustomView];
	[bbi setTarget:pTarget];
	[bbi setAction:pAction];
	return bbi;
}

- (void)setTarget:(id)pTarget action:(SEL)pAction {
	self.target = pTarget;
	self.action = pAction;
}

@end
