//
//  ZWTransitionView.m
//  Mobile Fotos
//
//  Created by Karl von Randow on 8/05/08.
//  Copyright 2008 ZW72 Ltd. All rights reserved.
//

#import "ZWTransitionView.h"


@implementation ZWTransitionView

@synthesize delegate;
@synthesize slideAnimationDuration;
@synthesize uiTransitionAnimationDuration;
@synthesize fadeAnimationDuration;
@synthesize ignoreInteractionEvents;

- (void)_initZWTransitionView {
	needsLayout = YES;
	slideAnimationDuration = 0.4;
	uiTransitionAnimationDuration = 0.75;
	fadeAnimationDuration = 0.5;
}

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame]) != nil) {
		[self _initZWTransitionView];
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ((self = [super initWithCoder:aDecoder]) != nil) {
		[self _initZWTransitionView];
	}
	return self;
}

- (void)dealloc {
    if (delegate) {
		ZWLog(@"*** WARNING: delegate not nil in dealloc. Please set delegate to nil when releasing.");
	}
    
}

- (void)layoutSubviews {
	if (needsLayout) {
		needsLayout = NO;
		if ([delegate respondsToSelector:@selector(transitionViewWillLayoutSubviews:)])
			[delegate transitionViewWillLayoutSubviews:self];
	}
}

- (void)setFrame:(CGRect)frame_ {
	needsLayout = YES;
	[super setFrame:frame_];
}

- (CGRect)offsetRect:(CGRect)rect by:(CGPoint)pt {
	rect.origin.x += pt.x;
	rect.origin.y += pt.y;
	return rect;
}

- (CGRect)reverseOffsetRect:(CGRect)rect by:(CGPoint)pt {
	rect.origin.x -= pt.x;
	rect.origin.y -= pt.y;
	return rect;
}

- (void)fireDidTransitionFromView:(UIView *)fromView toView:(UIView *)toView withTransition:(ZWTransitionViewType)transition context:(id)context {
	[delegate transitionView:self didTransitionFromView:fromView toView:toView withTransition:transition context:context];

	if (ignoreInteractionEvents)
		[[UIApplication sharedApplication] endIgnoringInteractionEvents];
}

- (void)removeFromView:(UIView *)fromView withToView:(UIView *)toView {
	/* Remove the fromView unless one of them contains the other, in which case it's your bag and you deal with it */
	if (![toView isDescendantOfView:fromView] && ![fromView isDescendantOfView:toView]) {
		[fromView removeFromSuperview];
	}
}

- (void)addToView:(UIView *)toView {
	/* Add the toView to us, unless it's already part of us somehow */
	if (![toView isDescendantOfView:self]) {
		[self addSubview:toView];
	}
}

- (void)animationDidStop:(NSString *)animationKey finished:(BOOL)finished context:(id)context {
	NSDictionary *myContext = (NSDictionary *)context;

	UIView *fromView = [myContext objectForKey:@"fromView"];
	UIView *toView = [myContext objectForKey:@"toView"];
	NSValue *fromViewOriginalFrame = [myContext objectForKey:@"fromViewOriginalFrame"];
	NSNumber *fromViewOriginalAlpha = [myContext objectForKey:@"fromViewOriginalAlpha"];

	[self removeFromView:fromView withToView:toView];
	if (fromViewOriginalFrame)
		fromView.frame = [fromViewOriginalFrame CGRectValue];
	if (fromViewOriginalAlpha)
		fromView.alpha = [fromViewOriginalAlpha floatValue];

	[self fireDidTransitionFromView:fromView
							 toView:toView
					 withTransition:[[myContext objectForKey:@"transition"] intValue]
							context:[myContext objectForKey:@"context"]];
}

