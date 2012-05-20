#import <Foundation/Foundation.h>
#import "ZWTableViewAdapterRow.h"


@interface ZWTableViewAdapterSection : NSObject {
}

#pragma mark - Properties

@property (nonatomic, strong) NSString *headerTitle;
@property (nonatomic, strong) NSString *footerTitle;
@property (nonatomic, readonly) CGFloat headerHeight;
@property (nonatomic, readonly) CGFloat footerHeight;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong, readonly) NSArray *rows;
@property (nonatomic, strong) id representedObject;

#pragma mark - Initialization

+ (id)section;

@end
