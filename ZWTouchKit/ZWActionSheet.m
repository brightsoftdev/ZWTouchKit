#import "ZWActionSheet.h"

@interface  ZWActionSheet() {
}

#pragma mark - Properties

@property (nonatomic, copy) void (^completionHandler)(ZWActionSheet *actionSheet, NSInteger buttonIndex);

@end
@implementation ZWActionSheet

#pragma mark - Properties

@synthesize userInfo;
@synthesize completionHandler;

#pragma mark - UIView

- (void)willMoveToSuperview:(UIView *)pNewSuperview {
	if(pNewSuperview == nil) {
		self.completionHandler = nil;
	}
	[super willMoveToSuperview:pNewSuperview];
}

#pragma mark - Actions

- (void)showFromTabBar:(UITabBar *)pTabBar completionHandler:(void (^)(ZWActionSheet *actionSheet, NSInteger buttonIndex))pCompletionHandler {
	if(self.delegate != nil) {
		ZWLog(@"WARNING: resetting delegate on ZWActionSheet because completion handler will be used.");
	}
	self.delegate = (id <UIActionSheetDelegate>)self;
	self.completionHandler = pCompletionHandler;
	[self showFromTabBar:pTabBar];
}
- (void)showFromToolbar:(UIToolbar *)pToolBar completionHandler:(void (^)(ZWActionSheet *actionSheet, NSInteger buttonIndex))pCompletionHandler {
	if(self.delegate != nil) {
		ZWLog(@"WARNING: resetting delegate on ZWActionSheet because completion handler will be used.");
	}
	self.delegate = (id <UIActionSheetDelegate>)self;
	self.completionHandler = pCompletionHandler;
	[self showFromToolbar:pToolBar];
}
- (void)showInView:(UIView *)pView completionHandler:(void (^)(ZWActionSheet *actionSheet, NSInteger buttonIndex))pCompletionHandler {
	if(self.delegate != nil) {
		ZWLog(@"WARNING: resetting delegate on ZWActionSheet because completion handler will be used.");
	}
	self.delegate = (id <UIActionSheetDelegate>)self;
	self.completionHandler = pCompletionHandler;
	[self showInView:pView];
}
- (void)showFromBarButtonItem:(UIBarButtonItem *)pItem animated:(BOOL)pAnimated completionHandler:(void (^)(ZWActionSheet *actionSheet, NSInteger buttonIndex))pCompletionHandler {
	if(self.delegate != nil) {
		ZWLog(@"WARNING: resetting delegate on ZWActionSheet because completion handler will be used.");
	}
	self.delegate = (id <UIActionSheetDelegate>)self;
	self.completionHandler = pCompletionHandler;
	[self showFromBarButtonItem:pItem animated:pAnimated];
}
- (void)showFromRect:(CGRect)pRect inView:(UIView *)pView animated:(BOOL)pAnimated completionHandler:(void (^)(ZWActionSheet *actionSheet, NSInteger buttonIndex))pCompletionHandler {
	if(self.delegate != nil) {
		ZWLog(@"WARNING: resetting delegate on ZWActionSheet because completion handler will be used.");
	}
	self.delegate = (id <UIActionSheetDelegate>)self;
	self.completionHandler = pCompletionHandler;
	[self showFromRect:pRect inView:pView animated:pAnimated];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)pActionSheet clickedButtonAtIndex:(NSInteger)pButtonIndex {
	if(self.completionHandler != nil) {
		self.completionHandler(self, pButtonIndex);
	}
}

@end
