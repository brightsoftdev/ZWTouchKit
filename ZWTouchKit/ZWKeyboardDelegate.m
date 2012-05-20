#import "ZWKeyboardDelegate.h"

void ZWKeyboardDelegateToggleNotificationObservers(id <ZWKeyboardDelegate> target, BOOL toggled) {
	NSArray *selectorNames = [NSArray arrayWithObjects:
							  @"keyboardWillShowNotification:",
							  @"keyboardDidShowNotification:",
							  @"keyboardWillHideNotification:",
							  @"keyboardDidHideNotification:",
							  nil];
	NSArray *notificationNames = [NSArray arrayWithObjects:
								  UIKeyboardWillShowNotification,
								  UIKeyboardDidShowNotification,
								  UIKeyboardWillHideNotification,
								  UIKeyboardDidHideNotification,
								  nil];
	[notificationNames enumerateObjectsUsingBlock:^(NSString *notificationName, NSUInteger idx, BOOL *stop) {
		SEL selector = NSSelectorFromString([selectorNames objectAtIndex:idx]);
		if([target respondsToSelector:selector]) {
			if(toggled) {
				[[NSNotificationCenter defaultCenter] addObserver:target
														 selector:selector
															 name:notificationName
														   object:nil];
			} else {
				[[NSNotificationCenter defaultCenter] removeObserver:target
																name:notificationName
															  object:nil];
			}
		}
	}];
}
void ZWKeyboardDelegateAddNotificationObservers(id <ZWKeyboardDelegate> target) {
	ZWKeyboardDelegateToggleNotificationObservers(target, YES);
};
void ZWKeyboardDelegateRemoveNotificationObservers(id <ZWKeyboardDelegate> target) {
	ZWKeyboardDelegateToggleNotificationObservers(target, NO);
};