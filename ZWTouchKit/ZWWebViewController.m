#import "ZWWebViewController.h"
#import "ZWActivityIndicatorController.h"

@interface ZWWebViewController() {
	
}

@property (nonatomic, copy) void (^defaultLoad)(ZWWebViewController *webViewController);

@end
@implementation ZWWebViewController

#pragma mark - Properties

@synthesize webView;
@synthesize defaultLoad;

#pragma mark - Initialization

- (id)initWithRequest:(NSURLRequest *)pRequest {
	if((self = [super init])) {
		defaultLoad = [^(ZWWebViewController *webViewController) {
			[webViewController loadRequest:pRequest];
		} copy];
	}
	return self;
}
- (id)initWithHTMLString:(NSString *)pHTMLString baseURL:(NSURL *)pBaseURL {
	if((self = [super init])) {
		defaultLoad = [^(ZWWebViewController *webViewController) {
			[webViewController loadHTMLString:pHTMLString baseURL:pBaseURL];
		} copy];
	}
	return self;
}
- (id)initWithData:(NSData *)pData MIMEType:(NSString *)pMIMEType textEncodingName:(NSString *)pTextEncodingName baseURL:(NSURL *)pBaseURL {
	if((self = [super init])) {
		defaultLoad = [^(ZWWebViewController *webViewController) {
			[webViewController loadData:pData MIMEType:pMIMEType textEncodingName:pTextEncodingName baseURL:pBaseURL];
		} copy];
	}
	return self;
}
- (id)initWithHTMLFilename:(NSString *)pFilename inBundle:(NSBundle *)pBundle {
	if((self = [super init])) {
		defaultLoad = [^(ZWWebViewController *webViewController) {
			[webViewController loadHTMLFilename:pFilename inBundle:pBundle];
		} copy];
	}
	return self;
}

#pragma mark - UIViewController

- (void)loadView {
	self.view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 480.0)];
	[super loadView];
}
- (void)viewDidLoad {
	[super viewDidLoad];
	webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
	self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	self.webView.delegate = self;
	[self.view addSubview:self.webView];
}
- (void)viewDidUnload {
	[super viewDidUnload];
	self.webView.delegate = nil;
	webView = nil;
}
- (void)viewWillAppear:(BOOL)pAnimated {
	[super viewWillAppear:pAnimated];
	if(self.defaultLoad != nil) {
		self.defaultLoad(self);
	}
}
- (void)viewDidAppear:(BOOL)pAnimated {
	[super viewDidAppear:pAnimated];
}
- (void)viewWillDisappear:(BOOL)pAnimated {
	[super viewWillDisappear:pAnimated];
}
- (void)viewDidDisappear:(BOOL)pAnimated {
	[super viewDidDisappear:pAnimated];
}

#pragma mark - Actions

- (void)loadRequest:(NSURLRequest *)pRequest {
	[self.webView loadRequest:pRequest];
}
- (void)loadHTMLString:(NSString *)pHTMLString baseURL:(NSURL *)pBaseURL {
	[self.webView loadHTMLString:pHTMLString baseURL:pBaseURL];
}
- (void)loadData:(NSData *)pData MIMEType:(NSString *)pMIMEType textEncodingName:(NSString *)pTextEncodingName baseURL:(NSURL *)pBaseURL {
	[self.webView loadData:pData MIMEType:pMIMEType textEncodingName:pTextEncodingName baseURL:pBaseURL];
}
- (void)loadHTMLFilename:(NSString *)pFilename inBundle:(NSBundle *)pBundle {
	NSURL *resourceURL = ZWResourceURLInBundle(pFilename, pBundle);
	NSString *htmlString = [NSString stringWithContentsOfURL:resourceURL encoding:NSUTF8StringEncoding error:nil];
	[self loadHTMLString:htmlString baseURL:pBundle.resourceURL];
}
- (void)reload {
	[self.webView reload];
}
- (void)stopLoading {
	[self.webView stopLoading];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)pWebView {
}
- (BOOL)webView:(UIWebView *)pWebView shouldStartLoadWithRequest:(NSURLRequest *)pRequest navigationType:(UIWebViewNavigationType)pNavigationType {
	return YES;
}
- (void)webView:(UIWebView *)pWebView didFailLoadWithError:(NSError *)pError {
	[ZWActivityIndicatorController dismissInViewController:self];
}
- (void)webViewDidFinishLoad:(UIWebView *)pWebView {
}

#pragma mark - Dealloc

- (void)dealloc {
    self.webView.delegate = nil;
	webView = nil;
}

@end
