#import "UITableView+ZWTouchExtensions.h"
#import <ZWCoreKit/NSObject+ZWExtensions.h>

@interface UITableView (ZWTouchExtensionsPrivate)

- (void)zwRegisterNib:(UINib *)pNib forCellReuseIdentifier:(NSString *)pIdentifier;
- (UITableViewCell *)zwDequeueReusableCellWithIdentifier:(NSString *)pIdentifier;

@end

@implementation UITableView (ZWTouchExtensions)

+ (void)load {
	@autoreleasepool {
		if(!iOS5) {
			// swizzle dequeueReuseableCellWithIdentifier
			[self exchangeInstanceMethodSelector:@selector(dequeueReusableCellWithIdentifier:)
									withSelector:@selector(zwDequeueReusableCellWithIdentifier:)];
			
			// register registerNib:forCellReuseIdentifier
			{
				Method method = class_getInstanceMethod(self, @selector(zwRegisterNib:forCellReuseIdentifier:));
				[self addInstanceMethodForSelector:@selector(registerNib:forCellReuseIdentifier:)
									implementation:method_getImplementation(method)
									 typeEncodings:method_getTypeEncoding(method)];
			}
		}
	}
}

static char *nibDictionaryKey;
- (UITableViewCell *)zwDequeueReusableCellWithIdentifier:(NSString *)pIdentifier {
	UITableViewCell *cell = [self zwDequeueReusableCellWithIdentifier:pIdentifier];
	if(cell == nil) {
		NSMutableDictionary *nibDictionary = [self associatedObjectForKey:nibDictionaryKey];
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
- (void)zwRegisterNib:(UINib *)pNib forCellReuseIdentifier:(NSString *)pIdentifier {
	static dispatch_once_t zwRegisterNibsOnce = 0;
	dispatch_once(&zwRegisterNibsOnce, ^{
		[self setAssociatedObject:[NSMutableDictionary dictionaryWithCapacity:10] forKey:nibDictionaryKey policy:OBJC_ASSOCIATION_RETAIN_NONATOMIC];
	});
	NSMutableDictionary *nibDictionary = [self associatedObjectForKey:nibDictionaryKey];
	if(pNib == nil) {
		[nibDictionary removeObjectForKey:pIdentifier];
	} else {
		[nibDictionary setObject:pNib forKey:pIdentifier];
	}
}

@end
