//
//  RCGETRequest.h
//  HHause
//
//  Created by HHause on 16/5/3.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCGETRequest : NSObject
+(void) requestWithUrl:(NSString *)urlString Complete:(void (^)(NSData *data))success faile:(void(^)(NSError *error))failture;
@end
