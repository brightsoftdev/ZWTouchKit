#import <UIKit/UIKit.h>


@interface ZWAlertView : UIAlertView {
	id userInfo;
}

#pragma mark - Properties

@property (nonatomic, strong) id userInfo;

#pragma mark - Initialization

/*
 * Creating an alert with an error is easy enough.
 * NSLocalizedDescriptionKey - this becomes the title
 * NSLocalizedRecoverySuggestionErrorKey - this becomes the message
 * NSLocalizedRecoveryOptionsErrorKey - this should be an array of buttons, if empty "Dismiss" will be shown as default. The last button in the array is the cancel button.
 */
+ (id)alertViewWithError:(NSError *)pError;
- (id)initWithError:(NSError *)pError;

#pragma mark - Actions

- (void)showWithCompletionHandler:(void (^)(ZWAlertView *alertView, NSInteger buttonIndex))pCompletionHandler;

@end
