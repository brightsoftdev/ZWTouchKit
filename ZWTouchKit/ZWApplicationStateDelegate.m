#import "ZWApplicationStateDelegate.h"

void ZWApplicationStateDelegateToggleNotificationObservers(id <ZWApplicationStateDelegate> target, BOOL toggled) {
	NSArray *selectorNames = [NSArray arrayWithObjects:
							  @"applicationWillEnterForegroundNotification:",
							  @"applicationDidEnterBackgroundNotification:",
							  nil];
	NSArray *notificationNames = [NSArray arrayWithObjects:
								  UIApplicationWillEnterForegroundNotification,
								  UIApplicationDidEnterBackgroundNotification,
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
void ZWApplicationStateDelegateAddNotificationObservers(id <ZWApplicationStateDelegate> target) {
	ZWApplicationStateDelegateToggleNotificationObservers(target, YES);
}
void ZWApplicationStateDelegateRemoveNotificationObservers(id <ZWApplicationStateDelegate> target) {
	ZWApplicationStateDelegateToggleNotificationObservers(target, NO);
}