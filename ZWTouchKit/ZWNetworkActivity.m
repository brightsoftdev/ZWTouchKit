#import "ZWNetworkActivity.h"
#import <UIKit/UIKit.h>

@implementation ZWNetworkActivity

static NSInteger ZWNetworkActivityCount = 0;
+ (void)beginNetworkActivity {
	if(++ZWNetworkActivityCount > 0) {
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	}
}
+ (void)endNetworkActivity {
	if(--ZWNetworkActivityCount <= 0) {
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	}
	ZWNetworkActivityCount = MAX(0, ZWNetworkActivityCount);
}

@end
