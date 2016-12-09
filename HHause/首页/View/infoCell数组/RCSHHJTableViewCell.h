//
//  RCSHHJTableViewCell.h
//  HHause
//
//  Created by SeeYou on 16/5/15.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
@interface RCSHHJTableViewCell : UITableViewCell<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic,strong) CLGeocoder *geocoder;
@property (nonatomic,assign) CLLocationCoordinate2D coordinate;

-(void)getLocationLatitude:(NSString *)latitude longitude:(NSString *)longitude title:(NSString *)title subtitle:(NSString *)subtitle;
@end
