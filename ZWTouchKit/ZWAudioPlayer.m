#import "ZWAudioPlayer.h"

static NSString *ZWAudioPlayerObservingContext = @"ZWAudioPlayerObserving";

@interface ZWAudioPlayer (PRIVATE)

- (void)_timerFire:(NSTimer *)pTimer;

@end

@implementation ZWAudioPlayer (PRIVATE)

- (void)_timerFire:(NSTimer *)pTimer {
	if(lastCurrentTime != self.currentTime) {
		lastCurrentTime = self.currentTime;
		if([self.delegate respondsToSelector:@selector(audioPlayerDidChangeCurrentTime:)]) {
			[self.delegate audioPlayerDidChangeCurrentTime:self];
		} else if(timer != nil) {
			[timer invalidate];
			timer = nil;
		}
	}
}

@end

@implementation ZWAudioPlayer

#pragma mark - Properties

@dynamic delegate;

- (void)setDelegate:(id <ZWAudioPlayerDelegate>)pDelegate {
	[super setDelegate:pDelegate];
	if([pDelegate respondsToSelector:@selector(audioPlayerDidChangeCurrentTime:)]) {
		if(timer != nil) {
			[timer invalidate];
			timer = nil;
		}
		lastCurrentTime = self.currentTime;
		timer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / 40.0)
												 target:self
											   selector:@selector(_timerFire:)
											   userInfo:nil
												repeats:YES];
	}
}

#pragma mark - Dealloc

- (void)dealloc {
	if(timer != nil) {
		[timer invalidate];
		timer = nil;
	}
	self.delegate = nil;
}

@end
