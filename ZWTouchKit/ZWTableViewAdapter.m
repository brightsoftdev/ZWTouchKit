#import "ZWTableViewAdapter.h"
#import "ZWTableViewAdapterPrivate.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/message.h>

ZWTableViewAdapterDelegateFlags ZWTableViewAdapterDelegateFlagsMake(id <ZWTableViewAdapterDelegate> delegate) {
	ZWTableViewAdapterDelegateFlags flags;
	//[delegate respondsToSelector:@selector(tableViewAdapter:numberOfRowsInSection:atIndex:)];
	flags.tableViewAdapterCellForRowAtIndexPath = [delegate respondsToSelector:@selector(tableViewAdapter:cellForRow:atIndexPath:)];
	//[delegate respondsToSelector:@selector(numberOfSectionsInTableViewAdapter:)];
	//[delegate respondsToSelector:@selector(tableViewAdapter:titleForHeaderInSection:atIndex:)];
	//[delegate respondsToSelector:@selector(tableViewAdapter:titleForFooterInSection:atIndex:)];
	//[delegate respondsToSelector:@selector(tableViewAdapter:canEditRow:atIndexPath:)];
	//[delegate respondsToSelector:@selector(tableViewAdapter:canMoveRow:atIndexPath:)];
	flags.sectionIndexTitlesForTableViewAdapter = [delegate respondsToSelector:@selector(sectionIndexTitlesForTableViewAdapter:)];
	flags.tableViewAdapterSectionForSectionIndexTitleAtIndex = [delegate respondsToSelector:@selector(tableViewAdapter:sectionForSectionIndexTitle:atIndex:)];
	flags.tableViewAdapterCommitEditingStyleForRowAtIndexPath = [delegate respondsToSelector:@selector(tableViewAdapter:commitEditingStyle:forRow:atIndexPath:)];
	flags.tableViewAdapterMoveRowAtIndexPathToIndexPath = [delegate respondsToSelector:@selector(tableViewAdapter:moveRow:atIndexPath:toIndexPath:)];
	
	flags.tableViewAdapterWillDisplayCellForRowAtIndexPath = [delegate respondsToSelector:@selector(tableViewAdapter:willDisplayCell:forRow:atIndexPath:)];
	//[delegate respondsToSelector:@selector(tableViewAdapter:heightForRow:atIndexPath:)];
	//[delegate respondsToSelector:@selector(tableViewAdapter:heightForHeaderInSection:atIndex:)];
	//[delegate respondsToSelector:@selector(tableViewAdapter:heightForFooterInSection:atIndex:)];
	//[delegate respondsToSelector:@selector(tableViewAdapter:viewForHeaderInSection:atIndex:)];
	//[delegate respondsToSelector:@selector(tableViewAdapter:viewForFooterInSection:atIndex:)];
	flags.tableViewAdapterAccessoryButtonTappedForRowWithIndexPath = [delegate respondsToSelector:@selector(tableViewAdapter:accessoryButtonTappedForRow:withIndexPath:)];
	flags.tableViewAdapterWillSelectRowWithIndexPath = [delegate respondsToSelector:@selector(tableViewAdapter:willSelectRow:atIndexPath:)];
	flags.tableViewAdapterWillDeselectRowWithIndexPath = [delegate respondsToSelector:@selector(tableViewAdapter:willDeselectRow:atIndexPath:)];
	flags.tableViewAdapterDidSelectRowWithIndexPath = [delegate respondsToSelector:@selector(tableViewAdapter:didSelectRow:atIndexPath:)];
	flags.tableViewAdapterDidDeselectRowWithIndexPath = [delegate respondsToSelector:@selector(tableViewAdapter:didDeselectRow:atIndexPath:)];
	//[delegate respondsToSelector:@selector(tableViewAdapter:editingStyleForRow:atIndexPath:)];
	//[delegate respondsToSelector:@selector(tableViewAdapter:titleForDeleteConfirmationButtonForRow:atIndexPath:)];
	//[delegate respondsToSelector:@selector(tableViewAdapter:shouldIndentWhileEditingRow:atIndexPath:)];
	flags.tableViewAdapterWillBeginEditingRowAtIndexPath = [delegate respondsToSelector:@selector(tableViewAdapter:willBeginEditingRow:atIndexPath:)];
	flags.tableViewAdapterDidEndEditingRowAtIndexPath = [delegate respondsToSelector:@selector(tableViewAdapter:didEndEditingRow:atIndexPath:)];
	flags.tableViewAdapterTargetIndexPathForMoveFromRowAtIndexPathToProposedIndexPath = [delegate respondsToSelector:@selector(tableViewAdapter:targetIndexPathForMoveFromRow:atIndexPath:toProposedIndexPath:)];
	//[delegate respondsToSelector:@selector(tableViewAdapter:indentationLevelForRow:atIndexPath)];
	return flags;
}

