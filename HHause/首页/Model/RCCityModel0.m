//
//  RCCityModel0.m
//  HHause
//
//  Created by HHause on 2016/11/29.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "RCCityModel0.h"

@implementation RCCityModel0
@synthesize id,lat,lng,market_rogion,metro_area,name,name_cn,state;
-(id)init:(NSString*) _id lat:(NSString*) _lat lng:(NSString *) _lng market_rogion:(NSString*) _market_rogion metro_area:(NSString *) _metro_area name:(NSString *)_name name_cn:(NSString *)_name_cn state:(NSString *) _state{
    self = [super init];
    self.id = _id;
    self.lat = _lat;
    self.lng = _lng;
    self.market_rogion = _market_rogion;
    self.metro_area = _metro_area;
    self.name = _name;
    self.name_cn = _name_cn;
    self.state = _state;
    
    return self;
}
@end
