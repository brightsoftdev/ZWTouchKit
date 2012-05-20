#import "UITableViewCell+ZWTouchExtensions.h"
#import <ZWCoreKit/NSArray+ZWExtensions.h>

@implementation UITableViewCell (ZWTouchExtensions)

+ (id)cellWithNibName:(NSString *)pNibNameOrNil nibBundle:(NSBundle *)pNibBundleOrNil {
	if(pNibNameOrNil == nil) {
		pNibNameOrNil = NSStringFromClass([self class]);
	}
	if(pNibBundleOrNil == nil) {
		pNibBundleOrNil = [NSBundle mainBundle];
	}
	id c = [[pNibBundleOrNil loadNibNamed:pNibNameOrNil owner:nil options:nil] firstObjectWithKindOfClass:[self class]];
	if(c == nil) {
		ZWLog(@"WARNING: couldn't load cell from nib, creating one with default style and no reuse identifier");
		c = [self cellWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	}
	return c;
}
+ (id)cellWithStyle:(UITableViewCellStyle)pStyle reuseIdentifier:(NSString *)pReuseIdentifier {
	return [[self alloc] initWithStyle:pStyle reuseIdentifier:pReuseIdentifier];
}

@end
