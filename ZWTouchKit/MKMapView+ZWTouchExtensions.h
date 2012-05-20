#import <MapKit/MapKit.h>


@interface MKMapView (ZWTouchExtensions)

@property (nonatomic, readonly) NSUInteger zoomLevel;

- (MKCoordinateRegion)regionThatFitsAnnotations:(NSArray *)pAnnotations;

@end
