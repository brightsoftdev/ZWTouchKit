#import <UIKit/UIKit.h>

@protocol ZWKeyboardDelegate <NSObject>
@optional
- (void)keyboardWillShowNotification:(NSNotification *)pNotification;
- (void)keyboardDidShowNotification:(NSNotification *)pNotification;
- (void)keyboardWillHideNotification:(NSNotification *)pNotification;
- (void)keyboardDidHideNotification:(NSNotification *)pNotification;
@end

extern void ZWKeyboardDelegateToggleNotificationObservers(id <ZWKeyboardDelegate> target, BOOL toggled);
extern void ZWKeyboardDelegateAddNotificationObservers(id <ZWKeyboardDelegate> target);
extern void ZWKeyboardDelegateRemoveNotificationObservers(id <ZWKeyboardDelegate> target);

