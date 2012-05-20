#import <UIKit/UIKit.h>


@interface ZWActionSheet : UIActionSheet {
}

#pragma mark - Properties

@property (nonatomic, strong) id userInfo;

#pragma mark - Actions

- (void)showFromTabBar:(UITabBar *)pTabBar completionHandler:(void (^)(ZWActionSheet *actionSheet, NSInteger buttonIndex))pCompletionHandler;
- (void)showFromToolbar:(UIToolbar *)pToolBar completionHandler:(void (^)(ZWActionSheet *actionSheet, NSInteger buttonIndex))pCompletionHandler;
- (void)showInView:(UIView *)pView completionHandler:(void (^)(ZWActionSheet *actionSheet, NSInteger buttonIndex))pCompletionHandler;
- (void)showFromBarButtonItem:(UIBarButtonItem *)pItem animated:(BOOL)pAnimated completionHandler:(void (^)(ZWActionSheet *actionSheet, NSInteger buttonIndex))pCompletionHandler;
- (void)showFromRect:(CGRect)pRect inView:(UIView *)pView animated:(BOOL)pAnimated completionHandler:(void (^)(ZWActionSheet *actionSheet, NSInteger buttonIndex))pCompletionHandler;

@end
