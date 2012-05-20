#import <MapKit/MapKit.h>

extern BOOL MKCoordinateRegionEqual(MKCoordinateRegion region, MKCoordinateRegion otherRegion);
extern BOOL MKCoordinateRegionContains(MKCoordinateRegion region, MKCoordinateRegion otherRegion);
extern BOOL MKCoordinateRegionIsValid(MKCoordinateRegion region);
extern MKCoordinateRegion MKCoordinateRegionScale(MKCoordinateRegion region, CGFloat scale);