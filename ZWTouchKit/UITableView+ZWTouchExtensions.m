#import "UITableView+ZWTouchExtensions.h"
#import <ZWCoreKit/NSObject+ZWExtensions.h>

@implementation UITableView (ZWTouchExtensions)

+ (void)load {
#if !OBJC_ARC_WEAK
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
#endif
		@autoreleasepool {
			if(!iOS5) {
				// swizzle dequeueReuseableCellWithIdentifier
				[self exchangeInstanceMethodSelector:@selector(dequeueReusableCellWithIdentifier:)
										withSelector:@selector(zw_dequeueReusableCellWithIdentifier:)];
				
				// register registerNib:forCellReuseIdentifier
				{
					Method method = class_getInstanceMethod(self, @selector(zw_registerNib:forCellReuseIdentifier:));
					[self addInstanceMethodForSelector:@selector(registerNib:forCellReuseIdentifier:)
										implementation:method_getImplementation(method)
										 typeEncodings:method_getTypeEncoding(method)];
				}
			}
		}
#if !OBJC_ARC_WEAK
    });
#endif
}

static char *nibDictionaryKey;
- (NSMutableDictionary *)zw_nibDictionary {
	NSMutableDictionary *nibDictionary = [self associatedObjectForKey:&nibDictionaryKey];
	if(!nibDictionary) {
		nibDictionary  = [NSMutableDictionary dictionaryWithCapacity:10];
		[self setAssociatedObject:nibDictionary forKey:&nibDictionaryKey policy:OBJC_ASSOCIATION_RETAIN_NONATOMIC];
	}
	return nibDictionary;
}

- (UITableViewCell *)zw_dequeueReusableCellWithIdentifier:(NSString *)pIdentifier {
	UITableViewCell *cell = [self zw_dequeueReusableCellWithIdentifier:pIdentifier];
	if(cell == nil) {
		NSMutableDictionary *nibDictionary = [self zw_nibDictionary];
		UINib *nib = [nibDictionary objectForKey:pIdentifier];
		if(nib != nil) {
			NSArray *nibObjects = [nib instantiateWithOwner:nil options:nil];
			for(id nibObject in nibObjects) {
				if([nibObject isKindOfClass:[UITableViewCell class]]) {
					UITableViewCell *nibCell = nibObject;
					if([nibCell.reuseIdentifier isEqualToString:pIdentifier]) {
						return nibCell;
					}
				}
			}
		}
		[NSException raise:@"Nil cell." format:@"Couldn't find a reusable cell or nib for identifier: %@", pIdentifier];
	}
	return cell;
}
- (void)zw_registerNib:(UINib *)pNib forCellReuseIdentifier:(NSString *)pIdentifier {
	NSMutableDictionary *nibDictionary = [self zw_nibDictionary];
	if(pNib == nil) {
		[nibDictionary removeObjectForKey:pIdentifier];
	} else {
		[nibDictionary setObject:pNib forKey:pIdentifier];
	}
}

@end
