//
//  RCTabBarViewController.m
//  HHause
//
//  Created by HHause on 16/5/3.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "RCTabBarViewController.h"
#import "RCNavigationController.h"
@interface RCTabBarViewController ()

@end

@implementation RCTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //未选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:11.0],NSForegroundColorAttributeName:KGaryColor} forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:11.0],NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateSelected];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setcontroller:(NSString *)controllerName title:(NSString *) title imageNamed:(NSString *)imageName selectedImageName:(NSString *)selectedImage
{
    
    Class controllerClass=NSClassFromString(controllerName);
    UIViewController *controller=[[controllerClass alloc]init];
    controller.title=title;
    
    
    UIImage *normalImage=[[UIImage imageNamed:imageName] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    
    UIImage *selectImage=[[UIImage imageNamed:selectedImage] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    
    controller.tabBarItem=[[UITabBarItem alloc]initWithTitle:title image:normalImage selectedImage:selectImage];
    
    
    
    
    
    RCNavigationController *nc=[[RCNavigationController alloc]initWithRootViewController:controller];
    
    NSMutableArray *array=[NSMutableArray arrayWithArray:self.viewControllers];
    [array addObject:nc];
    self.viewControllers=array;
    
    //图片左，文字右用（真是奇葩的需求）   解决办法1.简单方便
    //去掉文字，图片和文字都做成图，然后设置图片偏移量
    //    controller.tabBarItem.imageInsets = UIEdgeInsetsMake(6.0, 0, -6.0, 0);
    //解决办法2.
    //重写tabbar,完全自定义
    
}


@end
