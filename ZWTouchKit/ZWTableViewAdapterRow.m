#import "ZWTableViewAdapterRow.h"
#import "ZWTableViewAdapterSection.h"

@interface ZWTableViewAdapterRow() {
}

#if OBJC_ARC_WEAK
@property (nonatomic, weak) ZWTableViewAdapterSection *section;
#else
@property (nonatomic, assign) ZWTableViewAdapterSection *section;
#endif

@end
@implementation ZWTableViewAdapterRow

#pragma mark - Properties

@synthesize reuseIdentifier;
@synthesize cell;
@synthesize height;
@synthesize canEdit;
@synthesize canMove;
@synthesize editingStyle;
@synthesize shouldIndentWhileEditing;
@synthesize titleForDeleteConfirmationButton;
@synthesize indentationLevel;
@synthesize representedObject;
@synthesize section;

@synthesize target;
@synthesize action;

- (void)setCell:(UITableViewCell *)pValue {
	if(pValue != cell) {
		cell = pValue;
		height = (cell == nil) ? height : cell.contentView.frame.size.height;
	}
}
- (void)setTarget:(id)pTarget action:(SEL)pAction {
	self.target = pTarget;
	self.action = pAction;
}

#pragma mark - Initialization

+ (id)row {
	return [[self alloc] init];
}
- (id)init {
	if((self = [super init])) {
		self.reuseIdentifier = nil;
		self.cell = nil;
		self.height = -1.0;
		self.canEdit = NO;
		self.canMove = NO;
		self.editingStyle = UITableViewCellEditingStyleNone;
		self.shouldIndentWhileEditing = NO;
		self.titleForDeleteConfirmationButton = nil;
		self.indentationLevel = 0;
	}
	return self;
}

#pragma mark - Dealloc

- (void)dealloc {
	self.cell = nil;
	self.section = nil;
	self.target = nil;
	self.action = nil;
}

@end
