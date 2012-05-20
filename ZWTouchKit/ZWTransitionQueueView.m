//
//  ZWTransitionQueueView.m
//  CameraPlus
//
//  Created by Karl von Randow on 22/08/09.
//  Copyright 2009 ZW72 Ltd. All rights reserved.
//

#import "ZWTransitionQueueView.h"


@implementation ZWTransitionQueueView

- (void)_initZWTransitionQueueView {
	queue = [[NSMutableArray alloc] initWithCapacity:2];
}

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame]) != nil) {
		[self _initZWTransitionQueueView];
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ((self = [super initWithCoder:aDecoder]) != nil) {
		[self _initZWTransitionQueueView];
	}
	return self;
}

- (void)dealloc {
	currentView = nil;
}

#pragma mark API

- (void)transition:(ZWTransitionViewType)transition toView:(UIView *)toView context:(id)context {
	if (!transitioning) {
		transitioning = YES;
		[self transition:transition fromView:currentView toView:toView context:context];
	} else {
		NSDictionary *queued = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:transition], @"transition",
								toView, @"toView", context, @"context", nil];
		[queue addObject:queued];                 // NB. context may be nil
	}
}

- (void)pause:(NSTimeInterval)interval {
	if (!transitioning) {
		transitioning = YES;
		[NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(pauseComplete:) userInfo:nil repeats:NO];
	} else {
		NSDictionary *queued = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:interval], @"interval", nil];
		[queue addObject:queued];
	}
}

- (void)clearQueue {
	[queue removeAllObjects];
}

#pragma mark Queue

- (void)runQueue {
	if ([queue count] > 0) {
		NSDictionary *d = [queue objectAtIndex:0];
		[queue removeObjectAtIndex:0];
		if ([d objectForKey:@"transition"]) {
			[self transition:[[d objectForKey:@"transition"] intValue]
					fromView:currentView
					  toView:[d objectForKey:@"toView"]
					 context:[d objectForKey:@"context"]];
		} else if ([d objectForKey:@"interval"]) {
			[NSTimer scheduledTimerWithTimeInterval:[[d objectForKey:@"interval"] floatValue]
											 target:self
										   selector:@selector(pauseComplete:)
										   userInfo:nil
											repeats:NO];
		} else {
			/* Illegal state, a bad object on the queue */
			NSLog(@"ZWTransitionQueueView: bad object on queue: %@", d);
			[self runQueue];
		}
	} else {
		transitioning = NO;
	}
}

#pragma mark Callbacks

- (void)fireDidTransitionFromView:(UIView *)fromView toView:(UIView *)toView withTransition:(ZWTransitionViewType)transition context:(id)context {
    if (currentView != toView) {
        currentView = toView;
    }

	[self runQueue];

	[super fireDidTransitionFromView:fromView toView:toView withTransition:transition context:context];
}

- (void)pauseComplete:(NSTimer *)timer {
	[self runQueue];
}

- (void)willRemoveSubview:(UIView *)subview {
	[super willRemoveSubview:subview];
	if (subview == currentView) {
		currentView = nil;
	}
}

@end
