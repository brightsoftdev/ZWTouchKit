#import <UIKit/UIKit.h>

@protocol ZWApplicationStateDelegate <NSObject>

@required

- (void)applicationWillEnterForegroundNotification:(NSNotification *)pNotification;
- (void)applicationDidEnterBackgroundNotification:(NSNotification *)pNotification;

@end

extern void ZWApplicationStateDelegateToggleNotificationObservers(id <ZWApplicationStateDelegate> target, BOOL toggled);
extern void ZWApplicationStateDelegateAddNotificationObservers(id <ZWApplicationStateDelegate> target);
extern void ZWApplicationStateDelegateRemoveNotificationObservers(id <ZWApplicationStateDelegate> target);

