//
//  RCArticleViewController.m
//  HHause
//
//  Created by HHause on 16/5/5.
//  Copyright © 2016年 HHause. All rights reserved.
//  文章

#import "RCArticleViewController.h"
#import "RCShare.h"


@import WebKit;
@interface RCArticleViewController ()<WKNavigationDelegate,WKUIDelegate>
@property (weak, nonatomic) IBOutlet UILabel *navTitleLab;
- (IBAction)backBtn:(id)sender;
- (IBAction)shareBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *navView;


@property (nonatomic,strong)WKWebView * wkwebView;
@end

@implementation RCArticleViewController
{
    UIActivityIndicatorView *activityIndicator;
    UIView * view;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _navTitleLab.text = self.mytitle;
    
    
    self.wkwebView = [[WKWebView alloc]initWithFrame:CGRectMake(0, _navView.frame.size.height, kScreeWidth,kScreeHeight-_navView.frame.size.height)];
    [self.view addSubview:self.wkwebView];
    self.wkwebView.allowsBackForwardNavigationGestures =YES;
    self.wkwebView.navigationDelegate = self;
    
    view = [[UIView alloc] initWithFrame:CGRectMake(0,_navView.frame.size.height, kScreeWidth,kScreeHeight-_navView.frame.size.height)];
    [view setBackgroundColor:[UIColor blackColor]];
    [view setAlpha:0.5];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    NSURL * Urlstr =[NSURL URLWithString:[NSString stringWithFormat:@"%@?from=app", _urlstring]];
    NSURLRequest *request =[NSURLRequest requestWithURL:Urlstr];
    [_wkwebView loadRequest:request];
}
#pragma mark----------WKNavigationDelegate---------
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
//    NSLog(@"页面开始加载");
    [self.view addSubview:view];
    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
    [activityIndicator setCenter:self.view.center];
    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview:activityIndicator];
    
    [activityIndicator startAnimating];
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
//    NSLog(@"内容开始返回");
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
//    NSLog(@"页面加载完成");
        [activityIndicator stopAnimating];
        [view removeFromSuperview];
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
//    NSLog(@"页面加载失败");
        [activityIndicator stopAnimating];
        [view removeFromSuperview];
}
- (IBAction)backBtn:(id)sender {
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}

- (IBAction)shareBtn:(id)sender {
    
    
    //    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    NSArray* imageAry;
    if (_imageName !=nil) {
        imageAry = @[[UIImage imageNamed:_imageName]];
    }else{
        _imageUrl = [NSString stringWithFormat:@"%@",_imageUrl];
    
//        NSLog(@"%@",_imageUrl);
        imageAry =@[_imageUrl];
    }
    //    //分享链接
    NSURL * _shareUrl =[NSURL URLWithString:[NSString stringWithFormat:@"%@?from=weixin",_urlstring]];
    
    [RCShare shareText:_summary imageArray:imageAry url:_shareUrl title:_arttitle];
    
}
-(void)dealloc {
    
//    NSLog(@"\n\n\t\t释放了\n\n");
}

@end
