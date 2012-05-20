#import <UIKit/UIKit.h>

@interface ZWWebViewController : UIViewController <UIWebViewDelegate>

#pragma mark - Properties

@property (nonatomic, strong, readonly) UIWebView *webView;

#pragma mark - Initialization

- (id)initWithRequest:(NSURLRequest *)pRequest;
- (id)initWithHTMLString:(NSString *)pHTMLString baseURL:(NSURL *)pBaseURL;
- (id)initWithData:(NSData *)pData MIMEType:(NSString *)pMIMEType textEncodingName:(NSString *)pTextEncodingName baseURL:(NSURL *)pBaseURL;
- (id)initWithHTMLFilename:(NSString *)pFilename inBundle:(NSBundle *)pBundle;

#pragma mark - Actions

- (void)loadRequest:(NSURLRequest *)pRequest;
- (void)loadHTMLString:(NSString *)pHTMLString baseURL:(NSURL *)pBaseURL;
- (void)loadData:(NSData *)pData MIMEType:(NSString *)pMIMEType textEncodingName:(NSString *)pTextEncodingName baseURL:(NSURL *)pBaseURL;
- (void)loadHTMLFilename:(NSString *)pFilename inBundle:(NSBundle *)pBundle;
- (void)reload;
- (void)stopLoading;

@end
