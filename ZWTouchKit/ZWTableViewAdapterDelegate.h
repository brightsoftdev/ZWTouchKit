#import <UIKit/UIKit.h>
@class ZWTableViewAdapter;
@class ZWTableViewAdapterRow;
@class ZWTableViewAdapterSection;
@class ZWTableViewAdapterDelegate;

/*
 
	All commented out delegate methods are probably due to the internal table view adapter handling of the methods.
 
 */
 

@protocol ZWTableViewAdapterDelegate <NSObject, UIScrollViewDelegate>
@optional

//- (NSInteger)tableViewAdapter:(ZWTableViewAdapter *)pTableViewAdapter numberOfRowsInSection:(ZWTableViewAdapterSection *)pSection atIndex:(NSInteger)pIndex;
- (UITableViewCell *)tableViewAdapter:(ZWTableViewAdapter *)pTableViewAdapter cellForRow:(ZWTableViewAdapterRow *)pRow atIndexPath:(NSIndexPath *)pIndexPath;
//- (NSInteger)numberOfSectionsInTableViewAdapter:(ZWTableViewAdapter *)pTableViewAdapter;
//- (NSString *)tableViewAdapter:(ZWTableViewAdapter *)pTableViewAdapter titleForHeaderInSection:(ZWTableViewAdapterSection *)pSection atIndex:(NSInteger)pIndex;
//- (NSString *)tableViewAdapter:(ZWTableViewAdapter *)pTableViewAdapter titleForFooterInSection:(ZWTableViewAdapterSection *)pSection atIndex:(NSInteger)pIndex;
//- (BOOL)tableViewAdapter:(ZWTableViewAdapter *)pTableViewAdapter canEditRow:(ZWTableViewAdapterRow *)pRow atIndexPath:(NSIndexPath *)pIndexPath;
//- (BOOL)tableViewAdapter:(ZWTableViewAdapter *)pTableViewAdapter canMoveRow:(ZWTableViewAdapterRow *)pRow atIndexPath:(NSIndexPath *)pIndexPath;
- (NSArray *)sectionIndexTitlesForTableViewAdapter:(ZWTableViewAdapter *)pTableViewAdapter;
- (ZWTableViewAdapterSection *)tableViewAdapter:(ZWTableViewAdapter *)pTableViewAdapter sectionForSectionIndexTitle:(NSString *)pTitle atIndex:(NSInteger)pIndex;
- (void)tableViewAdapter:(ZWTableViewAdapter *)pTableViewAdapter commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRow:(ZWTableViewAdapterRow *)pRow atIndexPath:(NSIndexPath *)pIndexPath;
- (void)tableViewAdapter:(ZWTableViewAdapter *)pTableViewAdapter moveRow:(ZWTableViewAdapterRow *)pRow atIndexPath:(NSIndexPath *)pSourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;

- (void)tableViewAdapter:(ZWTableViewAdapter *)pTableViewAdapter willDisplayCell:(UITableViewCell *)pCell forRow:(ZWTableViewAdapterRow *)pRow atIndexPath:(NSIndexPath *)pIndexPath;
//- (CGFloat)tableViewAdapter:(ZWTableViewAdapter *)pTableViewAdapter heightForRow:(ZWTableViewAdapterRow *)pRow atIndexPath:(NSIndexPath *)indexPath;
//- (CGFloat)tableViewAdapter:(ZWTableViewAdapter *)pTableViewAdapter heightForHeaderInSection:(ZWTableViewAdapterSection *)pSection atIndex:(NSInteger)pIndex;
//- (CGFloat)tableViewAdapter:(ZWTableViewAdapter *)pTableViewAdapter heightForFooterInSection:(ZWTableViewAdapterSection *)pSection atIndex:(NSInteger)pIndex;
//- (UIView *)tableViewAdapter:(ZWTableViewAdapter *)pTableViewAdapter viewForHeaderInSection:(ZWTableViewAdapterSection *)pSection atIndex:(NSInteger)pIndex;
//- (UIView *)tableViewAdapter:(ZWTableViewAdapter *)pTableViewAdapter viewForFooterInSection:(ZWTableViewAdapterSection *)pSection atIndex:(NSInteger)pIndex;
- (void)tableViewAdapter:(ZWTableViewAdapter *)pTableViewAdapter accessoryButtonTappedForRow:(ZWTableViewAdapterRow *)pRow withIndexPath:(NSIndexPath *)pIndexPath;
- (NSIndexPath *)tableViewAdapter:(ZWTableViewAdapter *)pTableViewAdapter willSelectRow:(ZWTableViewAdapterRow *)pRow atIndexPath:(NSIndexPath *)pIndexPath;
- (NSIndexPath *)tableViewAdapter:(ZWTableViewAdapter *)pTableViewAdapter willDeselectRow:(ZWTableViewAdapterRow *)pRow atIndexPath:(NSIndexPath *)pIndexPath;
- (void)tableViewAdapter:(ZWTableViewAdapter *)pTableViewAdapter didSelectRow:(ZWTableViewAdapterRow *)pRow atIndexPath:(NSIndexPath *)pIndexPath;
- (void)tableViewAdapter:(ZWTableViewAdapter *)pTableViewAdapter didDeselectRow:(ZWTableViewAdapterRow *)pRow atIndexPath:(NSIndexPath *)pIndexPath;
//- (UITableViewCellEditingStyle)tableViewAdapter:(ZWTableViewAdapter *)pTableViewAdapter editingStyleForRow:(ZWTableViewAdapterRow *)pRow atIndexPath:(NSIndexPath *)pIndexPath;
//- (NSString *)tableViewAdapter:(ZWTableViewAdapter *)pTableViewAdapter titleForDeleteConfirmationButtonForRow:(ZWTableViewAdapterRow *)pRow atIndexPath:(NSIndexPath *)pIndexPath;
//- (BOOL)tableViewAdapter:(ZWTableViewAdapter *)pTableViewAdapter shouldIndentWhileEditingRow:(ZWTableViewAdapterRow *)pRow atIndexPath:(NSIndexPath *)pIndexPath;
- (void)tableViewAdapter:(ZWTableViewAdapter *)pTableViewAdapter willBeginEditingRow:(ZWTableViewAdapterRow *)pRow atIndexPath:(NSIndexPath *)pIndexPath;
- (void)tableViewAdapter:(ZWTableViewAdapter *)pTableViewAdapter didEndEditingRow:(ZWTableViewAdapterRow *)pRow atIndexPath:(NSIndexPath *)pIndexPath;
- (NSIndexPath *)tableViewAdapter:(ZWTableViewAdapter *)pTableViewAdapter targetIndexPathForMoveFromRow:(ZWTableViewAdapterRow *)pRow atIndexPath:(NSIndexPath *)pSourceIndexPath toProposedIndexPath:(NSIndexPath *)pProposedDestinationIndexPath;
//- (NSInteger)tableViewAdapter:(ZWTableViewAdapter *)pTableViewAdapter indentationLevelForRow:(ZWTableViewAdapterRow *)pRow atIndexPath:(NSIndexPath *)pIndexPath;

@end