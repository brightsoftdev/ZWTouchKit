#import <UIKit/UIKit.h>


@interface UIActionSheet (ZWTouchExtensions)

+ (id)actionSheetWithTitle:(NSString *)pTitle 
				  delegate:(id <UIActionSheetDelegate>)pDelegate 
		 cancelButtonTitle:(NSString *)pCancelButtonTitle 
		descructiveButtonTitle:(NSString *)pDestructiveButtonTitle 
		 otherButtonTitles:(NSString *)pOtherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

@end
