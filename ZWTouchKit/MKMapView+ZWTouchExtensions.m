#import "MKMapView+ZWTouchExtensions.h"
#import <ZWCoreKit/CoreLocation+ZWExtensions.h>

@implementation MKMapView (ZWTouchExtensions)

- (NSUInteger)zoomLevel {
	return 20 - ceilf(log2(self.region.span.longitudeDelta * ZWMercatorRadius * M_PI / (180.0 * self.bounds.size.width)));
}

- (MKCoordinateRegion)regionThatFitsAnnotations:(NSArray *)pAnnotations {
	if([pAnnotations count] == 0) {
		return MKCoordinateRegionMake(kCLLocationCoordinate2DInvalid, MKCoordinateSpanMake(0.0, 0.0));
	}
	
	CLLocationCoordinate2D coordinateTopLeft;
	coordinateTopLeft.latitude = -90;
	coordinateTopLeft.longitude = 180;
	
	CLLocationCoordinate2D coordinateBottomRight;
	coordinateBottomRight.latitude = 90;
	coordinateBottomRight.longitude = -180;
	
	for(id <MKAnnotation> annotation in pAnnotations) {
		coordinateTopLeft.longitude = fmin(coordinateTopLeft.longitude, annotation.coordinate.longitude);
		coordinateTopLeft.latitude = fmax(coordinateTopLeft.latitude, annotation.coordinate.latitude);
		
		coordinateBottomRight.longitude = fmax(coordinateBottomRight.longitude, annotation.coordinate.longitude);
		coordinateBottomRight.latitude = fmin(coordinateBottomRight.latitude, annotation.coordinate.latitude);
	}
	
	MKCoordinateRegion region;
	region.center.latitude = coordinateTopLeft.latitude - (coordinateTopLeft.latitude - coordinateBottomRight.latitude) * 0.5;
	region.center.longitude = coordinateTopLeft.longitude + (coordinateBottomRight.longitude - coordinateTopLeft.longitude) * 0.5;
	region.span.latitudeDelta = fabs(coordinateTopLeft.latitude - coordinateBottomRight.latitude) * 1.1;
	region.span.longitudeDelta = fabs(coordinateBottomRight.longitude - coordinateTopLeft.longitude) * 1.1;
	return [self regionThatFits:region];
}

@end
