#import "NSIndexPath+ZWTouchExtensions.h"

@implementation NSIndexPath (ZWTouchExtensions)

+ (NSArray *)indexPathsForRowsInRange:(NSRange)pRange section:(NSUInteger)pSection {
	NSMutableArray *a = [NSMutableArray arrayWithCapacity:pRange.length];
	for(NSInteger i = 0; i < pRange.length; ++i) {
		[a addObject:[NSIndexPath indexPathForRow:i + pRange.location inSection:pSection]];
	}
	return a;
}

@end
