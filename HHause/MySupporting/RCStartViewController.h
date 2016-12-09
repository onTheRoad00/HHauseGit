//
//  RCStartViewController.h
//  HHause
//
//  Created by HHause on 16/5/3.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^Start)();
@interface RCStartViewController : UIViewController
@property (nonatomic,copy) Start start;
@end