@implementation ZWTableViewAdapter

#pragma mark - Properties

@synthesize tableView;
@synthesize delegate;
@dynamic sections;
@synthesize mutableSections;
@synthesize flags;
@synthesize updating;
@synthesize rowAnimation;

- (void)setTableView:(UITableView *)pValue {
	if(pValue != self.tableView) {
		tableView.delegate = nil;
		tableView.dataSource = nil;
		tableView = pValue;
		self.flags = ZWTableViewAdapterDelegateFlagsMake(delegate);
		tableView.delegate = self;
		tableView.dataSource = self;
		[tableView reloadData];
	}
}
- (void)setDelegate:(id <ZWTableViewAdapterDelegate>)pValue {
	if(pValue != delegate) {
		delegate = pValue;
		self.tableView.delegate = nil;
		self.tableView.dataSource = nil;
		self.flags = ZWTableViewAdapterDelegateFlagsMake(delegate);
		self.tableView.delegate = self;
		self.tableView.dataSource = self;
		[self.tableView reloadData];
	}
}
- (NSArray *)sections {
	return self.mutableSections;
}
- (void)setSections:(NSArray *)pValue {
	[self.mutableSections removeAllObjects];
	[self.mutableCopy addObjectsFromArray:pValue];
}

#pragma mark - Property Actions

- (BOOL)respondsToSelector:(SEL)pSelector {
	if(pSelector == @selector(sectionIndexTitlesForTableView:)) {
		return self.flags.sectionIndexTitlesForTableViewAdapter;
	} else if(pSelector == @selector(tableView:sectionForSectionIndexTitle:atIndex:)) {
		return self.flags.tableViewAdapterSectionForSectionIndexTitleAtIndex;
	} else if(pSelector == @selector(tableView:commitEditingStyle:forRowAtIndexPath:)) {
		return self.flags.tableViewAdapterCommitEditingStyleForRowAtIndexPath;
	} else if(pSelector == @selector(tableView:moveRowAtIndexPath:toIndexPath:)) {
		return self.flags.tableViewAdapterMoveRowAtIndexPathToIndexPath;
	} else if(pSelector == @selector(tableView:willDisplayCell:forRowAtIndexPath:)) {
		return self.flags.tableViewAdapterWillDisplayCellForRowAtIndexPath;
	} else if(pSelector == @selector(tableView:accessoryTypeForRowWithIndexPath:)) {
		return self.flags.tableViewAdapterAccessoryButtonTappedForRowWithIndexPath;
	} else if(pSelector == @selector(tableView:willSelectRowAtIndexPath:)) {
		return self.flags.tableViewAdapterWillSelectRowWithIndexPath;
	} else if(pSelector == @selector(tableView:willDeselectRowAtIndexPath:)) {
		return self.flags.tableViewAdapterWillDeselectRowWithIndexPath;
	} else if(pSelector == @selector(tableView:didSelectRowAtIndexPath:)) {
		return YES;//self.flags.tableViewAdapterDidSelectRowWithIndexPath;
	} else if(pSelector == @selector(tableView:didDeselectRowAtIndexPath:)) {
		return self.flags.tableViewAdapterDidDeselectRowWithIndexPath;
	} else if(pSelector == @selector(tableView:willBeginEditingRowAtIndexPath:)) {
		return self.flags.tableViewAdapterWillBeginEditingRowAtIndexPath;
	} else if(pSelector == @selector(tableView:didEndEditingRowAtIndexPath:)) {
		return self.flags.tableViewAdapterDidEndEditingRowAtIndexPath;
	} else if(pSelector == @selector(tableView:targetIndexPathForMoveFromRowAtIndexPath:toProposedIndexPath:)) {
		return self.flags.tableViewAdapterTargetIndexPathForMoveFromRowAtIndexPathToProposedIndexPath;
	} else if(pSelector == @selector(scrollViewDidScroll:) ||
			  pSelector == @selector(scrollViewWillBeginDragging:) ||
			  pSelector == @selector(scrollViewDidEndDragging:willDecelerate:) ||
			  pSelector == @selector(scrollViewShouldScrollToTop:) ||
			  pSelector == @selector(scrollViewDidScrollToTop:) ||
			  pSelector == @selector(scrollViewWillBeginDragging:) ||
			  pSelector == @selector(scrollViewDidEndDecelerating:) ||
			  pSelector == @selector(viewForZoomingInScrollView:) ||
			  pSelector == @selector(scrollViewDidEndZooming:withView:atScale:) ||
			  pSelector == @selector(scrollViewWillBeginZooming:withView:) ||
			  pSelector == @selector(scrollViewDidZoom:)) {
		return [self.delegate respondsToSelector:pSelector];
	}
	return [super respondsToSelector:pSelector];
}
- (void)forwardInvocation:(NSInvocation *)pInvocation {
	if([self.delegate respondsToSelector:pInvocation.selector]) {
		[pInvocation invokeWithTarget:self.delegate];
	} else {
		[super forwardInvocation:pInvocation];
	}
}

