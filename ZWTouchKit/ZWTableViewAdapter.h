#import <Foundation/Foundation.h>
#import "ZWTableViewAdapterSection.h"
#import "ZWTableViewAdapterRow.h"
#import "ZWTableViewAdapterDelegate.h"


@interface ZWTableViewAdapter : NSObject <UITableViewDelegate, UITableViewDataSource> {
}

#pragma mark - Properties

@property (nonatomic, strong) UITableView *tableView;
#if OBJC_ARC_WEAK
@property (nonatomic, weak) id <ZWTableViewAdapterDelegate> delegate;
#else
@property (nonatomic, assign) id <ZWTableViewAdapterDelegate> delegate;
#endif
@property (nonatomic, strong) NSArray *sections;

#pragma mark - Initialization

+ (id)adapterWithTableView:(UITableView *)pTableView delegate:(id <ZWTableViewAdapterDelegate>)pDelegate;
- (id)initWithTableView:(UITableView *)pTableView delegate:(id <ZWTableViewAdapterDelegate>)pDelegate;

#pragma mark - Updating

- (void)beginUpdates:(UITableViewRowAnimation)pRowAnimation;
- (void)endUpdates;

#pragma mark - Sections

- (ZWTableViewAdapterSection *)insertSection;
- (ZWTableViewAdapterSection *)insertSectionAtIndex:(NSUInteger)pIndex;
- (NSArray *)insertSectionsAtIndexes:(NSIndexSet *)pIndexes;

- (ZWTableViewAdapterSection *)sectionAtIndex:(NSUInteger)pIndex;
- (NSUInteger)indexForSection:(ZWTableViewAdapterSection *)pSection;

- (void)removeSectionAtIndex:(NSUInteger)pIndex;
- (void)removeAllSections;
- (void)removeSectionsAtIndexes:(NSIndexSet *)pIndexes;

#pragma mark - Rows

- (ZWTableViewAdapterRow *)insertRow;
- (ZWTableViewAdapterRow *)insertRowInSectionAtIndex:(NSUInteger)pSectionIndex;
- (ZWTableViewAdapterRow *)insertRowAtIndexPath:(NSIndexPath *)pIndexPath;
- (NSArray *)insertRowsAtIndexPaths:(NSArray *)pIndexPaths;

- (ZWTableViewAdapterRow *)rowAtIndexPath:(NSIndexPath *)pIndexPath;
- (NSIndexPath *)indexPathForRow:(ZWTableViewAdapterRow *)pRow;

- (void)removeRowAtIndexPath:(NSIndexPath *)pIndexPath;
- (void)removeAllRowsInSectionAtIndex:(NSUInteger)pSectionIndex;
- (void)removeRowsAtIndexes:(NSIndexSet *)pIndexes inSectionAtIndex:(NSUInteger)pSectionIndex;

#pragma mark - Cells

- (UITableViewCell *)cellForRow:(ZWTableViewAdapterRow *)pRow;
- (NSIndexPath *)indexPathForCell:(UITableViewCell *)pCell;
- (ZWTableViewAdapterRow *)rowForCell:(UITableViewCell *)pCell;

@end
