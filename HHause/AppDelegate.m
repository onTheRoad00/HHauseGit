//
//  AppDelegate.m
//  HHause
//
//  Created by HHause on 16/5/3.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "AppDelegate.h"
#import "RCTabBarViewController.h"
#import "RCStartViewController.h"
#import "RCSrearchViewController.h"

#import "BaiduMobStat.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
////腾讯开放平台（对应QQ和QQ空间）SDK头文件
//#import <TencentOpenAPI/TencentOAuth.h>
//#import <TencentOpenAPI/QQApiInterface.h>
////微信SDK头文件
#import "WXApi.h"
////新浪微博SDK头文件
//#import "WeiboSDK.h"
////新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"

#define IsFirstLoad  @"IsFirstLoad"
#define KKEYTIME @"time"
@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate
{
    NSString *curTime;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self shareSdk];
//    [self startBaiduMobileStat];

    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor=[UIColor whiteColor];
    
    
    NSTimeInterval nowtime = [[NSDate date] timeIntervalSince1970]/60/60/24;
    int theTime = [[NSNumber numberWithDouble:nowtime] intValue];
    curTime = [NSString stringWithFormat:@"%d",theTime];
   
   
//    //    //判断程序是否是第一次运行
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
//
//    //获得键值
    NSString * firstLoad = [ud valueForKey:IsFirstLoad];
    if (!firstLoad) {//第一次运行
//        //写入文件
//        //[self writeToDocuments];
        RCStartViewController * start = [[RCStartViewController alloc] init];
        self.window.rootViewController = start;
        start.start = ^(){
            [self tabBarController];
        };
        //改写userdefault的IsFirstLoad对应的值为1
        [ud setObject:@"1" forKey:IsFirstLoad];
//        NSLog(@"%@",[[NSUUID UUID] UUIDString]);
//        UDID---X-Tracing-Id
        [ud setObject:[[NSUUID UUID] UUIDString] forKey:KKEYUUID];
        [ud synchronize];//同步写入磁盘
        
//        存入时间
        [ud setObject:curTime forKey:KKEYTIME];
        
        
    }else{
        NSString * lastTime = [ud valueForKey:KKEYTIME];

        if (theTime -[lastTime intValue] >4) {
//            NSLog(@"判断时间");
            [self UpdateAlert];

        }
    
        [self tabBarController];
    }
    [self.window makeKeyAndVisible];
    
    [NSThread sleepForTimeInterval:1.5];//设置启动页面时间
    
    return YES;
}

-(void) tabBarController{
    RCTabBarViewController *tabBarController=[[RCTabBarViewController alloc]init];
    
    tabBarController.delegate=self;
    
    [tabBarController setcontroller:@"RCIndexViewController" title:@"首页" imageNamed:@"tab100.png" selectedImageName:@"tab111.png"];
//    [tabBarController setcontroller:@"RCSrearchViewController" title:@"搜索" imageNamed:@"tab20.png" selectedImageName:@"tab21.png"];
    [tabBarController setcontroller:@"RCWikiViewController" title:@"置业百科" imageNamed:@"tab300.png" selectedImageName:@"tab311.png"];
    [tabBarController setcontroller:@"RCMineViewController" title:@"我的" imageNamed:@"tab400.png" selectedImageName:@"tab411.png"];
    
    tabBarController.selectedViewController=tabBarController.viewControllers[0];
    self.window.rootViewController=tabBarController;
}

#pragma mark ---------------UITabBarControllerDelegate-----------------
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController NS_AVAILABLE_IOS(3_0)
{
    //    NSLog(@"在将要选中某个控制器的时候调用,如果返回yes允许选中,否则不允许选中");
    //    if(tabBarController.viewControllers[2]==viewController)
    //        return NO;
    //    else
    return YES;
}

// 启动百度移动统计
- (void)startBaiduMobileStat{
   
    BaiduMobStat* statTracker = [BaiduMobStat defaultStat];
    // 此处(startWithAppId之前)可以设置初始化的可选参数，具体有哪些参数，可详见BaiduMobStat.h文件，例如：
    statTracker.shortAppVersion  = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    //设置是否打印SDK中的日志,用于调试
    statTracker.enableDebugOn = YES;
    //自动监控策略
    statTracker.monitorStrategy = YES;
    
    [statTracker startWithAppId:@"30441576fe"]; // 设置您在mtj网站上添加的app的appkey,此处AppId即为应用的appKey
}


