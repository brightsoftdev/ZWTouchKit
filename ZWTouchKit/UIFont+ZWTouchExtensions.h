#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface UIFont (ZWTouchExtensions)

- (CGFontRef)CGFont;
- (CTFontRef)CTFont;

@end
