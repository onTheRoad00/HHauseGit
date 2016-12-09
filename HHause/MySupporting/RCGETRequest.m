//
//  RCGETRequest.m
//  HHause
//
//  Created by HHause on 16/5/3.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "RCGETRequest.h"

@implementation RCGETRequest
//功能:完成网络请求
//参数:urlString 网址
//    success    请求完成时的回调
//    faliture   请求失败时的回调

+(void) requestWithUrl:(NSString *)urlString Complete:(void (^)(NSData *data))success faile:(void(^)(NSError *error))failture
{
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    securityPolicy.allowInvalidCertificates = YES; //还是必须设成YES
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
//  ****************************HHause需要*************************
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    //在设置header头
    [manager.requestSerializer setValue:[ud valueForKey:KKEYUUID] forHTTPHeaderField:@"X-Tracing-Id"];
//  ****************************HHause需要************************* 
   [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //调用success
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failture(error);
    }];
    
}
@end
