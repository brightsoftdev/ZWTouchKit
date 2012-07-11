#import "ZWActivityIndicatorController.h"
#import "UIColor+ZWTouchExtensions.h"
#import "ZWGradientView.h"


@interface ZWActivityIndicatorController() {
	UIView *view;
	ZWGradientView *dimView;
	UIView *boxView;
	UIActivityIndicatorView *activityIndicator;
	
	CGPoint center;
	
	BOOL hidden;
	dispatch_queue_t animationQueue;
	dispatch_semaphore_t animationSemaphore;
	
	ZWActivityIndicatorControllerStyle styleMask;
	CGPoint centerOffset;
}

@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) ZWGradientView *dimView;
@property (nonatomic, strong) UIView *boxView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, assign) CGPoint center;
@property (nonatomic, assign) BOOL hidden;
@property (nonatomic, assign) dispatch_queue_t animationQueue;
@property (nonatomic, assign) dispatch_semaphore_t animationSemaphore;

+ (NSMutableDictionary *)activityIndicatorControllers;

- (id)initWithStyleMask:(ZWActivityIndicatorControllerStyle)pStyleMask;
- (void)presentInView:(UIView *)pView;
- (void)dismiss;

@end

@implementation ZWActivityIndicatorController

#pragma mark - Class Methods

+ (void)load {
	@autoreleasepool {
		[self setDefaultBoxColor:[UIColor colorWithRGB:0x000000 alpha:0.8]];
		[self setDefaultDimColors:[NSArray arrayWithObjects:
								   [UIColor colorWithRGB:0x000000 alpha:0.3],
								   [UIColor colorWithRGB:0x000000 alpha:0.5],
								   nil]];
		[self setDefaultDimColorsLocations:[NSArray arrayWithObjects:
											[NSNumber numberWithFloat:0.0],
											[NSNumber numberWithFloat:0.5],
											nil]];
	}
}

#pragma mark - Class Properties

static ZWActivityIndicatorControllerStyle _defaultStyleMask = ZWActivityIndicatorControllerStyleDim;
+ (ZWActivityIndicatorControllerStyle)defaultStyleMask {
	return _defaultStyleMask;
}
+ (void)setDefaultStyleMask:(ZWActivityIndicatorControllerStyle)pValue {
	_defaultStyleMask = pValue;
}

static NSArray *_defaultDimColors = nil;
+ (NSArray *)defaultDimColors {
	return _defaultDimColors;
}
+ (void)setDefaultDimColors:(NSArray *)pValue {
	_defaultDimColors = pValue;
}
static NSArray *_defaultDimColorsLocations = nil;
+ (NSArray *)defaultDimColorsLocations {
	return _defaultDimColorsLocations;
}
+ (void)setDefaultDimColorsLocations:(NSArray *)pValue {
	_defaultDimColorsLocations = pValue;
}
static UIColor *_defaultBoxColor = nil;
+ (UIColor *)defaultBoxColor {
	return _defaultBoxColor;
}
+ (void)setDefaultBoxColor:(UIColor *)pColor {
	_defaultBoxColor = pColor;
}

+ (NSMutableDictionary *)activityIndicatorControllers {
	static dispatch_once_t activityIndicatorControllersOnce;
	static NSMutableDictionary *activityIndicatorControllers;
	dispatch_once(&activityIndicatorControllersOnce, ^{
		activityIndicatorControllers = [[NSMutableDictionary alloc] init];
	});
	return activityIndicatorControllers;
}

#pragma mark - Properties

@synthesize view;
@synthesize dimView;
@synthesize boxView;
@synthesize dimColors;
@synthesize dimColorsLocations;
@synthesize boxColor;
@synthesize activityIndicator;
@synthesize center;
@synthesize hidden;
@synthesize animationQueue;
@synthesize animationSemaphore;
@synthesize styleMask;
@synthesize centerOffset;

