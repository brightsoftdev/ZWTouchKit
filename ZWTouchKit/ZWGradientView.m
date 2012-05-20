#import "ZWGradientView.h"

NSString *ZWGradientViewTypeLinear = @"linear";
NSString *ZWGradientViewTypeRadial = @"radial";

@interface ZWGradientView() {
	NSArray *colors;
	NSArray *locations;
	CGPoint startPoint;
	CGPoint endPoint;
	NSString *type;
}
@end
@implementation ZWGradientView

#pragma mark - Properties

@synthesize colors;
@synthesize locations;
@synthesize endPoint;
@synthesize startPoint;
@synthesize type;

#pragma mark - Initialization

- (id)initWithFrame:(CGRect)pFrame {
	if((self = [super initWithFrame:pFrame])) {
		self.opaque = NO;
		self.backgroundColor = [UIColor clearColor];
		self.startPoint = CGPointZero;
		self.endPoint = CGPointMake(1.0, 1.0);
		self.type = ZWGradientViewTypeRadial;
	}
	return self;
}

#pragma mark -  UIView

- (void)drawRect:(CGRect)pRect {
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	if(self.colors == nil || (self.locations != nil && [self.colors count] != [self.locations count])) {
		CGContextClearRect(ctx, pRect);
		return;
	}
	
	CGContextSaveGState(ctx);
	CGContextClearRect(ctx, pRect);
	
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGFloat *primitiveLocations = nil;
	if(self.locations != nil) {
		primitiveLocations = (CGFloat *)malloc(sizeof(CGFloat) * [self.locations count]);
		NSInteger i = 0;
		for(NSNumber *number in self.locations) {
			primitiveLocations[i++] = [number doubleValue];
		}
	}
	CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)self.colors, primitiveLocations);
	
	CGPoint p1 = CGPointMake(self.startPoint.x * self.bounds.size.width, self.startPoint.y * self.bounds.size.height);
	CGPoint p2 = CGPointMake(self.endPoint.x * self.bounds.size.width, self.endPoint.y * self.bounds.size.height);
	CGFloat d = sqrtf((p2.x - p1.x) * (p2.x - p1.x) + (p2.y - p1.y) * (p2.y - p1.y));
	
	if([self.type isEqualToString:ZWGradientViewTypeLinear]) {
		CGContextDrawLinearGradient(ctx, gradient, p1, p2, (kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation));
	} else if([self.type isEqualToString:ZWGradientViewTypeRadial]) {
		CGContextDrawRadialGradient(ctx, gradient, p1, 0.0, p1, d, (kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation));
	}
	
	CGGradientRelease(gradient);
	if(primitiveLocations != nil) {
		free(primitiveLocations);
	}
	CGColorSpaceRelease(colorSpace);
	
	CGContextRestoreGState(ctx);
}

@end
