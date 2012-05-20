#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

extern NSString *ZWGradientViewTypeLinear;
extern NSString *ZWGradientViewTypeRadial;

@interface ZWGradientView : UIView {
}

#pragma mark - Properties

@property (copy) NSArray *colors;
@property (copy) NSArray *locations;
@property (assign) CGPoint endPoint;
@property (assign) CGPoint startPoint;
@property (copy) NSString *type;

@end
