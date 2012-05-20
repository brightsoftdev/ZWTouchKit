#import "ZWAlertView.h"

@interface ZWAlertView() <UIAlertViewDelegate> {
	
}

#pragma mark - Properties

@property (nonatomic, copy) void (^completionHandler)(ZWAlertView *alertView, NSInteger buttonIndex);

@end
@implementation ZWAlertView

#pragma mark - Properties

@synthesize userInfo;
@synthesize completionHandler;

#pragma mark - Initialization

+ (id)alertViewWithError:(NSError *)pError {
	return [[self alloc] initWithError:pError];
}
- (id)initWithError:(NSError *)pError {
	if((self = [super init])) {
		self.title = [pError.userInfo objectForKey:NSLocalizedDescriptionKey];
		self.message = [pError.userInfo objectForKey:NSLocalizedRecoverySuggestionErrorKey];
		NSArray *options = [pError.userInfo objectForKey:NSLocalizedRecoveryOptionsErrorKey];
		if(options == nil || options.count == 0) {
			options = [NSArray arrayWithObject:NSLocalizedString(@"Dismiss", @"Dismiss")];
		}
		for(NSString *option in options) {
			[self addButtonWithTitle:option];
		}
		self.cancelButtonIndex = self.numberOfButtons - 1;
	}
	return self;
}

#pragma mark - Actions

- (void)showWithCompletionHandler:(void (^)(ZWAlertView *alertView, NSInteger buttonIndex))pCompletionHandler {
	if(self.delegate != nil) {
		ZWLog(@"WARNING: resetting delegate because completion handler will be used.");
		self.delegate = nil;
	}
	self.delegate = self;
	self.completionHandler = pCompletionHandler;
	[self show];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)pAlertView didDismissWithButtonIndex:(NSInteger)pButtonIndex {
	if(pAlertView == self) {
		self.completionHandler(self, pButtonIndex);
	}
}

#pragma mark - Dealloc

- (void)dealloc {
	NSLog(@"dealloc");
}

@end
