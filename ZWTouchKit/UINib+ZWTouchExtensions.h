#import <UIKit/UIKit.h>


@interface UINib (ZWTouchExtensions)

+ (NSArray *)instantiateNibWithNibName:(NSString *)pNibName bundle:(NSBundle *)pBundle;
+ (NSArray *)instantiateNibWithNibName:(NSString *)pNibName bundle:(NSBundle *)pBundle owner:(id)pOwner options:(NSDictionary *)pOptions;

@end
