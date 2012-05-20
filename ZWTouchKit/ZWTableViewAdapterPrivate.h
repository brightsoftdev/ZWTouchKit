#import "ZWTableViewAdapter.h"

typedef struct {
	BOOL tableViewAdapterCellForRowAtIndexPath;
	BOOL sectionIndexTitlesForTableViewAdapter;
	BOOL tableViewAdapterSectionForSectionIndexTitleAtIndex;
	BOOL tableViewAdapterCommitEditingStyleForRowAtIndexPath;
	BOOL tableViewAdapterMoveRowAtIndexPathToIndexPath;
	BOOL tableViewAdapterWillDisplayCellForRowAtIndexPath;
	BOOL tableViewAdapterAccessoryButtonTappedForRowWithIndexPath;
	BOOL tableViewAdapterWillSelectRowWithIndexPath;
	BOOL tableViewAdapterWillDeselectRowWithIndexPath;
	BOOL tableViewAdapterDidSelectRowWithIndexPath;
	BOOL tableViewAdapterDidDeselectRowWithIndexPath;
	BOOL tableViewAdapterWillBeginEditingRowAtIndexPath;
	BOOL tableViewAdapterDidEndEditingRowAtIndexPath;
	BOOL tableViewAdapterTargetIndexPathForMoveFromRowAtIndexPathToProposedIndexPath;
} ZWTableViewAdapterDelegateFlags;

ZWTableViewAdapterDelegateFlags ZWTableViewAdapterDelegateFlagsMake(id <ZWTableViewAdapterDelegate> delegate);

@interface ZWTableViewAdapterSection (PRIVATE)

- (NSMutableArray *)mutableRows;

@end
@interface ZWTableViewAdapterRow (PRIVATE)

- (ZWTableViewAdapterSection *)section;
- (void)setSection:(ZWTableViewAdapterSection *)pValue;

@end

@interface ZWTableViewAdapter() {
}

@property (nonatomic, strong) NSMutableArray *mutableSections;
@property (nonatomic, assign) ZWTableViewAdapterDelegateFlags flags;
@property (nonatomic, assign) BOOL updating;
@property (nonatomic, assign) UITableViewRowAnimation rowAnimation;

@end