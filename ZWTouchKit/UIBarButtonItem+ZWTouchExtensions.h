#import <UIKit/UIKit.h>


@interface UIBarButtonItem (ZWTouchExtensions)

+ (id)flexibleSpaceBarButtonItem;
+ (id)fixedSpaceBarButtonItemWithWidth:(CGFloat)pWidth;

+ (id)barButtonItemWithBarButtonSystemItem:(UIBarButtonSystemItem)pSystemItem target:(id)pTarget action:(SEL)pAction;
+ (id)barButtonItemWithTitle:(NSString *)pTitle style:(UIBarButtonItemStyle)pStyle target:(id)pTarget action:(SEL)pAction;
+ (id)barButtonItemWithImage:(UIImage *)pImage style:(UIBarButtonItemStyle)pStyle target:(id)pTarget action:(SEL)pAction;
+ (id)barButtonItemWithCustomView:(UIView *)pCustomView target:(id)pTarget action:(SEL)pAction;

- (void)setTarget:(id)pTarget action:(SEL)pAction;

@end