- (void)_slideFromView:(UIView *)fromView
				toView:(UIView *)toView
		withTransition:(ZWTransitionViewType)transition
				 delta:(CGPoint)delta
				  fade:(BOOL)fade
			   context:(id)context {
	CGRect toViewFrame = toView.frame;

	toView.frame = [self reverseOffsetRect:toViewFrame by:delta];
	if (fade)
		toView.alpha = 0;
	[self addToView:toView];

	NSMutableDictionary *myContext = [NSMutableDictionary dictionaryWithCapacity:4];
	if (fromView) {
		[myContext setObject:fromView forKey:@"fromView"];
		[myContext setObject:[NSValue valueWithCGRect:fromView.frame] forKey:@"fromViewOriginalFrame"];
	}
	if (toView)
		[myContext setObject:toView forKey:@"toView"];
	if (context)
		[myContext setObject:context forKey:@"context"];
	[myContext setObject:[NSNumber numberWithInt:transition] forKey:@"transition"];
	if (fade)
		[myContext setObject:[NSNumber numberWithFloat:fromView.alpha] forKey:@"fromViewOriginalAlpha"];

	[UIView beginAnimations:nil context:(__bridge_retained void *)(myContext)];
	[UIView setAnimationDuration:slideAnimationDuration];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];

    if (fromView)
        fromView.frame = [self offsetRect:fromView.frame by:delta];
	toView.frame = toViewFrame;
	if (fade) {
		toView.alpha = 1;
		fromView.alpha = 0;
	}

	[UIView commitAnimations];
}

- (void)transitionSlideLeftFromView:(UIView *)fromView toView:(UIView *)toView context:(id)context {
	[self _slideFromView:fromView
				  toView:toView
		  withTransition:ZWTransitionViewTypeSlideLeft
				   delta:CGPointMake(-self.bounds.size.width, 0)
					fade:NO
				 context:context];
}

- (void)transitionSlideRightFromView:(UIView *)fromView toView:(UIView *)toView context:(id)context {
	[self _slideFromView:fromView
				  toView:toView
		  withTransition:ZWTransitionViewTypeSlideRight
				   delta:CGPointMake(self.bounds.size.width, 0)
					fade:NO
				 context:context];
}

- (void)transitionHalfSlideLeftFromView:(UIView *)fromView toView:(UIView *)toView context:(id)context {
	[self _slideFromView:fromView
				  toView:toView
		  withTransition:ZWTransitionViewTypeSlideLeft
				   delta:CGPointMake(-self.bounds.size.width / 2, 0)
					fade:YES
				 context:context];
}

- (void)transitionHalfSlideRightFromView:(UIView *)fromView toView:(UIView *)toView context:(id)context {
	[self _slideFromView:fromView
				  toView:toView
		  withTransition:ZWTransitionViewTypeSlideRight
				   delta:CGPointMake(self.bounds.size.width / 2, 0)
					fade:YES
				 context:context];
}

- (void)transitionSlideUpFromView:(UIView *)fromView toView:(UIView *)toView context:(id)context {
	[self _slideFromView:fromView
				  toView:toView
		  withTransition:ZWTransitionViewTypeSlideUp
				   delta:CGPointMake(0, -self.bounds.size.height)
					fade:NO
				 context:context];
}

- (void)transitionSlideDownFromView:(UIView *)fromView toView:(UIView *)toView context:(id)context {
	[self _slideFromView:fromView
				  toView:toView
		  withTransition:ZWTransitionViewTypeSlideDown
				   delta:CGPointMake(0, self.bounds.size.height)
					fade:NO
				 context:context];
}

- (void)_transitionFromView:(UIView *)fromView toView:(UIView *)toView withUITransition:(ZWTransitionViewType)transition context:(id)context {
	NSMutableDictionary *myContext = [NSMutableDictionary dictionaryWithCapacity:3];

	if (fromView)
		[myContext setObject:fromView forKey:@"fromView"];
	[myContext setObject:toView forKey:@"toView"];
	if (context)
		[myContext setObject:context forKey:@"context"];

	[UIView beginAnimations:nil context:(__bridge_retained void *)(myContext)];
	[UIView setAnimationDuration:uiTransitionAnimationDuration];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
	switch (transition) {
		case ZWTransitionViewTypeFlipFromLeft:
			[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self cache:YES];
			break;

		case ZWTransitionViewTypeFlipFromRight:
			[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self cache:YES];
			break;

		case ZWTransitionViewTypeCurlUp:
			[UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self cache:YES];
			break;

		case ZWTransitionViewTypeCurlDown:
			[UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self cache:YES];
			break;

		default:
			break;
	}
	[self removeFromView:fromView withToView:toView];
	[self addToView:toView];
	[UIView commitAnimations];
}

