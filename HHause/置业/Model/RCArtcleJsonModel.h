//
//  RCArtcleJsonModel.h
//  HHause
//
//  Created by HHause on 16/8/8.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "JSONModel.h"

@interface RCArtcleJsonModel : JSONModel
@property (nonatomic,copy) NSString * id;//文章编号
@property (nonatomic,copy) NSString * penname;//作者笔名
@property (nonatomic,copy) NSString * preview;//七牛资源名
@property (nonatomic,copy) NSString * publish_time;//发布时间
@property (nonatomic,copy) NSString * summary;//文章概要
@property (nonatomic,copy) NSString * title;//文章标题
@property (nonatomic,copy) NSString * views;//文章点击次数
@end
