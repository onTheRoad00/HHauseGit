//
//  RCAlertView.m
//  HHause
//
//  Created by HHause on 16/5/3.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "RCAlertView.h"

#define timeInterval 2

@implementation RCAlertView


//
//+(void)alertMessage:(NSString*)message
//{
//#if __IPHONE_OS_VERSION_MIN_REQUIRED <= __IPHONE_8_0
//    UIAlertView * alert =[[UIAlertView alloc]initWithTitle:@"警告" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//    [alert show];
//#else
//    [self alertMessageIOS8:message];
//#endif
//}
//
//
//
//+(void)alertMessageIOS8:(NSString*)message{
//    UIAlertController * alertController =[UIAlertController alertControllerWithTitle:@"警告" message:message preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction * okAction =[UIAlertAction actionWithTitle:@"确定" style:1 handler:^(UIAlertAction *action) {
//    }];
//    [alertController addAction:okAction];
//    [AppRootViewController presentViewController:alertController animated:YES completion:nil];
//}




+(void)showMessage:(NSString *)message
{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    UIView *showview =  [[UIView alloc]init];
    showview.backgroundColor = [UIColor blackColor];
    showview.frame = CGRectMake(1, 1, 1, 1);
    showview.alpha = 1.0f;
    showview.layer.cornerRadius = 5.0f;
    showview.layer.masksToBounds = YES;
    [window addSubview:showview];
    
    UILabel *label = [[UILabel alloc]init];
    CGSize LabelSize = [message sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(290, 9000)];
    label.frame = CGRectMake(10, 5, LabelSize.width, LabelSize.height);
    label.text = message;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    [showview addSubview:label];
    showview.frame = CGRectMake((kScreeWidth - LabelSize.width - 20)/2, kScreeHeight - 100, LabelSize.width+20, LabelSize.height+10);
    [UIView animateWithDuration:timeInterval animations:^{
        showview.alpha = 0;
    } completion:^(BOOL finished) {
        [showview removeFromSuperview];
    }];
    
    
}


@end
