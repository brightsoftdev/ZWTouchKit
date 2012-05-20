//
//  ZWTransitionQueueView.h
//  CameraPlus
//
//  Created by Karl von Randow on 22/08/09.
//  Copyright 2009 ZW72 Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZWTransitionView.h"

@interface ZWTransitionQueueView : ZWTransitionView {
	@private
	UIView *currentView;
	NSMutableArray *queue;
	BOOL transitioning;
}

- (void)transition:(ZWTransitionViewType)transition toView:(UIView *)toView context:(id)context;
- (void)pause:(NSTimeInterval)interval;
- (void)clearQueue;
@end
