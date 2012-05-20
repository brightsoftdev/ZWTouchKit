#import <UIKit/UIKit.h>

@interface UITableView (ZWTouchExtensions)

#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_5_0 || __IPHONE_OS_VERSION_MAX_ALLOWED <= __IPHONE_4_3
- (void)registerNib:(UINib *)pNib forCellReuseIdentifier:(NSString *)pIdentifier;
#endif

@end
