#import <AVFoundation/AVFoundation.h>
@class ZWAudioPlayer;

@protocol ZWAudioPlayerDelegate <AVAudioPlayerDelegate>

@optional

- (void)audioPlayerDidFinishPlaying:(ZWAudioPlayer *)pAudioPlayer successfully:(BOOL)pSuccessfully;
- (void)audioPlayerDidChangeCurrentTime:(ZWAudioPlayer *)pAudioPlayer;
- (void)audioPlayerBeginInterruption:(ZWAudioPlayer *)pAudioPlayer;
- (void)audioPlayerEndInterruption:(ZWAudioPlayer *)pAudioPlayer;
- (void)audioPlayerEndInterruption:(ZWAudioPlayer *)pAudioPlayer withFlags:(NSUInteger)pFlags;

@end

@interface ZWAudioPlayer : AVAudioPlayer {
	NSTimer *timer;
	NSTimeInterval lastCurrentTime;
}

#pragma mark - Properties

#if OBJC_ARC_WEAK
@property (weak) id <ZWAudioPlayerDelegate> delegate;
#else
@property (assign) id <ZWAudioPlayerDelegate> delegate;
#endif

@end
