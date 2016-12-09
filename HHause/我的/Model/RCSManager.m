//
//  RCSManager.m
//  HHause
//
//  Created by HHause on 16/7/4.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "RCSManager.h"

@implementation RCSManager
+(instancetype)sshare
{
    static RCSManager * m = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m = [[RCSManager alloc]init];
    });
    return m;
}
@end
