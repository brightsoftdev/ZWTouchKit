#import "UIImage+ZWTouchExtensions.h"
#import <ZWCoreKit/NSObject+ZWExtensions.h>
#import <ZWCoreKit/CGColorSpace+ZWExtensions.h>
#import <ZWCoreKit/CGImage+ZWExtensions.h>

@implementation UIImage (ZWTouchExtensions)

#pragma mark - Stretchable

- (UIImage *)stretchableHorizontalImage {
	if(self.leftCapWidth != 0) {
		return self;
	}
	return [self stretchableImageWithLeftCapWidth:floorf(self.size.width * 0.5) topCapHeight:0.0];
}
- (UIImage *)stretchableVerticalImage {
	if(self.topCapHeight != 0) {
		return self;
	}
	return [self stretchableImageWithLeftCapWidth:0.0 topCapHeight:floorf(self.size.height * 0.5)];
}
- (UIImage *)stretchableImage {
	if(self.topCapHeight != 0 && self.leftCapWidth != 0) {
		return self;
	}
	return [self stretchableImageWithLeftCapWidth:floorf(self.size.width * 0.5) topCapHeight:floorf(self.size.height * 0.5)];
}

#pragma mark - Orientation

- (UIImage *)imageWithNormalizedOrientation {
	return [self imageWithNormalizedOrientationWithMaxSize:CGSizeZero];
}
- (UIImage *)imageWithNormalizedOrientationWithMaxSize:(CGSize)pSize {
	CGImageRef cgImage = self.CGImage;
	CGFloat width = CGImageGetWidth(cgImage);
	CGFloat height = CGImageGetHeight(cgImage);
	
	CGFloat originalScale = self.scale;
	CGFloat originalWidth = width;
	CGFloat originalHeight = height;
	
	pSize.width *= originalScale;
	pSize.height *= originalScale;
	
	CGAffineTransform transform = CGAffineTransformIdentity;
	switch(self.imageOrientation) {
		case UIImageOrientationUp:
			if(pSize.width == 0 && pSize.height == 0) {
				return self;
			}
			break;
			
		case UIImageOrientationUpMirrored:
			transform = CGAffineTransformMakeTranslation(originalWidth, 0.0);
			transform = CGAffineTransformScale(transform, -1.0, 1.0);
			break;
			
		case UIImageOrientationDown:
			transform = CGAffineTransformMakeTranslation(originalWidth, originalHeight);
			transform = CGAffineTransformRotate(transform, M_PI);
			break;
			
		case UIImageOrientationDownMirrored:
			transform = CGAffineTransformMakeTranslation(0.0, originalHeight);
			transform = CGAffineTransformScale(transform, 1.0, -1.0);
			break;
			
		case UIImageOrientationRightMirrored:
			width = height;
			height = originalWidth;
			transform = CGAffineTransformMakeTranslation(originalHeight, originalWidth);
			transform = CGAffineTransformScale(transform, -1.0, 1.0);
			transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
			break;
			
		case UIImageOrientationRight:
			width = height;
			height = originalWidth;
			transform = CGAffineTransformMakeTranslation(0.0, originalWidth);
			transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
			break;
			
		case UIImageOrientationLeftMirrored:
			width = height;
			height = originalWidth;
			transform = CGAffineTransformMakeScale(-1.0, 1.0);
			transform = CGAffineTransformRotate(transform, M_PI / 2.0);
			break;
			
		case UIImageOrientationLeft:
			width = height;
			height = originalWidth;
			transform = CGAffineTransformMakeTranslation(originalHeight, 0.0);
			transform = CGAffineTransformRotate(transform, M_PI / 2.0);
			break;
			
		default :
			[NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
			break;
	}
	
	CGFloat widthScale = ((pSize.width != 0 && width > pSize.width) ? pSize.width / width : 1.0);
	CGFloat heightScale = ((pSize.height != 0 && height > pSize.height) ? pSize.height / height : 1.0);
	CGFloat scale = widthScale < heightScale ? widthScale : heightScale;
	CGRect rect = CGRectMake(0, 0, floorf(width * scale), floorf(height * scale));
	
	CGBitmapInfo bitmapInfo = kCGImageAlphaPremultipliedLast;
	CGColorSpaceRef colorSpace = CGImageGetColorSpace(cgImage);
	
	CGContextRef ctx = CGBitmapContextCreate(nil,
											 rect.size.width,
											 rect.size.height,
											 8,
											 rect.size.width * 4,
											 colorSpace,
											 bitmapInfo);
	CGContextClearRect(ctx, rect);
	CGContextScaleCTM(ctx, scale, scale);
	CGContextConcatCTM(ctx, transform);
	CGContextSetInterpolationQuality(ctx, kCGInterpolationHigh);
	CGContextDrawImage(ctx, CGRectMake(0, 0, originalWidth, originalHeight), cgImage);
	CGImageRef correctedCGImage = CGBitmapContextCreateImage(ctx);
	CGContextRelease(ctx);
	UIImage *correctedImage = [UIImage imageWithCGImage:correctedCGImage];
	CGImageRelease(correctedCGImage);
	
	return correctedImage;
}

#pragma mark - Resizing

- (UIImage *)resizedImageWithSize:(CGSize)pSize mode:(UIImageResizeMode)pMode {
	CGFloat scale = self.scale;
	UIImageOrientation imageOrientation = self.imageOrientation;
	CGSize originalSize = CGSizeMake(self.size.width * scale, self.size.height * scale);
	
	CGSize size = CGSizeMake(pSize.width * scale, pSize.height * scale);
	CGRect rect = CGRectZero;
	
	switch(pMode) {
		case UIImageResizeModeTopLeft :
			rect.size = originalSize;
			rect.origin.x = 0.0;
			rect.origin.y = 0.0;
			break;
		case UIImageResizeModeTop :
			rect.size = originalSize;
			rect.origin.x = ((size.width - rect.size.width) / 2.0);
			rect.origin.y = 0.0;
			break;
		case UIImageResizeModeTopRight :
			rect.size = originalSize;
			rect.origin.x = (size.width - rect.size.width);
			rect.origin.y = 0.0;
			break;
			
		case UIImageResizeModeLeft :
			rect.size = originalSize;
			rect.origin.x = 0.0;
			rect.origin.y = ((size.height - rect.size.height) / 2.0);
			break;
		case UIImageResizeModeCenter :
			rect.size = originalSize;
			rect.origin.x = ((size.width - rect.size.width) / 2.0);
			rect.origin.y = ((size.height - rect.size.height) / 2.0);
			break;
		case UIImageResizeModeRight :
			rect.size = originalSize;
			rect.origin.x = (size.width - rect.size.width);
			rect.origin.y = ((size.height - rect.size.height) / 2.0);
			break;
			
		case UIImageResizeModeBottomLeft :
			rect.size = originalSize;
			rect.origin.x = 0.0;
			rect.origin.y = (size.height - rect.size.height);
			break;
		case UIImageResizeModeBottom :
			rect.size = originalSize;
			rect.origin.x = ((size.width - rect.size.width) / 2.0);
			rect.origin.y = (size.height - rect.size.height);
			break;
		case UIImageResizeModeBottomRight :
			rect.size = originalSize;
			rect.origin.x = (size.width - rect.size.width);
			rect.origin.y = (size.height - rect.size.height);
			break;
			
			
		case UIImageResizeModeScaleToFill :
			rect.size = size;
			rect.origin.x = 0.0;
			rect.origin.y = 0.0;
			break;
		case UIImageResizeModeScaleAspectFill :
			rect.size = size;
			if(originalSize.width > originalSize.height) {
				rect.size = CGSizeMake(size.width * (originalSize.width / originalSize.height), size.height);
			} else {
				rect.size = CGSizeMake(size.width, size.height * (originalSize.height /originalSize.width));
			}
			rect.origin.x = ((size.width - rect.size.width) / 2.0); 
			rect.origin.y = ((size.height - rect.size.height) / 2.0);
			break;
		case UIImageResizeModeScaleAspectFit :
			rect.size = size;
			if(originalSize.width > originalSize.height) {
				rect.size = CGSizeMake(size.width, size.height * (originalSize.height /originalSize.width));
			} else {
				rect.size = CGSizeMake(size.width * (originalSize.width / originalSize.height), size.height);
			}
			rect.origin.x = ((size.width - rect.size.width) / 2.0); 
			rect.origin.y = ((size.height - rect.size.height) / 2.0);
			break;
			
		default :
			[NSException raise:NSInternalInconsistencyException format:@"Invalid image resize mode"];
			break;
	}
	
	size.width = floorf(size.width);
	size.height = floorf(size.height);
	
	CGImageRef cgImage = self.CGImage;
	CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(cgImage);
	CGColorSpaceRef colorSpace = CGImageGetColorSpace(cgImage);
	CGContextRef ctx = CGBitmapContextCreate(nil,
											 size.width,
											 size.height,
											 8,
											 size.width * 4,
											 colorSpace,
											 bitmapInfo);
	CGContextClearRect(ctx, CGRectMake(0, 0, size.width, size.height));
	CGContextSetInterpolationQuality(ctx, kCGInterpolationHigh);
	CGContextDrawImage(ctx, rect, cgImage);
	CGImageRef resizedCGImage = CGBitmapContextCreateImage(ctx);
	CGContextRelease(ctx);
	UIImage *resizedImage = [UIImage imageWithCGImage:resizedCGImage scale:scale orientation:imageOrientation];
	CGImageRelease(resizedCGImage);
	
	return resizedImage;
}

#pragma mark - Prerendered

static char *prerenderedKey;

- (UIImage *)prerenderedImage {
	if([[self associatedObjectForKey:&prerenderedKey] isEqualToString:@"default"]) {
		return self;
	}
	UIImage *prerenderedImage = [self prerenderedImageWithSize:self.size 
														  mode:UIImageResizeModeScaleToFill 
													colorSpace:CGColorSpaceDeviceRGB() 
													bitmapInfo:(kCGBitmapByteOrder32Host | kCGImageAlphaPremultipliedFirst)];
	[prerenderedImage setAssociatedObject:@"default" forKey:&prerenderedKey policy:OBJC_ASSOCIATION_RETAIN];
	return prerenderedImage;
}
- (UIImage *)prerenderedImageWithSize:(CGSize)pSize {
	if([[self associatedObjectForKey:prerenderedKey] isEqualToString:NSStringFromCGSize(pSize)]) {
		return self;
	}
	UIImage *prerenderedImage = [self prerenderedImageWithSize:pSize 
														  mode:UIImageResizeModeScaleToFill 
													colorSpace:CGColorSpaceDeviceRGB() 
													bitmapInfo:(kCGBitmapByteOrder32Host | kCGImageAlphaPremultipliedFirst)];
	[prerenderedImage setAssociatedObject:NSStringFromCGSize(pSize) forKey:&prerenderedKey policy:OBJC_ASSOCIATION_RETAIN];
	return prerenderedImage;
}
- (UIImage *)prerenderedImageWithSize:(CGSize)pSize mode:(UIImageResizeMode)pMode {
	if([[self associatedObjectForKey:&prerenderedKey] isEqualToString:[NSString stringWithFormat:@"%@%i", NSStringFromCGSize(pSize), pMode]]) {
		return self;
	};
	UIImage *prerenderedImage = [self prerenderedImageWithSize:pSize 
														  mode:pMode 
													colorSpace:CGColorSpaceDeviceRGB() 
													bitmapInfo:(kCGBitmapByteOrder32Host | kCGImageAlphaPremultipliedFirst)];
	[prerenderedImage setAssociatedObject:[NSString stringWithFormat:@"%@%i", NSStringFromCGSize(pSize), pMode] forKey:&prerenderedKey policy:OBJC_ASSOCIATION_RETAIN];
	return prerenderedImage;
}
- (UIImage *)prerenderedImageWithSize:(CGSize)pSize mode:(UIImageResizeMode)pMode colorSpace:(CGColorSpaceRef)pColorSpace bitmapInfo:(CGBitmapInfo)pBitmapInfo {
	CGFloat scale = self.scale;
	UIImageOrientation imageOrientation = self.imageOrientation;
	CGSize size = CGSizeMake(self.size.width * scale, self.size.height * scale);
	
	CGContextRef ctx = CGBitmapContextCreate(nil,
											 size.width,
											 size.height,
											 8,
											 size.width * 4,
											 pColorSpace,
											 pBitmapInfo);
	CGContextClearRect(ctx, CGRectMake(0, 0, size.width, size.height));
	CGContextSetInterpolationQuality(ctx, kCGInterpolationHigh);
	CGContextDrawImage(ctx, CGRectMake(0, 0, size.width, size.height), self.CGImage);
	CGImageRef prerenderedCGImage = CGBitmapContextCreateImage(ctx);
	CGContextRelease(ctx);
	UIImage *prerenderedImage = [UIImage imageWithCGImage:prerenderedCGImage scale:scale orientation:imageOrientation];
	CGImageRelease(prerenderedCGImage);
	
	return prerenderedImage;
}

#pragma mark - Masking

+ (UIImage *)imageWithMaskNamed:(NSString *)pName {
	UIImage *image = [UIImage imageNamed:pName];
	if(image == nil) {
		return nil;
	}
	
	NSString *baseName = [pName substringToIndex:pName.length - pName.pathExtension.length - 1];
	UIImage *mask = [UIImage imageNamed:[baseName stringByAppendingString:@"~mask.png"]];
	if(mask == nil) {
		mask = [UIImage imageNamed:[baseName stringByAppendingString:@"~mask.jpg"]];
	}
	if(mask != nil) {
		image = [image imageByMaskingUsingImage:mask];
	}
	return image;
}
- (UIImage *)imageByMaskingUsingImage:(UIImage *)pMaskImage {
	CGImageRef maskedCGImage = CGImageCreateByMasking(self.CGImage, pMaskImage.CGImage);
	UIImage *maskedImage = [UIImage imageWithCGImage:maskedCGImage scale:self.scale orientation:self.imageOrientation];
	CGImageRelease(maskedCGImage);
	return maskedImage;
	
}

@end
