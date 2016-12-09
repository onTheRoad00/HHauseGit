//
//  RCRegisterViewController.h
//  HHause
//
//  Created by HHause on 16/5/11.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCRegisterViewController : UIViewController
typedef void(^COLL)(NSString *type,NSString * city_cn);
@property (nonatomic,copy) NSString * navtitle;
@end
