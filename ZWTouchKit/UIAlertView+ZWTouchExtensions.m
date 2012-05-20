#import "UIAlertView+ZWTouchExtensions.h"

@implementation UIAlertView (ZWTouchExtensions)

+ (id)alertViewWithTitle:(NSString *)pTitle message:(NSString *)pMessage {
	return [[self alloc] initWithTitle:pTitle message:pMessage delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
}
+ (id)alertViewWithMessage:(NSString *)pMessage {
	return [self alertViewWithTitle:nil message:pMessage];
}

@end
