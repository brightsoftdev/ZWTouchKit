#import "UIActionSheet+ZWTouchExtensions.h"

@implementation UIActionSheet (ZWTouchExtensions)

+ (id)actionSheetWithTitle:(NSString *)pTitle delegate:(id <UIActionSheetDelegate>)pDelegate cancelButtonTitle:(NSString *)pCancelButtonTitle descructiveButtonTitle:(NSString *)pDestructiveButtonTitle otherButtonTitles:(NSString *)pOtherButtonTitles, ... {
	UIActionSheet *actionSheet = [[self alloc] initWithTitle:pTitle
													delegate:pDelegate
										   cancelButtonTitle:nil
									  destructiveButtonTitle:nil
										   otherButtonTitles:nil];
	va_list args;
	va_start(args, pOtherButtonTitles);
	for(NSString *arg = pOtherButtonTitles; arg != nil; arg = va_arg(args, NSString *)) {
		[actionSheet addButtonWithTitle:arg];
	}
	va_end(args);
	if(pDestructiveButtonTitle != nil) {
		[actionSheet addButtonWithTitle:pDestructiveButtonTitle];
		[actionSheet setDestructiveButtonIndex:[actionSheet numberOfButtons] - 1];
	}
	if(pCancelButtonTitle != nil) {
		[actionSheet addButtonWithTitle:pCancelButtonTitle];
		[actionSheet setCancelButtonIndex:[actionSheet numberOfButtons] - 1];
	}
	return actionSheet;
}

@end
