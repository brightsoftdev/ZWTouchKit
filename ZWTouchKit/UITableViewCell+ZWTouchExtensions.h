#import <UIKit/UIKit.h>


@interface UITableViewCell (ZWTouchExtensions)

+ (id)cellWithNibName:(NSString *)pNibNameOrNil nibBundle:(NSBundle *)pNibBundle;
+ (id)cellWithStyle:(UITableViewCellStyle)pStyle reuseIdentifier:(NSString *)pReuseIdentifier;

@end
