//
//  RCHomesModel.h
//  HHause
//
//  Created by HHause on 16/8/12.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "JSONModel.h"

@interface RCHomesModel : JSONModel
@property (nonatomic,copy) NSString * addr;
/**
 *房源属性。
 0 = 不具备以下任何属性。注意：不等于不限属性
 1 = 投资房
 2 = 学区房
 4 = 豪宅
 3 = 投资房 + 学区房
 5 = 投资房 + 豪宅
 6 = 学区房 + 豪宅
 7 = 投资房 + 学区房 + 豪宅
 */
@property (nonatomic,copy) NSString * attributes;

@property (nonatomic,copy) NSString * id;
@property (nonatomic,copy) NSString * mls;
@property (nonatomic,copy) NSString * built_year;
@property (nonatomic,copy) NSString * price;

@property (nonatomic,copy) NSString * state;
@property (nonatomic,copy) NSString * city;

@property (nonatomic,copy) NSString * favors;
@property (nonatomic,copy) NSString * views;
//建筑面积
@property (nonatomic,copy) NSString * floor_area;
//占地面积
@property (nonatomic,copy) NSString * space_area;

@property (nonatomic,copy) NSString * bedrooms;
//完整浴室
@property (nonatomic,copy) NSString * full_baths;
//不完整浴室
@property (nonatomic,copy) NSString * partial_baths;

//图片地址->七牛  拼串
@property (nonatomic,copy) NSString * preview;


/**
 房源类型。
 A = 公寓
 H = 独栋别墅
 T = 联排别墅
 */
@property (nonatomic,copy) NSString * type;
@property (nonatomic,copy) NSString * is_my_favor;
@end
