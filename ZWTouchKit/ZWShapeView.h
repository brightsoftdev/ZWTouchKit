#import <UIKit/UIKit.h>


#define ZWShapeViewFillRuleNonZero kCAFillRuleNonZero
#define ZWShapeViewFillRuleEvenOdd kCAFillRuleEvenOdd

#define ZWShapeViewLineJoinMiter kCALineJoinMiter
#define ZWShapeViewLineJoinRound kCALineJoinRound
#define ZWShapeViewLineJoinBevel kCALineJoinBevel

#define ZWShapeViewLineCapButt kCALineCapButt
#define ZWShapeViewLineCapRound kCALineCapRound
#define ZWShapeViewLineCapSquare kCALineCapSquare

@interface ZWShapeView : UIView

#pragma mark - Properties

@property (nonatomic, copy) UIBezierPath *path;
@property (nonatomic, copy) UIColor *fillColor;
@property (nonatomic, copy) NSString *fillRule;
@property (nonatomic, copy) NSString *lineCap;
@property (nonatomic, copy) NSArray *lineDashPattern;
@property (nonatomic, assign) CGFloat lineDashPhase;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, copy) NSString *lineJoin;
@property (nonatomic, assign) CGFloat miterLimit;
@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, assign) CGFloat strokeStart;
@property (nonatomic, assign) CGFloat strokeEnd;

@end