- (void)setStyleMask:(ZWActivityIndicatorControllerStyle)pValue {
	styleMask = pValue;
	
	BOOL box = (styleMask & ZWActivityIndicatorControllerStyleBox);
	BOOL dim = (styleMask & ZWActivityIndicatorControllerStyleDim);
	
	self.dimView.hidden = !dim;
	self.boxView.hidden = (!box || dim);
}
- (void)setDimColors:(NSArray *)pValue {
	dimColors = pValue;
	self.dimView.colors = pValue;
}
- (void)setDimColorsLocations:(NSArray *)pValue {
	dimColorsLocations = pValue;
	self.dimView.locations = pValue;
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

+ (id)presentInViewController:(UIViewController *)pViewController {
	return [self presentInViewController:pViewController styleMask:_defaultStyleMask];
}
+ (id)presentInViewController:(UIViewController *)pViewController styleMask:(ZWActivityIndicatorControllerStyle)pStyleMask {
	NSString *identifier = [NSString stringWithFormat:@"%p", pViewController];
	if([[self activityIndicatorControllers] objectForKey:identifier] != nil) {
		return nil;
	}
	ZWActivityIndicatorController *vc = [[ZWActivityIndicatorController alloc] initWithStyleMask:pStyleMask];
	[[self activityIndicatorControllers] setObject:vc forKey:identifier];
	[vc presentInView:pViewController.view];
	return vc;
}
+ (void)dismissInViewController:(UIViewController *)pViewController {
	NSString *identifier = [NSString stringWithFormat:@"%p", pViewController];
	if([[self activityIndicatorControllers] objectForKey:identifier] == nil) {
		return;
	}
	ZWActivityIndicatorController *vc = [[self activityIndicatorControllers] objectForKey:identifier];
	[vc dismiss];
	[[self activityIndicatorControllers] removeObjectForKey:identifier];
}
+ (id)presentInWindow:(UIWindow *)pWindow {
	return [self presentInWindow:pWindow styleMask:_defaultStyleMask];
}
+ (id)presentInWindow:(UIWindow *)pWindow styleMask:(ZWActivityIndicatorControllerStyle)pStyleMask {
	NSString *identifier = [NSString stringWithFormat:@"%p", pWindow];
	if([[self activityIndicatorControllers] objectForKey:identifier] != nil) {
		return nil;
	}
	ZWActivityIndicatorController *vc = [[ZWActivityIndicatorController alloc] initWithStyleMask:pStyleMask];
	[[self activityIndicatorControllers] setObject:vc forKey:identifier];
	[vc presentInView:pWindow];
	return vc;
}
+ (void)dismissInWindow:(UIWindow *)pWindow {
	NSString *identifier = [NSString stringWithFormat:@"%p", pWindow];
	if([[self activityIndicatorControllers] objectForKey:identifier] == nil) {
		return;
	}
	ZWActivityIndicatorController *vc = [[self activityIndicatorControllers] objectForKey:identifier];
	[vc dismiss];
	[[self activityIndicatorControllers] removeObjectForKey:identifier];
}
- (id)initWithStyleMask:(ZWActivityIndicatorControllerStyle)pStyleMask {
	if((self = [super init])) {
		// setup view
		self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
		self.view.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
									  UIViewAutoresizingFlexibleHeight |
									  UIViewAutoresizingFlexibleTopMargin |
									  UIViewAutoresizingFlexibleBottomMargin |
									  UIViewAutoresizingFlexibleLeftMargin |
									  UIViewAutoresizingFlexibleRightMargin);
		self.view.opaque = NO;
		self.view.backgroundColor = [UIColor clearColor];
		
		// setup dim
		self.dimView = [[ZWGradientView alloc] initWithFrame:self.view.bounds];
		self.dimView.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
										 UIViewAutoresizingFlexibleHeight |
										 UIViewAutoresizingFlexibleTopMargin |
										 UIViewAutoresizingFlexibleBottomMargin |
										 UIViewAutoresizingFlexibleLeftMargin |
										 UIViewAutoresizingFlexibleRightMargin);
		self.dimView.opaque = NO;
		self.dimView.startPoint = CGPointMake(0.5, 0.5);
		self.dimView.endPoint = CGPointMake(0.5, 1.0);
		[self.view addSubview:self.dimView];
		
		// setup box
		self.boxView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 64.0, 64.0)];
		self.boxView.autoresizingMask = UIViewAutoresizingNone;
		self.boxView.center = CGPointMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0);
		self.boxView.layer.cornerRadius = 12.0;
		[self.view addSubview:self.boxView];
		
		// setup activityIndicator
		self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		self.activityIndicator.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
												   UIViewAutoresizingFlexibleRightMargin | 
												   UIViewAutoresizingFlexibleTopMargin | 
												   UIViewAutoresizingFlexibleBottomMargin);
		self.activityIndicator.center = CGPointMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0);
		[self.activityIndicator startAnimating];
		[self.view addSubview:self.activityIndicator];
		
		// set colors
		self.boxColor = [[self class] defaultBoxColor];
		self.dimColors = [[self class] defaultDimColors];
		self.dimColorsLocations = [[self class] defaultDimColorsLocations];
		
		self.styleMask = pStyleMask;
		
		self.hidden = YES;
		self.animationQueue = dispatch_queue_create(nil, nil);
		self.animationSemaphore = dispatch_semaphore_create(0);
	}
	return self;
}

#pragma mark - Actions

- (void)presentInView:(UIView *)pView {
	if(pView == nil) {
		return;
	}
	dispatch_async(self.animationQueue, ^{
		// exit if we're not supposed to be visible
		if(!self.hidden) {
			return;
		}
		// sync main queue
		dispatch_sync(dispatch_get_main_queue(), ^{
			self.center = CGPointMake(pView.bounds.size.width * 0.5, pView.bounds.size.height * 0.5);
			self.view.alpha = 0.0;
			self.view.frame = pView.bounds;
			self.boxView.center = CGPointMake(self.center.x + self.centerOffset.x, self.center.y + self.centerOffset.y);
			self.dimView.frame = self.view.bounds;
			self.dimView.startPoint = CGPointMake((self.center.x + self.centerOffset.x) / self.view.bounds.size.width,
												  (self.center.y + self.centerOffset.y) / self.view.bounds.size.height);
			
			self.dimView.endPoint = CGPointMake(0.0, 0.0);
			self.activityIndicator.center = CGPointMake(self.center.x + self.centerOffset.x, self.center.y + self.centerOffset.y);
			[pView addSubview:self.view];
			
			[UIView animateWithDuration:0.25 
							 animations:^{
								 self.view.alpha = 1.0;
							 }
							 completion:^(BOOL finished) {
								 self.hidden = NO;
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
		// exit if we're supposed to be visible
		if(self.hidden) {
			return;
		}
		// sync main queue
		dispatch_sync(dispatch_get_main_queue(), ^{
			[UIView animateWithDuration:0.25 
							 animations:^{
								 self.view.alpha = 0.0;
							 }
							 completion:^(BOOL finished) {
								 [self.view removeFromSuperview];
								 self.hidden = YES;
								 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.001), dispatch_get_main_queue(), ^{
									 dispatch_semaphore_signal(self.animationSemaphore);
								 });
							 }];
		});
		// wait forever
		dispatch_semaphore_wait(self.animationSemaphore, dispatch_time(DISPATCH_TIME_FOREVER, 0.0));
	});
}

#pragma mark - Dealloc

- (void)dealloc {
	dispatch_release(animationQueue);
	dispatch_release(animationSemaphore);
}

@end