//shareSdK
-(void)shareSdk{
        /**
         *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册，
         *  在将生成的AppKey传入到此方法中。
         *  方法中的第二个第三个参数为需要连接社交平台SDK时触发，
         *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
         *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
         */
        [ShareSDK registerApp:@"131ca99622410"
         
              activePlatforms:@[
//                                @(SSDKPlatformTypeSinaWeibo),
                                @(SSDKPlatformTypeMail),
//                                @(SSDKPlatformTypeSMS),
//                        @(SSDKPlatformTypeCopy),
                                @(SSDKPlatformSubTypeWechatTimeline),
                                @(SSDKPlatformTypeWechat),
//                                @(SSDKPlatformTypeQQ),
                                @(SSDKPlatformSubTypeWechatSession),
                                
                                ]
                     onImport:^(SSDKPlatformType platformType)
         {
             switch (platformType)
             {
                 case SSDKPlatformTypeWechat:
                     [ShareSDKConnector connectWeChat:[WXApi class]];
                     break;
//                 case SSDKPlatformTypeQQ:
//                     [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
//                     break;
//                 case SSDKPlatformTypeSinaWeibo:
//                     [ShareSDKConnector connectWeibo:[WeiboSDK class]];
//                     break;
                 default:
                     break;
             }
         }
              onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
         {
             
             switch (platformType)
             {
//                 case SSDKPlatformTypeSinaWeibo:
//                     //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
//                     [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
//                                               appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
//                                             redirectUri:@"http://www.sharesdk.cn"
//                                                authType:SSDKAuthTypeBoth];
//                     break;
                 case SSDKPlatformTypeWechat:
                     [appInfo SSDKSetupWeChatByAppId:@"wx07f0fafcbdf482c9"
                                           appSecret:@"3f4e04b8580e71b47298822622224752"];
                     break;
//                 case SSDKPlatformTypeQQ:
//                     [appInfo SSDKSetupQQByAppId:@"100371282"
//                                          appKey:@"aed9b0303e3ed1e27bae87c33761161d"
//                                        authType:SSDKAuthTypeBoth];
//                     break;
                 default:
                     break;
             }
         }];
//    (注意：每一个case对应一个break不要忘记填写，不然很可能有不必要的错误，新浪微博的外部库如果不要客户端分享或者不需要加关注微博的功能可以不添加，否则要添加，QQ，微信，google＋这些外部库文件必须要加)
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    // Check the calling application Bundle ID
    if ([sourceApplication isEqualToString:@"com.3Sixty.CallCustomURL"])
    {
//        NSLog(@"Calling Application Bundle ID: %@", sourceApplication);
//        NSLog(@"URL scheme:%@", [url scheme]);
//        NSLog(@"URL query: %@", [url query]);
        
        return YES;
    }
    else 
        return NO; 
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
//    NSLog(@"当程序从后台将要重新回到前台时候调用。");
    

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//    NSLog(@"当应用程序入活动状态执行");
    NSUserDefaults * ud =[NSUserDefaults standardUserDefaults];
    NSString * typeStr =[ud valueForKey:KKEYLogin_successORdefeat];
    if ([typeStr isEqualToString:KKEYLogin_success]) {
        //登陆状态是成功
    NSString * refresh = [NSString stringWithFormat:@"%@?refresh_token=%@",KAPIREFRESH,[ud valueForKey:KKEYRefresh_token]];
    
    [RCGETRequest requestWithUrl:refresh Complete:^(NSData *data) {
        //返回数据
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:NULL];
//        NSLog(@"刷新访问令牌--JSON: %@",dict);
        if (dict[@"access_token"]) {
            //            保存access_token
            //            保存refresh_toker
            [ud setObject:dict[@"access_token"] forKey:KKEYAccess_token];
            [ud setObject:dict[@"refresh_token"] forKey:KKEYRefresh_token];
//            NSLog(@"刷新令牌成功");
        }else if(dict[@"error"]){
            //            失败
            //            登陆状态改变
            [ud setObject:KKEYLogin_defeat forKey:KKEYLogin_successORdefeat];
            [ud removeObjectForKey:KKEYHeadImageUrl];
            [ud removeObjectForKey:KKEYNickName];
            [ud removeObjectForKey:KKEYRefresh_token];
            [ud removeObjectForKey:KKEYAccess_token];
            [ud synchronize];
//            NSLog(@"刷新失败");
        }
        
    } faile:^(NSError *error) {
//        NSLog(@"error:%@",error);
    }];
    }
    else{
//        NSLog(@"未登录");
    }
    [RCGETRequest requestWithUrl:KAPIEXCHANGE Complete:^(NSData *data) {
        //返回数据
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:NULL];
        NSLog(@"当前汇率--JSON: %@",dict);
        [ud setObject:dict[@"rate"] forKey:KKEYExchange];
        [ud synchronize];//同步写入磁盘
    } faile:^(NSError *error) {
//        NSLog(@"error:%@",error);
    }];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(void)UpdateAlert{
    //定义的App地址
    NSString *urlstr =@"http://itunes.apple.com/lookup?id=1119984571";
   
    //PS:有的时候可能会请求不到数据，但是AppID对了，有可能是App是上架区域范围的原因，建议使用在com末尾加上“／cn”
    
    //网络请求App的信息（我们取Version就够了）
    NSURL *url = [NSURL URLWithString:urlstr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    
    [request setHTTPMethod:@"POST"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSMutableDictionary *receiveStatusDic=[[NSMutableDictionary alloc]init];
        if (data) {
            
            //data是有关于App所有的信息
            NSDictionary *receiveDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//            NSLog(@"%@",receiveDic);
            if ([[receiveDic valueForKey:@"resultCount"] intValue]>0) {
                
                [receiveStatusDic setValue:@"1" forKey:@"status"];
                [receiveStatusDic setValue:[[[receiveDic valueForKey:@"results"] objectAtIndex:0] valueForKey:@"version"]   forKey:@"version"];
                
                //请求的有数据，进行版本比较
                [self performSelectorOnMainThread:@selector(receiveData:) withObject:receiveStatusDic waitUntilDone:NO];
            }else{
                
                [receiveStatusDic setValue:@"-1" forKey:@"status"];
            }
        }else{
            [receiveStatusDic setValue:@"-1" forKey:@"status"];
        }
        
    }];
    
    [task resume];
}
-(void)receiveData:(id)sender
{
    //获取APP自身版本号
    NSString *localVersion = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"];
    
    NSArray *localArray = [localVersion componentsSeparatedByString:@"."];
    NSArray *versionArray = [sender[@"version"] componentsSeparatedByString:@"."];
    
    
    if ((versionArray.count == 3) && (localArray.count == versionArray.count)) {
        
        if ([localArray[0] intValue] <  [versionArray[0] intValue]) {
            [self updateVersionLocalVersion:localVersion newVersion:sender[@"version"]];
        }else if ([localArray[0] intValue]  ==  [versionArray[0] intValue]){
            if ([localArray[1] intValue] <  [versionArray[1] intValue]) {
               [self updateVersionLocalVersion:localVersion newVersion:sender[@"version"]];
            }else if ([localArray[1] intValue] ==  [versionArray[1] intValue]){
                if ([localArray[2] intValue] <  [versionArray[2] intValue]) {
                    [self updateVersionLocalVersion:localVersion newVersion:sender[@"version"]];
                }
            }
        }
    }
}
-(void)updateVersionLocalVersion:(NSString *)localVersion newVersion:(NSString*)newVersion{
    ////        存入时间
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:curTime forKey:KKEYTIME];
    
    NSString *msg = [NSString stringWithFormat:@"又出新版本啦，快点更新吧!当前版本%@,最新版本%@",localVersion,newVersion];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"发现新版本" message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"暂不更新" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"现在升级"style:UIAlertActionStyleDestructive handler:^(UIAlertAction*action) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=1119984571"]];
        [[UIApplication sharedApplication]openURL:url];
    }];
    
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    
    [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
    
}

@end
