//
//  RCHouseModel.h
//  HHause
//
//  Created by HHause on 16/8/16.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "JSONModel.h"

@interface RCHouseModel : JSONModel


@property (nonatomic,copy) NSString * id;
@property (nonatomic,copy) NSString * mls;

/**
 房源类型。
 A = 公寓
 H = 独栋别墅
 T = 联排别墅
 */
@property (nonatomic,copy) NSString * type;
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
@property (nonatomic,copy) NSString * bedrooms;
//完整浴室
@property (nonatomic,copy) NSString * full_baths;
//不完整浴室
@property (nonatomic,copy) NSString * partial_baths;
//州代码
@property (nonatomic,copy) NSString * state;
//城市圈
@property (nonatomic,copy) NSString * metro_area;
@property (nonatomic,copy) NSString * city;
@property (nonatomic,copy) NSString * city_id;
//县
@property (nonatomic,copy) NSString * county;
//街道地址
@property (nonatomic,copy) NSString * addr;
//邮编
@property (nonatomic,copy) NSString * zip;
//投资指数
@property (nonatomic,copy) NSString * rating;
//点击数
@property (nonatomic,copy) NSString * views;
//图片地址->七牛  拼串
@property (nonatomic,copy) NSString * preview;
//社区ID
@property (nonatomic,copy) NSString * community_id;
//社区名称
@property (nonatomic,copy) NSString * community;
//数据状态 0 - 正常（在售），1 - 已售，2 - 下线
@property (nonatomic,copy) NSString * status;
//公寓所在楼层号
@property (nonatomic,copy) NSString * floor_number;
//建筑层数
@property (nonatomic,copy) NSString * floors;
//车位数
@property (nonatomic,copy) NSString * parkings;
//建筑面积(平方英尺)
@property (nonatomic,copy) NSString * floor_area;
//占地面积
@property (nonatomic,copy) NSString * space_area;
//建筑年代
@property (nonatomic,copy) NSString * built_year;
//总价(美元)
@property (nonatomic,copy) NSString * price;
//单位平方英尺价格(美元)
@property (nonatomic,copy) NSString * price_sqft;
//物业费（美元/月）
@property (nonatomic,copy) NSString * hoa_fee;
//预估月租金
@property (nonatomic,copy) NSString * est_rent;
//取暖 0-未知，1-暖气，2-空调
@property (nonatomic,copy) NSString * heat;
//地理位置坐标-经度
@property (nonatomic,copy) NSString * lng;
//地理位置坐标-纬度
@property (nonatomic,copy) NSString * lat;
//房屋优势
@property (nonatomic,copy) NSString * advantage;
//房屋介绍
@property (nonatomic,copy) NSString * intro;
//房屋图片
@property (nonatomic,copy) NSString * images;

//更新时间
@property (nonatomic,copy) NSString * update_time;
@property (nonatomic,copy) NSString * update_uid;
//收藏
@property (nonatomic,copy) NSString * favors;
//税率%
@property (nonatomic,copy) NSString * tax_rate;

//我有没有收藏
@property (nonatomic,copy) NSString * is_my_favor;
@end
