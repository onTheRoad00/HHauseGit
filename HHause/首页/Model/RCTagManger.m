//
//  RCTagManger.m
//  HHause
//
//  Created by HHause on 16/5/13.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "RCTagManger.h"

@implementation RCTagManger
+(instancetype)tag
{
    static RCTagManger * m =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m =[[RCTagManger alloc]init];
    });
    return m;
}
@end
