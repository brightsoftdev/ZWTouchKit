#import "ZWActivityView.h"
#import "ZWGradientView.h"
#import "UIView+ZWTouchExtensions.h"
#import "UIColor+ZWTouchExtensions.h"

@interface ZWActivityView() {
}

@property (nonatomic, strong) ZWGradientView *dimView;
@property (nonatomic, strong) UIView *boxView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, assign) dispatch_queue_t animationQueue;
@property (nonatomic, assign) dispatch_semaphore_t animationSemaphore;

- (void)presentInView:(UIView *)pView;
- (void)dismiss;

@end
@implementation ZWActivityView

#pragma mark - Properties

@synthesize styleMask;
@synthesize dimColor;
@synthesize boxColor;
@synthesize centerOffset;
@synthesize dimView;
@synthesize boxView;
@synthesize activityIndicator;
@synthesize animationQueue;
@synthesize animationSemaphore;

- (void)setStyleMask:(ZWActivityViewStyle)pValue {
	styleMask = pValue;
	
	BOOL spinner = (styleMask & ZWActivityViewStyleSpinner);
	BOOL box = (styleMask & ZWActivityViewStyleBox);
	BOOL dim = (styleMask & ZWActivityViewStyleDim);
	
	if(spinner) {
		[self.activityIndicator startAnimating];
	} else {
		[self.activityIndicator stopAnimating];
	}
	self.boxView.hidden = (!box || dim);
	self.dimView.hidden = !dim;
	[self.boxView setNeedsDisplay];
	[self.dimView setNeedsDisplay];
	[self setNeedsDisplay];
}
- (UIColor *)dimColor {
	return dimColor;
}
- (void)setDimColor:(UIColor *)pValue {
	dimColor = [pValue colorWithAlphaComponent:1.0];
	if(dimColor != nil) {
		self.dimView.colors = [NSArray arrayWithObjects:
							   (id)[[dimColor colorWithAlphaComponent:0.25] CGColor],
							   (id)[[dimColor colorWithAlphaComponent:0.75] CGColor],
							   (id)[[dimColor colorWithAlphaComponent:1.0] CGColor],
							   nil];
		[self.dimView setNeedsDisplay];
	}
}
- (UIColor *)boxColor {
	return boxColor;
}
- (void)setBoxColor:(UIColor *)pValue {
	boxColor = pValue;
	boxView.backgroundColor = boxColor;
}
- (void)setCenterOffset:(CGPoint)pValue {
	centerOffset = pValue;
	
	CGPoint c = CGPointMake(self.center.x + centerOffset.x, self.center.y + centerOffset.y);
	self.boxView.center = c;
	self.activityIndicator.center = c;
}

#pragma mark - Initialization

+ (id)activityViewWithStyle:(ZWActivityViewStyle)pStyleMask {
	return [[self alloc] initWithStyle:pStyleMask];
}
- (id)initWithStyle:(ZWActivityViewStyle)pStyleMask {
	if((self = [super initWithFrame:[[UIScreen mainScreen] bounds]])) {
		self.autoresizingMask = UIViewAutoresizingMaskAll();
		self.opaque = NO;
		self.backgroundColor = [UIColor clearColor];
		
		// setup dim
		self.dimView = [[ZWGradientView alloc] initWithFrame:self.bounds];
		self.dimView.autoresizingMask = UIViewAutoresizingMaskAll();
		self.dimView.opaque = NO;
		self.dimView.backgroundColor = [UIColor colorWithRGB:0x000000 alpha:0.25];
		self.dimView.locations = [NSArray arrayWithObjects:
								  [NSNumber numberWithFloat:0.0],
								  [NSNumber numberWithFloat:0.5],
								  [NSNumber numberWithFloat:1.0],
								  nil];
		self.dimView.type = ZWGradientViewTypeRadial;
		self.dimView.startPoint = CGPointMake(0.5, 0.5);
		self.dimView.endPoint = CGPointMake(0.5, 2.0);
		[self addSubview:self.dimView];
		
		// setup box
		self.boxView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 64.0, 64.0)];
		self.boxView.autoresizingMask = UIViewAutoresizingNone;
		self.boxView.center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
		self.boxView.layer.cornerRadius = 12.0;
		[self addSubview:self.boxView];
		
		// setup activityIndicator
		self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		self.activityIndicator.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
												   UIViewAutoresizingFlexibleRightMargin | 
												   UIViewAutoresizingFlexibleTopMargin | 
												   UIViewAutoresizingFlexibleBottomMargin);
		self.activityIndicator.center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
		self.activityIndicator.hidesWhenStopped = YES;
		[self addSubview:self.activityIndicator];
		
		// set colors
		self.boxColor = [UIColor colorWithRGB:0x000000 alpha:0.8];
		self.dimColor = [UIColor colorWithRGB:0x000000 alpha:1.0];
		
		self.styleMask = pStyleMask;
		
		self.alpha = 0.0;
		self.animationQueue = dispatch_queue_create(nil, nil);
		self.animationSemaphore = dispatch_semaphore_create(0);
	}
	return self;
}

#pragma mark - UIView

- (void)willMoveToSuperview:(UIView *)pNewSuperview {
	[super willMoveToSuperview:pNewSuperview];
	self.frame = pNewSuperview.bounds;
}
- (void)didMoveToSuperview {
	[self setNeedsLayout];
	[self setNeedsDisplay];
}

#pragma mark - Actions

- (void)presentInView:(UIView *)pView {
	if(pView == nil) {
		return;
	}
	dispatch_async(self.animationQueue, ^{
		// sync main queue
		dispatch_sync(dispatch_get_main_queue(), ^{
			self.center = CGPointMake(pView.bounds.size.width * 0.5, pView.bounds.size.height * 0.5);
			self.alpha = 0.0;
			self.frame = pView.bounds;
			self.boxView.center = CGPointMake(self.center.x + self.centerOffset.x, self.center.y + self.centerOffset.y);
			self.dimView.startPoint = CGPointMake((self.center.x + self.centerOffset.x) / self.bounds.size.width,
												  (self.center.y + self.centerOffset.y) / self.bounds.size.height);
			self.dimView.endPoint = self.dimView.startPoint;
			self.activityIndicator.center = CGPointMake(self.center.x + self.centerOffset.x, self.center.y + self.centerOffset.y);
			[pView addSubview:self];
			[UIView animateWithDuration:0.25 
							 animations:^{
								 self.alpha = 1.0;
							 }
							 completion:^(BOOL finished) {
								 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
									 dispatch_semaphore_signal(self.animationSemaphore);
								 });
							 }];
		});
		// wait forever
		dispatch_semaphore_wait(self.animationSemaphore, dispatch_time(DISPATCH_TIME_FOREVER, 0.0));
	});
}
- (void)dismiss {
	dispatch_async(self.animationQueue, ^{
		// sync main queue
		dispatch_sync(dispatch_get_main_queue(), ^{
			[UIView animateWithDuration:0.25 
							 animations:^{
								 self.alpha = 0.0;
							 }
							 completion:^(BOOL finished) {
								 [self removeFromSuperview];
								 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.001), dispatch_get_main_queue(), ^{
									 dispatch_semaphore_signal(self.animationSemaphore);
								 });
							 }];
		});
		// wait forever
		dispatch_semaphore_wait(self.animationSemaphore, dispatch_time(DISPATCH_TIME_FOREVER, 0.0));
	});
}

- (void)dealloc {
	dispatch_release(animationQueue);
	dispatch_release(animationSemaphore);
}

@end
