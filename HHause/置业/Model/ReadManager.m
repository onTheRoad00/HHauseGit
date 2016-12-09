//
//  ReadManager.m
//  CareGossip4
//
//  Created by Administrator on 15/11/24.
//  Copyright © 2015年 北京雨恒矩阵科技有限公司. All rights reserved.
//

#import "ReadManager.h"

@implementation ReadManager
+(instancetype)share
{
    static ReadManager * m = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m = [[ReadManager alloc]init];
    });
    return m;
}
@end
