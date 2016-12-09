//
//  RCCityModel.h
//  HHause
//
//  Created by HHause on 2016/11/29.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "JSONModel.h"

@interface RCCityModel : JSONModel
@property (nonatomic,copy) NSString * id;

@property (nonatomic,copy) NSString * lat;
@property (nonatomic,copy) NSString * lng;
@property (nonatomic,copy) NSString * market_region;
@property (nonatomic,copy) NSString * metro_area;

@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * name_cn;
@property (nonatomic,copy) NSString * state;
@end
