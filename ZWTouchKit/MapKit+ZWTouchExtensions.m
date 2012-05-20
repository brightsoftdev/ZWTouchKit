#import "MapKit+ZWTouchExtensions.h"

BOOL MKCoordinateRegionEqual(MKCoordinateRegion region, MKCoordinateRegion otherRegion) {
	return (region.center.latitude == otherRegion.center.latitude &&
			region.center.longitude == otherRegion.center.longitude &&
			region.span.latitudeDelta == otherRegion.span.latitudeDelta &&
			region.span.longitudeDelta == otherRegion.span.longitudeDelta);
}
BOOL MKCoordinateRegionContains(MKCoordinateRegion region, MKCoordinateRegion otherRegion) {
	CLLocationCoordinate2D regionTopRight = CLLocationCoordinate2DMake(region.center.latitude + region.span.latitudeDelta, region.center.longitude + region.span.longitudeDelta);
	CLLocationCoordinate2D regionBottomLeft = CLLocationCoordinate2DMake(region.center.latitude - region.span.latitudeDelta, region.center.longitude - region.span.longitudeDelta);
	CLLocationCoordinate2D otherRegionTopRight = CLLocationCoordinate2DMake(otherRegion.center.latitude + otherRegion.span.latitudeDelta, otherRegion.center.longitude + otherRegion.span.longitudeDelta);
	CLLocationCoordinate2D otherRegionBottomLeft = CLLocationCoordinate2DMake(otherRegion.center.latitude - otherRegion.span.latitudeDelta, otherRegion.center.longitude - otherRegion.span.longitudeDelta);
	
	if(regionBottomLeft.latitude <= otherRegionBottomLeft.latitude &&
	   regionTopRight.latitude >= otherRegionTopRight.latitude &&
	   regionBottomLeft.longitude <= otherRegionBottomLeft.longitude &&
	   regionTopRight.longitude >= otherRegionTopRight.longitude) {
		return YES;
	}
	return NO;
}
BOOL MKCoordinateRegionIsValid(MKCoordinateRegion region) {
	return (CLLocationCoordinate2DIsValid(region.center) &&
			region.center.latitude != 0.0 &&
			region.center.longitude != 0.0 &&
			region.span.latitudeDelta > 0.0 &&
			region.span.longitudeDelta > 0.0);
}
MKCoordinateRegion MKCoordinateRegionScale(MKCoordinateRegion region, CGFloat scale) {
	region.span.latitudeDelta *= scale;
	region.span.longitudeDelta *= scale;
	return region;
}