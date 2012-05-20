#import "ZWTableViewAdapterSection.h"

@interface ZWTableViewAdapterSection() {
}

@property (nonatomic, strong) NSMutableArray *mutableRows;

@end
@implementation ZWTableViewAdapterSection

#pragma mark - Properties

@synthesize headerTitle;
@synthesize footerTitle;
@dynamic headerHeight;
@dynamic footerHeight;
@synthesize headerView;
@synthesize footerView;
@dynamic rows;
@synthesize representedObject;
@synthesize mutableRows;

- (CGFloat)headerHeight {
	if(self.headerView != nil) {
		return self.headerView.frame.size.height;
	} else if(self.headerTitle != nil) {
		return (iOS5) ? UITableViewAutomaticDimension : 22.0; 
	}
	return (iOS5) ? UITableViewAutomaticDimension : 0.0; 
}
- (CGFloat)footerHeight {
	if(self.footerView != nil) {
		return self.footerView.frame.size.height;
	} else if(self.footerTitle != nil) {
		return (iOS5) ? UITableViewAutomaticDimension : 22.0; 
	}
	return (iOS5) ? UITableViewAutomaticDimension : 0.0; 
}
- (NSArray *)rows {
	return self.mutableRows;
}

#pragma mark - Initialization

+ (id)section {
	return [[self alloc] init];
}
- (id)init {
	if((self = [super init])) {
		self.headerTitle = nil;
		self.footerTitle = nil;
		self.headerView = nil;
		self.footerView = nil;
		self.representedObject = nil;
		self.mutableRows = [NSMutableArray array];
	}
	return self;
}

#pragma mark - Dealloc

- (void)dealloc {
	[self.mutableRows makeObjectsPerformSelector:@selector(setSection:) withObject:nil];
}

@end
