#import "UINib+ZWTouchExtensions.h"


@implementation UINib (ZWTouchExtensions)

+ (NSArray *)instantiateNibWithNibName:(NSString *)pNibName bundle:(NSBundle *)pBundle {
	return [self instantiateNibWithNibName:pNibName bundle:pBundle owner:nil options:nil];
}
+ (NSArray *)instantiateNibWithNibName:(NSString *)pNibName bundle:(NSBundle *)pBundle owner:(id)pOwner options:(NSDictionary *)pOptions {
	return [[self nibWithNibName:pNibName bundle:pBundle] instantiateWithOwner:pOwner options:pOptions];
}
@end