#pragma mark - Initialization

+ (id)adapterWithTableView:(UITableView *)pTableView delegate:(id)pDelegate {
	return [[self alloc] initWithTableView:pTableView delegate:pDelegate];
}
- (id)initWithTableView:(UITableView *)pTableView delegate:(id)pDelegate {
	if((self = [super init])) {
		self.delegate = pDelegate;
		self.tableView = pTableView;
		self.mutableSections = [NSMutableArray array];
	}
	return self;
}

#pragma mark - Nib

- (void)awakeFromNib {
	[super awakeFromNib];
	self.mutableSections = [NSMutableArray array];
	self.flags = ZWTableViewAdapterDelegateFlagsMake(delegate);
	[self.tableView reloadData];
}

#pragma mark - Updating

- (void)beginUpdates:(UITableViewRowAnimation)pRowAnimation {
	if(self.updating) {
		return;
	}
	self.updating = YES;
	self.rowAnimation = pRowAnimation;
	if(self.rowAnimation == UITableViewRowAnimationNone) {
		[CATransaction begin];
		[CATransaction setDisableActions:YES];
	}
	[self.tableView beginUpdates];
}
- (void)endUpdates {
	if(!self.updating) {
		return;
	}
	[self.tableView endUpdates];
	[CATransaction commit];
	self.updating = NO;
}

#pragma mark - Sections

- (ZWTableViewAdapterSection *)insertSection {
	return [[self insertSectionsAtIndexes:[NSIndexSet indexSetWithIndex:[self.sections count]]] objectAtIndex:0];
}
- (ZWTableViewAdapterSection *)insertSectionAtIndex:(NSUInteger)pIndex {
	return [[self insertSectionsAtIndexes:[NSIndexSet indexSetWithIndex:pIndex]] objectAtIndex:0];
}
- (NSArray *)insertSectionsAtIndexes:(NSIndexSet *)pIndexes {
	NSMutableArray *newSections = [NSMutableArray arrayWithCapacity:[pIndexes count]];
	for(NSInteger i = 0; i < [pIndexes count]; ++i) {
		[newSections addObject:[ZWTableViewAdapterSection section]];
	}
	[self.mutableSections insertObjects:newSections atIndexes:pIndexes];
	if(self.updating) {
		[self.tableView insertSections:pIndexes withRowAnimation:self.rowAnimation];
	}
	return newSections;
}

- (ZWTableViewAdapterSection *)sectionAtIndex:(NSUInteger)pIndex {
	return [self.mutableSections objectAtIndex:pIndex];
}
- (NSUInteger)indexForSection:(ZWTableViewAdapterSection *)pSection {
	return [self.mutableSections indexOfObject:pSection];
}

- (void)removeSectionAtIndex:(NSUInteger)pIndex {
	[self removeSectionsAtIndexes:[NSIndexSet indexSetWithIndex:pIndex]];
}
- (void)removeAllSections {
	[self removeSectionsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [self.mutableSections count])]];
}
- (void)removeSectionsAtIndexes:(NSIndexSet *)pIndexes {
	[self.mutableSections removeObjectsAtIndexes:pIndexes];
	if(self.updating) {
		[self.tableView deleteSections:pIndexes withRowAnimation:self.rowAnimation];
	}
}

