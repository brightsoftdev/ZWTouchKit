#import "UIFont+ZWTouchExtensions.h"
#import <ZWCoreKit/NSObject+ZWExtensions.h>

@interface UIFontCGFontStorage : NSObject
@property (nonatomic, readonly) CGFontRef CGFont;
+ (UIFontCGFontStorage *)storageWithCGFont:(CGFontRef)pCGFont;
- (id)initWithCGFont:(CGFontRef)pCGFont;
@end
@implementation UIFontCGFontStorage
@synthesize CGFont;
+ (UIFontCGFontStorage *)storageWithCGFont:(CGFontRef)pCGFont {
	return [[self alloc] initWithCGFont:pCGFont];
}
- (id)initWithCGFont:(CGFontRef)pCGFont {
	if((self = [super init])) {
		CGFont = CGFontRetain(pCGFont);
	}
	return self;
}
- (void)dealloc {
    CGFontRelease(CGFont);
	CGFont = nil;
}
@end
@interface UIFontCTFontStorage : NSObject
@property (nonatomic, readonly) CTFontRef CTFont;
+ (UIFontCTFontStorage *)storageWithCTFont:(CTFontRef)pCTFont;
- (id)initWithCTFont:(CTFontRef)pCTFont;
@end
@implementation UIFontCTFontStorage
@synthesize CTFont;
+ (UIFontCTFontStorage *)storageWithCTFont:(CTFontRef)pCTFont {
	return [[self alloc] initWithCTFont:pCTFont];
}
- (id)initWithCTFont:(CTFontRef)pCTFont {
	if((self = [super init])) {
		CTFont = CFRetain(pCTFont);
	}
	return self;
}
- (void)dealloc {
	CFRelease(CTFont);
	CTFont = nil;
}
@end

@implementation UIFont (ZWTouchExtensions)

- (CGFontRef)CGFont {
	static char *CGFontKey;
	UIFontCGFontStorage *storage = [self associatedObjectForKey:CGFontKey];
	if(storage == nil) {
		CGFontRef f = CGFontCreateWithFontName((__bridge CFStringRef)self.fontName);
		storage = [UIFontCGFontStorage storageWithCGFont:f];
		CGFontRelease(f);
		[self setAssociatedObject:storage forKey:&CGFontKey policy:OBJC_ASSOCIATION_RETAIN_NONATOMIC];
	}
	return storage.CGFont;
}
- (CTFontRef)CTFont {
	static char *CTFontKey;
	UIFontCTFontStorage *storage = [self associatedObjectForKey:CTFontKey];
	if(storage == nil) {
		CTFontRef f = CTFontCreateWithGraphicsFont(self.CGFont, self.pointSize, nil, nil);
		storage = [UIFontCTFontStorage storageWithCTFont:f];
		CFRelease(f);
		[self setAssociatedObject:storage forKey:&CTFontKey policy:OBJC_ASSOCIATION_RETAIN_NONATOMIC];
	}
	return storage.CTFont;
}

@end
