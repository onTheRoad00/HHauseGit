//
//  RCCityModel0.h
//  HHause
//
//  Created by HHause on 2016/11/29.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCCityModel0 : NSObject
-(id)init:(NSString*) _id lat:(NSString*) _lat lng:(NSString *) _market_rogion metro_area:(NSString *) _metro_area name:(NSString *)_name name_cn:(NSString *)_name_cn state:(NSString *) _state;
@property (nonatomic,copy) NSString * id;

@property (nonatomic,copy) NSString * lat;
@property (nonatomic,copy) NSString * lng;
@property (nonatomic,copy) NSString * market_rogion;
@property (nonatomic,copy) NSString * metro_area;

@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * name_cn;
@property (nonatomic,copy) NSString * state;
@end
