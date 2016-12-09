//
//  RCAroundSchool.h
//  HHause
//
//  Created by HHause on 16/8/17.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "JSONModel.h"

@interface RCAroundSchool : JSONModel
@property (nonatomic,copy) NSString * distance;

@property (nonatomic,copy) NSString * ed_level;
@property (nonatomic,copy) NSString * isPrimary;
@property (nonatomic,copy) NSString * isPublic;
@property (nonatomic,copy) NSString * rating;

@property (nonatomic,copy) NSString * sch_name;
@property (nonatomic,copy) NSString * type;
@end
