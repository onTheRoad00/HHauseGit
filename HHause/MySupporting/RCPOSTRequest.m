//
//  RCPOSTRequest.m
//  HHause
//
//  Created by HHause on 16/5/3.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "RCPOSTRequest.h"
#import "AFNetworking.h"
@implementation RCPOSTRequest
//功能:完成网络请求
//参数:urlString 网址
//    success    请求完成时的回调
//    faliture   请求失败时的回调

+(void) requestWithUrl:(NSString *)urlString parameters:(NSDictionary *)parameters Complete:(void (^)(NSData *data))success faile:(void(^)(NSError *error))failture
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    
    
    //  ****************************HHause需要*************************
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    //在设置header头
    [manager.requestSerializer setValue:[ud valueForKey:KKEYUUID] forHTTPHeaderField:@"X-Tracing-Id"];
    //  ****************************HHause需要*************************
    
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //调用success
        success(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         failture(error);
        
    }];
}

@end
