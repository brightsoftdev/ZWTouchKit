#import <UIKit/UIKit.h>

enum {
    UIImageResizeModeScaleToFill,
    UIImageResizeModeScaleAspectFit,      // contents scaled to fit with fixed aspect. remainder is transparent
    UIImageResizeModeScaleAspectFill,     // contents scaled to fill with fixed aspect. some portion of content may be clipped.
    UIImageResizeModeCenter,              // contents remain same size. positioned adjusted.
    UIImageResizeModeTop,
    UIImageResizeModeBottom,
    UIImageResizeModeLeft,
    UIImageResizeModeRight,
    UIImageResizeModeTopLeft,
    UIImageResizeModeTopRight,
    UIImageResizeModeBottomLeft,
    UIImageResizeModeBottomRight,
};
typedef NSUInteger UIImageResizeMode;

@interface UIImage (ZWTouchExtensions)

#pragma mark - Stretchable

- (UIImage *)stretchableHorizontalImage;
- (UIImage *)strechableVerticalImage;
- (UIImage *)stretchableImage;

#pragma mark - Orientation

- (UIImage *)imageWithNormalizedOrientation;
- (UIImage *)imageWithNormalizedOrientationWithMaxSize:(CGSize)pSize;

#pragma mark - Resizing

- (UIImage *)resizedImageWithSize:(CGSize)pSize mode:(UIImageResizeMode)pMode;

#pragma mark - Prerendering

- (UIImage *)prerenderedImage;
- (UIImage *)prerenderedImageWithSize:(CGSize)pSize;
- (UIImage *)prerenderedImageWithSize:(CGSize)pSize mode:(UIImageResizeMode)pMode;
- (UIImage *)prerenderedImageWithSize:(CGSize)pSize mode:(UIImageResizeMode)pMode colorSpace:(CGColorSpaceRef)pColorSpace bitmapInfo:(CGBitmapInfo)pBitmapInfo;

#pragma mark - Masking

+ (UIImage *)imageWithMaskNamed:(NSString *)pName;
- (UIImage *)imageByMaskingUsingImage:(UIImage *)pMaskImage;

@end
