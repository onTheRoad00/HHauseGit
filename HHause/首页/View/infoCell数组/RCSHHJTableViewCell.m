//
//  RCSHHJTableViewCell.m
//  HHause
//
//  Created by SeeYou on 16/5/15.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "RCSHHJTableViewCell.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
@interface RCSHHJTableViewCell ()<MKMapViewDelegate>
@end
@implementation RCSHHJTableViewCell
{
    NSArray * _urlarr;
    //    CLLocationCoordinate2D _coordinate;
}
- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark ---------map--------------
-(void)getLocationLatitude:(NSString *)latitude longitude:(NSString *)longitude title:(NSString *)title subtitle:(NSString *)subtitle{
    
    //    _mapView.mapType = MKMapTypeStandard;
    
    //设置代理
    _mapView.delegate = self;
    
    //设置地图滚动和缩放
    _mapView.zoomEnabled = YES;
    _mapView.scrollEnabled = YES;
        _coordinate.latitude = [latitude doubleValue];
    _coordinate.longitude = [longitude doubleValue];
    //地图跨度
    MKCoordinateSpan span;
    span.latitudeDelta=0.3;
    span.longitudeDelta=0.3;
    MKCoordinateRegion region={_coordinate ,span};
    //大头针
    MKPointAnnotation * annotation1 = [[MKPointAnnotation alloc]init];
    annotation1.coordinate = CLLocationCoordinate2DMake(_coordinate.latitude, _coordinate.longitude);//坐标
    annotation1.title = title;
    annotation1.subtitle = subtitle;
    //在地图上放置大头针
    [_mapView addAnnotation:annotation1];
    [_mapView setRegion:region];
    _mapView.showsUserLocation = YES;
}

@end
