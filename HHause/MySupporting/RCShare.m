//
//  RCShare.m
//  HHause
//
//  Created by HHause on 16/6/1.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "RCShare.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
@implementation RCShare
+(void)shareText:(NSString *)text imageArray:(id)imageArray url:(NSURL *)url title:(NSString *)title
{
//    [SSUIShareActionSheetStyle setShareActionSheetStyle:ShareActionSheetStyleSimple];
    
    
    //    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
//    imageArray = @[[UIImage imageNamed:@"icon"]];
//    _shareSummary = @"测试内容";
//    _shareTitle = @"Work with kind,humble teams that inspire";
//    //分享链接
//    NSURL * _shareUrl =[NSURL URLWithString:@"http://hhause.com/#/"];
    if (imageArray) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
       
        [shareParams SSDKSetupMailParamsByText:[NSString stringWithFormat:@"%@,%@,%@",title,text,url] title:title images:[NSString stringWithFormat:@"%@/.png",imageArray] attachments:nil recipients:nil ccRecipients:nil bccRecipients:nil type:SSDKContentTypeAuto];
        
        [shareParams SSDKSetupShareParamsByText:text
                                         images:imageArray
                                            url:url
                                          title:title
                                           type:SSDKContentTypeAuto];
        
       
        
        
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:@[
                                          @(SSDKPlatformSubTypeWechatSession),
                                           @(SSDKPlatformSubTypeWechatTimeline),
                                          @(SSDKPlatformTypeWechat),
                                          @(SSDKPlatformTypeMail),
                                          // @(SSDKPlatformTypeSMS),
                                          // @(SSDKPlatformTypeCopy),
                                         ]
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       NSString * errstr = [NSString stringWithFormat:@"%@",error];
                       if ([errstr isEqualToString:@"Error Domain=ShareSDKErrorDomain Code=105 \"(null)\" UserInfo={error description =没有有效的分享平台可以显示。原因可能是：分享平台需要客户端才能分享，而这台iOS设备没有安装这些平台的客户端。}"]) {
                           errstr = @"没有有效的分享平台可以显示。原因可能是：分享平台需要客户端才能分享，而这台iOS设备没有安装这些平台的客户端。";
                       }
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",errstr]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];}
}
@end
