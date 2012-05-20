#import "UIWebView+ZWTouchExtensions.h"
#import "UIView+ZWTouchExtensions.h"


@implementation UIWebView (ZWTouchExtensions)

- (void)setScrollEnabled:(BOOL)pValue {
	for(UIView *sv in self.subviews) {
		if([sv isKindOfClass:[UIScrollView class]]) {
			[(UIScrollView *)sv setScrollEnabled:pValue];
			[(UIScrollView *)sv setBounces:NO];
		}
	}
}
- (void)loadHTMLString:(NSString *)pHTMLString baseURL:(NSURL *)pBaseURL waitUntilDone:(BOOL)pWaitUntilDone {
	if(!pWaitUntilDone) {
		dispatch_async(dispatch_get_main_queue(), ^{
			[self loadHTMLString:pHTMLString baseURL:pBaseURL];
		});
	} else {
		BOOL started = NO;
		do {
			if(!started) {
				[self loadHTMLString:pHTMLString baseURL:pBaseURL];
				started = YES;
			}
			[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
		} while(![self isLoading]);
		do {
			[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
		} while([self isLoading]);
	}
}
- (CGSize)sizeThatFits:(CGSize)pSize {
	CGSize s = [super sizeThatFits:pSize];
	s.height = MIN(s.height, [[self stringByEvaluatingJavaScriptFromString:@"document.height"] doubleValue]);
	return s;
}
- (void)sizeHeightToFit {
	self.frameHeight = [[self stringByEvaluatingJavaScriptFromString:@"document.height"] doubleValue];
}

@end
