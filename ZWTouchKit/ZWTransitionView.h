//
//  ZWTransitionView.h
//  Mobile Fotos
//
//  Created by Karl von Randow on 8/05/08.
//  Copyright 2008 ZW72 Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
	ZWTransitionViewTypeNone,
	ZWTransitionViewTypeSlideLeft,
	ZWTransitionViewTypeSlideRight,
	ZWTransitionViewTypeSlideUp,
	ZWTransitionViewTypeSlideDown,
	ZWTransitionViewTypeFlipFromRight,
	ZWTransitionViewTypeFlipFromLeft,
	ZWTransitionViewTypeCurlUp,
	ZWTransitionViewTypeCurlDown,
	ZWTransitionViewTypeFade,
	ZWTransitionViewTypeHalfSlideLeft,
	ZWTransitionViewTypeHalfSlideRight,
	ZWTransitionViewTypeCustom,
	ZWTransitionViewTypeCustomComplete
} ZWTransitionViewType;


@protocol ZWTransitionViewDelegate;


@interface ZWTransitionView : UIView {
	@private

	id<ZWTransitionViewDelegate> __unsafe_unretained delegate;
	BOOL needsLayout;
	float slideAnimationDuration;
	float uiTransitionAnimationDuration;
	float fadeAnimationDuration;
	BOOL ignoreInteractionEvents;
}

- (void)transition:(ZWTransitionViewType)transition fromView:(UIView *)fromView toView:(UIView *)toView context:(id)context;
@property (assign, nonatomic) id<ZWTransitionViewDelegate> delegate;
@property (assign, nonatomic) float slideAnimationDuration;
@property (assign, nonatomic) float uiTransitionAnimationDuration;
@property (assign, nonatomic) float fadeAnimationDuration;
@property (assign, nonatomic) BOOL ignoreInteractionEvents;

@end

@interface ZWTransitionView (Private)

- (void)fireDidTransitionFromView:(UIView *)fromView toView:(UIView *)toView withTransition:(ZWTransitionViewType)transition context:(id)context;

@end



@protocol ZWTransitionViewDelegate <NSObject>

- (void)transitionView:(ZWTransitionView *)transitionView didTransitionFromView:(UIView *)fromView toView:(UIView *)toView withTransition:(ZWTransitionViewType)transition context:(id)context;

@optional

- (void)transitionViewWillLayoutSubviews:(ZWTransitionView *)transitionView;

- (void)transitionView:(ZWTransitionView *)transitionView didBeginCustomTransitionFromView:(UIView *)fromView toView:(UIView *)toView context:(id)context;
@end
