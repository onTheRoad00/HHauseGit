//
//  RCShare.h
//  HHause
//
//  Created by HHause on 16/6/1.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCShare : NSObject
+(void)shareText:(NSString *)text imageArray:(id)imageArray url:(NSURL *)url title:(NSString *)title;
@end
