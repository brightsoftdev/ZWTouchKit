#import <UIKit/UIKit.h>
@class ZWTableViewAdapterSection;


@interface ZWTableViewAdapterRow : NSObject {
}

#pragma mark - Properties

@property (nonatomic, strong) NSString *reuseIdentifier;
@property (nonatomic, strong) UITableViewCell *cell;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) BOOL canEdit;
@property (nonatomic, assign) BOOL canMove;
@property (nonatomic, assign) UITableViewCellEditingStyle editingStyle;
@property (nonatomic, assign) BOOL shouldIndentWhileEditing;
@property (nonatomic, strong) NSString *titleForDeleteConfirmationButton;
@property (nonatomic, assign) NSInteger indentationLevel;
@property (nonatomic, strong) id representedObject;

#if OBJC_ARC_WEAK
@property (nonatomic, weak) id target;
#else
@property (nonatomic, assign) id target;
#endif
@property (nonatomic, assign) SEL action;

- (void)setTarget:(id)pTarget action:(SEL)pAction;

#pragma mark - Initialization

+ (id)row;

@end
