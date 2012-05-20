#import <UIKit/UIKit.h>


@interface UIWebView (ZWTouchExtensions)

- (void)setScrollEnabled:(BOOL)pValue;
- (void)loadHTMLString:(NSString *)pHTMLString baseURL:(NSURL *)pBaseURL waitUntilDone:(BOOL)pWaitUntilDone;
- (void)sizeHeightToFit;

@end