#pragma mark - Rows

- (ZWTableViewAdapterRow *)insertRow {
    if ([self.sections count] == 0) {
        /* Automatically add a section if there are no sections to add the row to */
        [self insertSection];
    }
	NSUInteger sectionIndex = [self.sections count] - 1;
	NSUInteger rowIndex = [[[self.sections objectAtIndex:sectionIndex] rows] count];
	return [self insertRowAtIndexPath:[NSIndexPath indexPathForRow:rowIndex inSection:sectionIndex]];
}
- (ZWTableViewAdapterRow *)insertRowInSectionAtIndex:(NSUInteger)pSectionIndex {
	ZWTableViewAdapterSection *section = [self sectionAtIndex:pSectionIndex];
	return [self insertRowAtIndexPath:[NSIndexPath indexPathForRow:[[section rows] count] inSection:pSectionIndex]];
}
- (ZWTableViewAdapterRow *)insertRowAtIndexPath:(NSIndexPath *)pIndexPath {
	return [[self insertRowsAtIndexPaths:[NSArray arrayWithObject:pIndexPath]] objectAtIndex:0];
}
- (NSArray *)insertRowsAtIndexPaths:(NSArray *)pIndexPaths {
	NSMutableArray *newRows = [NSMutableArray arrayWithCapacity:[pIndexPaths count]];
	for(NSIndexPath *indexPath in pIndexPaths) {
		ZWTableViewAdapterSection *section = [self sectionAtIndex:indexPath.section];
		ZWTableViewAdapterRow *row = [ZWTableViewAdapterRow row];
		row.section = section;
		[[section mutableRows] insertObject:row atIndex:indexPath.row];
		[newRows addObject:row];
	}
	if(self.updating) {
		[self.tableView insertRowsAtIndexPaths:pIndexPaths withRowAnimation:self.rowAnimation];
	}
	return newRows;
}

- (ZWTableViewAdapterRow *)rowAtIndexPath:(NSIndexPath *)pIndexPath {
	return [[[self sectionAtIndex:pIndexPath.section] rows] objectAtIndex:pIndexPath.row];
}
- (NSIndexPath *)indexPathForRow:(ZWTableViewAdapterRow *)pRow {
	ZWTableViewAdapterSection *section = pRow.section;
	return [NSIndexPath indexPathForRow:[section.rows indexOfObject:pRow] inSection:[self indexForSection:section]];
}

- (void)removeRowAtIndexPath:(NSIndexPath *)pIndexPath {
	[self removeRowsAtIndexes:[NSIndexSet indexSetWithIndex:pIndexPath.row] inSectionAtIndex:pIndexPath.section];
}
- (void)removeAllRowsInSectionAtIndex:(NSUInteger)pSectionIndex {
	ZWTableViewAdapterSection *section = [self sectionAtIndex:pSectionIndex];
	NSRange range = NSMakeRange(0, [section.rows count]);
	if(range.length == 0) {
		return;
	}
	[self removeRowsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:range] inSectionAtIndex:pSectionIndex];
}
- (void)removeRowsAtIndexes:(NSIndexSet *)pIndexes inSectionAtIndex:(NSUInteger)pSectionIndex {
	ZWTableViewAdapterSection *section = [self sectionAtIndex:pSectionIndex];
	[[[section rows] objectsAtIndexes:pIndexes] makeObjectsPerformSelector:@selector(setSection:) withObject:nil];
	[[section mutableRows] removeObjectsAtIndexes:pIndexes];
	if(updating) {
		NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:[pIndexes count]];
		NSInteger index = [pIndexes firstIndex];
		do {
			[indexPaths addObject:[NSIndexPath indexPathForRow:index inSection:pSectionIndex]];
		} while((index = [pIndexes indexGreaterThanIndex:index]) != NSNotFound);
		[self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:self.rowAnimation];
	}
}

#pragma mark - Cells

