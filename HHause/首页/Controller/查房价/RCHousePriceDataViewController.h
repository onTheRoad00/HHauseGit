//
//  RCHousePriceDataViewController.h
//  HHause
//
//  Created by HHause on 2016/11/11.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCHousePriceDataViewController : UIViewController
@property(nonatomic,copy) NSString * name;
@property(nonatomic,strong) NSArray * market_dataAry;
@property(nonatomic,copy) NSString * name_cn;
@property(nonatomic,copy) NSString * market_region;
@end
