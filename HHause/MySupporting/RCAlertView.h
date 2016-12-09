//
//  RCAlertView.h
//  HHause
//
//  Created by HHause on 16/5/3.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCAlertView : UIView

/**
 *  更具系统版本选择提示框
 *
 *  @param message 提示消息
 */
//+(void)alertMessage:(NSString*)message;


/**
 *  消息提示，timeInterval(1.5)秒后消失
 *
 *  @param message 提示消息
 */
+(void)showMessage:(NSString *)message;
@end