- (UITableViewCell *)cellForRow:(ZWTableViewAdapterRow *)pRow {
	return [self.tableView cellForRowAtIndexPath:[self indexPathForRow:pRow]];
}
- (NSIndexPath *)indexPathForCell:(UITableViewCell *)pCell {
	NSIndexPath *indexPath = [self.tableView indexPathForCell:pCell];
	if(indexPath != nil) {
		return indexPath;
	}
	for(ZWTableViewAdapterSection *section in self.sections) {
		for(ZWTableViewAdapterRow *row in section.rows) {
			if(row.cell == pCell) {
				return [NSIndexPath indexPathForRow:[section.rows indexOfObject:row] inSection:[self.sections indexOfObject:section]];
			}
		}
	}
	return nil;
}
- (ZWTableViewAdapterRow *)rowForCell:(UITableViewCell *)pCell {
	NSIndexPath *indexPath = [self indexPathForCell:pCell];
	if(indexPath != nil) {
		return [self rowAtIndexPath:indexPath];
	}
	return nil;
}

#pragma mark - UITableViewDelegate

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)pTableView {
	return [self.delegate sectionIndexTitlesForTableViewAdapter:self];
}
- (NSInteger)tableView:(UITableView *)pTableView sectionForSectionIndexTitle:(NSString *)pTitle atIndex:(NSInteger)pIndex {
	return [self.sections indexOfObject:[self.delegate tableViewAdapter:self sectionForSectionIndexTitle:pTitle atIndex:pIndex]];
}
- (void)tableView:(UITableView *)pTableView willDisplayCell:(UITableViewCell *)pCell forRowAtIndexPath:(NSIndexPath *)pIndexPath {
	[self.delegate tableViewAdapter:self willDisplayCell:pCell forRow:[self rowAtIndexPath:pIndexPath] atIndexPath:pIndexPath];
}
- (CGFloat)tableView:(UITableView *)pTableView heightForRowAtIndexPath:(NSIndexPath *)pIndexPath {
	CGFloat h = [self rowAtIndexPath:pIndexPath].height;
	return (h == 0) ? pTableView.rowHeight : h;
}
- (CGFloat)tableView:(UITableView *)pTableView heightForHeaderInSection:(NSInteger)pSection {
	return [self sectionAtIndex:pSection].headerHeight;
}
- (CGFloat)tableView:(UITableView *)pTableView heightForFooterInSection:(NSInteger)pSection {
	return [self sectionAtIndex:pSection].footerHeight;
}
- (UIView *)tableView:(UITableView *)pTableView viewForHeaderInSection:(NSInteger)pSection {
	return [self sectionAtIndex:pSection].headerView;
}
- (UIView *)tableView:(UITableView *)pTableView viewForFooterInSection:(NSInteger)pSection {
	return [self sectionAtIndex:pSection].footerView;
}
- (void)tableView:(UITableView *)pTableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)pIndexPath {
	[self.delegate tableViewAdapter:self accessoryButtonTappedForRow:[self rowAtIndexPath:pIndexPath] withIndexPath:pIndexPath];
}
- (NSIndexPath *)tableView:(UITableView *)pTableView willSelectRowAtIndexPath:(NSIndexPath *)pIndexPath {
	return [self.delegate tableViewAdapter:self willSelectRow:[self rowAtIndexPath:pIndexPath] atIndexPath:pIndexPath];
}
- (NSIndexPath *)tableView:(UITableView *)pTableView willDeselectRowAtIndexPath:(NSIndexPath *)pIndexPath {
	return [self.delegate tableViewAdapter:self willDeselectRow:[self rowAtIndexPath:pIndexPath] atIndexPath:pIndexPath];
}
- (void)tableView:(UITableView *)pTableView didSelectRowAtIndexPath:(NSIndexPath *)pIndexPath {
	ZWTableViewAdapterRow *row = [self rowAtIndexPath:pIndexPath];
	
	if(row.target != nil && row.action != nil) {
		objc_msgSend(row.target, row.action, row);
		[self.tableView deselectRowAtIndexPath:pIndexPath animated:NO];
		return;
	}
	
	if([self.delegate respondsToSelector:@selector(tableViewAdapter:didSelectRow:atIndexPath:)]) {
		[self.delegate tableViewAdapter:self didSelectRow:row atIndexPath:pIndexPath];
	}
}
- (void)tableView:(UITableView *)pTableView didDeselectRowAtIndexPath:(NSIndexPath *)pIndexPath {
	return [self.delegate tableViewAdapter:self didDeselectRow:[self rowAtIndexPath:pIndexPath] atIndexPath:pIndexPath];
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)pTableView editingStyleForRowAtIndexPath:(NSIndexPath *)pIndexPath {
	return [self rowAtIndexPath:pIndexPath].editingStyle;
}
- (NSString *)tableView:(UITableView *)pTableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)pIndexPath {
	return [self rowAtIndexPath:pIndexPath].titleForDeleteConfirmationButton;
}
- (BOOL)tableView:(UITableView *)pTableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)pIndexPath {
	return [self rowAtIndexPath:pIndexPath].shouldIndentWhileEditing;
}
- (void)tableView:(UITableView *)pTableView willBeginEditingRowAtIndexPath:(NSIndexPath *)pIndexPath {
	[self.delegate tableViewAdapter:self willBeginEditingRow:[self rowAtIndexPath:pIndexPath] atIndexPath:pIndexPath];
}
- (void)tableView:(UITableView *)pTableView didEndEditingRowAtIndexPath:(NSIndexPath *)pIndexPath {
	[self.delegate tableViewAdapter:self didEndEditingRow:[self rowAtIndexPath:pIndexPath] atIndexPath:pIndexPath];
}
- (void)tableView:(UITableView *)pTableView commitEditingStyle:(UITableViewCellEditingStyle)pEditingStyle forRowAtIndexPath:(NSIndexPath *)pIndexPath {
	[self.delegate tableViewAdapter:self commitEditingStyle:pEditingStyle forRow:[self rowAtIndexPath:pIndexPath] atIndexPath:pIndexPath];
}
- (NSIndexPath *)tableView:(UITableView *)pTableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)pSourceIndexPath toProposedIndexPath:(NSIndexPath *)pProposedDestinationIndexPath {
	return [self.delegate tableViewAdapter:self
			 targetIndexPathForMoveFromRow:[self rowAtIndexPath:pSourceIndexPath]
							   atIndexPath:pSourceIndexPath
					   toProposedIndexPath:pProposedDestinationIndexPath];
}
- (NSInteger)tableView:(UITableView *)pTableView indentationLevelForRowAtIndexPath:(NSIndexPath *)pIndexPath {
	return [self rowAtIndexPath:pIndexPath].indentationLevel;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)pTableView numberOfRowsInSection:(NSInteger)pSection {
	return [[self sectionAtIndex:pSection].rows count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)pTableView {
	return [self.mutableSections count];
}
- (NSString *)tableView:(UITableView *)pTableView titleForHeaderInSection:(NSInteger)pSection {
	return [self sectionAtIndex:pSection].headerTitle;
}
- (NSString *)tableView:(UITableView *)pTableView titleForFooterInSection:(NSInteger)pSection {
	return [self sectionAtIndex:pSection].footerTitle;
}
- (BOOL)tableView:(UITableView *)pTableView canEditRowAtIndexPath:(NSIndexPath *)pIndexPath {
	return [self rowAtIndexPath:pIndexPath].canEdit;
}
- (BOOL)tableView:(UITableView *)pTableView canMoveRowAtIndexPath:(NSIndexPath *)pIndexPath {
	return [self rowAtIndexPath:pIndexPath].canMove;
}
- (UITableViewCell *)tableView:(UITableView *)pTableView cellForRowAtIndexPath:(NSIndexPath *)pIndexPath {
	ZWTableViewAdapterRow *row = [self rowAtIndexPath:pIndexPath];
	UITableViewCell *c = nil;
	
	// use row's cell if it exists
	if(row.cell != nil) {
		c = row.cell;
	} else if([row.reuseIdentifier length] > 0) {
		// try to dequeue a cell
		c = [self.tableView dequeueReusableCellWithIdentifier:row.reuseIdentifier];
	}
	
    if (!c) {
        // ask delegate for cell
        if(self.flags.tableViewAdapterCellForRowAtIndexPath) {
            UITableViewCell *dc = [delegate tableViewAdapter:self cellForRow:row atIndexPath:pIndexPath];
            if(dc != nil) {
                c = dc;
            }
        }
    }
	
	return c;
}

#pragma mark - Dealloc

- (void)dealloc {
	self.delegate = nil;
}

@end
