#import "ZWShapeView.h"
#import <QuartzCore/QuartzCore.h>

@implementation ZWShapeView

#pragma mark - Properties

#pragma mark - Properties

@synthesize path;
@synthesize fillColor;
@dynamic fillRule;
@dynamic lineCap;
@dynamic lineDashPattern;
@dynamic lineDashPhase;
@dynamic lineWidth;
@dynamic lineJoin;
@dynamic miterLimit;
@synthesize strokeColor;
@dynamic strokeStart;
@dynamic strokeEnd;

+ (Class)layerClass {
	return [CAShapeLayer class];
}

- (void)setPath:(UIBezierPath *)pValue {
	path = pValue;
	[(CAShapeLayer *)self.layer setPath:path.CGPath];
}
- (void)setFillColor:(UIColor *)pValue {
	fillColor = pValue;
	[(CAShapeLayer *)self.layer setFillColor:fillColor.CGColor];
}

- (NSString *)fillRule {
	return [(CAShapeLayer *)self.layer fillRule];
}
- (void)setFillRule:(NSString *)pValue {
	[(CAShapeLayer *)self.layer setFillRule:pValue];
}
- (NSString *)lineCap {
	return [(CAShapeLayer *)self.layer lineCap];
}
- (void)setLineCap:(NSString *)pValue {
	[(CAShapeLayer *)self.layer setLineCap:pValue];
}
- (NSArray *)lineDashPattern {
	return [(CAShapeLayer *)self.layer lineDashPattern];
}
- (void)setLineDashPattern:(NSArray *)pValue {
	[(CAShapeLayer *)self.layer setLineDashPattern:pValue];
}
- (CGFloat)lineDashPhase {
	return [(CAShapeLayer *)self.layer lineDashPhase];
}
- (void)setLineDashPhase:(CGFloat)pValue {
	[(CAShapeLayer *)self.layer setLineDashPhase:pValue];
}
- (CGFloat)lineWidth {
	return [(CAShapeLayer *)self.layer lineWidth];
}
- (void)setLineWidth:(CGFloat)pValue {
	[(CAShapeLayer *)self.layer setLineWidth:pValue];
}
- (NSString *)lineJoin {
	return [(CAShapeLayer *)self.layer lineJoin];
}
- (void)setLineJoin:(NSString *)pValue {
	[(CAShapeLayer *)self.layer setLineJoin:pValue];
}
- (CGFloat)miterLimit {
	return [(CAShapeLayer *)self.layer miterLimit];
}
- (void)setMiterLimit:(CGFloat)pValue {
	[(CAShapeLayer *)self.layer setMiterLimit:pValue];
}
- (CGFloat)strokeStart {
	return [(CAShapeLayer *)self.layer strokeStart];
}
- (void)setStrokeStart:(CGFloat)pValue {
	[(CAShapeLayer *)self.layer setStrokeStart:pValue];
}
- (CGFloat)strokeEnd {
	return [(CAShapeLayer *)self.layer strokeEnd];
}
- (void)setStrokeEnd:(CGFloat)pValue {
	[(CAShapeLayer *)self.layer setStrokeEnd:pValue];
}

- (void)setStrokeColor:(UIColor *)pValue {
	strokeColor = pValue;
	[(CAShapeLayer *)self.layer setStrokeColor:strokeColor.CGColor];
}

@end