- (void)transitionFadeFromView:(UIView *)fromView toView:(UIView *)toView context:(id)context {
	[self addToView:toView];
	toView.alpha = 0;

	NSMutableDictionary *myContext = [NSMutableDictionary dictionaryWithCapacity:3];
	if (fromView)
		[myContext setObject:fromView forKey:@"fromView"];
	if (toView)
		[myContext setObject:toView forKey:@"toView"];
	if (context)
		[myContext setObject:context forKey:@"context"];
	[myContext setObject:[NSNumber numberWithFloat:fromView.alpha] forKey:@"fromViewOriginalAlpha"];

	[UIView beginAnimations:nil context:(__bridge_retained void *)(myContext)];
	[UIView setAnimationDuration:fadeAnimationDuration];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
	toView.alpha = 1;
	fromView.alpha = 0;
	[UIView commitAnimations];
}

- (void)transitionNoneFromView:(UIView *)fromView toView:(UIView *)toView context:(id)context {
	[self addToView:toView];

	[self removeFromView:fromView withToView:toView];

	[self fireDidTransitionFromView:fromView toView:toView withTransition:ZWTransitionViewTypeNone context:context];
}

- (void)transitionBeginCustomFromView:(UIView *)fromView toView:(UIView *)toView context:(id)context {
	[self addToView:toView];

	if ([delegate respondsToSelector:@selector(transitionView:didBeginCustomTransitionFromView:toView:context:)]) {
		[delegate transitionView:self didBeginCustomTransitionFromView:fromView toView:toView context:context];
	}
}

- (void)transitionCompleteCustomFromView:(UIView *)fromView toView:(UIView *)toView context:(id)context {
	[self removeFromView:fromView withToView:toView];

	[self fireDidTransitionFromView:fromView toView:toView withTransition:ZWTransitionViewTypeCustom context:context];

	/* Extra 'end' to make up for the begin-custom not firing an 'end' */
	if (ignoreInteractionEvents)
		[[UIApplication sharedApplication] endIgnoringInteractionEvents];
}

#pragma mark API

- (void)transition:(ZWTransitionViewType)transition fromView:(UIView *)fromView toView:(UIView *)toView context:(id)context {
	if (ignoreInteractionEvents)
		[[UIApplication sharedApplication] beginIgnoringInteractionEvents];

	switch (transition) {
		case ZWTransitionViewTypeSlideLeft:
			[self transitionSlideLeftFromView:fromView toView:toView context:context];
			break;

		case ZWTransitionViewTypeSlideRight:
			[self transitionSlideRightFromView:fromView toView:toView context:context];
			break;

		case ZWTransitionViewTypeSlideUp:
			[self transitionSlideUpFromView:fromView toView:toView context:context];
			break;

		case ZWTransitionViewTypeSlideDown:
			[self transitionSlideDownFromView:fromView toView:toView context:context];
			break;

		case ZWTransitionViewTypeFlipFromLeft:
		case ZWTransitionViewTypeFlipFromRight:
		case ZWTransitionViewTypeCurlUp:
		case ZWTransitionViewTypeCurlDown:
			[self _transitionFromView:fromView toView:toView withUITransition:transition context:context];
			break;

		case ZWTransitionViewTypeNone:
			[self transitionNoneFromView:fromView toView:toView context:context];
			break;

		case ZWTransitionViewTypeFade:
			[self transitionFadeFromView:fromView toView:toView context:context];
			break;

		case ZWTransitionViewTypeHalfSlideLeft:
			[self transitionHalfSlideLeftFromView:fromView toView:toView context:context];
			break;

		case ZWTransitionViewTypeHalfSlideRight:
			[self transitionHalfSlideRightFromView:fromView toView:toView context:context];
			break;

		case ZWTransitionViewTypeCustom:
			[self transitionBeginCustomFromView:fromView toView:toView context:context];
			break;

		case ZWTransitionViewTypeCustomComplete:
			[self transitionCompleteCustomFromView:fromView toView:toView context:context];
			break;
	}
}

@end
