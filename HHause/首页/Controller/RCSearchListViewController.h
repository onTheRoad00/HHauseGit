//
//  RCSearchListViewController.h
//  HHause
//
//  Created by HHause on 16/5/26.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCSearchListViewController : UIViewController
@property (nonatomic,copy) NSString * mytitle;

@property (nonatomic,copy) NSString * attributes;    //房源属性
@property (nonatomic,copy) NSString * metro_area;   //都市圈代码
@property (nonatomic,copy) NSString * city;         //英文完整名称
@property (nonatomic,copy) NSString * cityname;         //英文完整名称
@property (nonatomic,copy) NSString * keyword;      //搜索关键字

@property (nonatomic,copy) NSString * type;         //房源类型
@property (nonatomic,copy) NSString * currency;     //货币单位 默认人民币
@property (nonatomic,copy) NSString * price_low;    //价格上限
@property (nonatomic,copy) NSString * price_high;   //价格下限---price_high=price_range_max,表示不设上限
@property (nonatomic,copy) NSString * area_unit;    //面积单位，默认平米
@property (nonatomic,copy) NSString * area_from;    //面积下限
@property (nonatomic,copy) NSString * area_to;      //面积上限
@property (nonatomic,copy) NSString * bath;         //卫生间数量
@property (nonatomic,copy) NSString * room;         //房间数量
@property (nonatomic,copy) NSString * sort_field;   //排序字段名：价格-price,时间-id
@property (nonatomic,copy) NSString * sort;         //asc=升序    desc=降序
@property (nonatomic,assign) NSInteger page;         //页码
@property (nonatomic,copy) NSString * require_total;//返回房源数量；true-是，false-否
@property (nonatomic,copy) NSString * pagesize;     //每页大小
@end
