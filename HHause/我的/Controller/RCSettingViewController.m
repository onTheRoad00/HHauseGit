//
//  RCSettingViewController.m
//  HHause
//
//  Created by HHause on 16/5/10.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "RCSettingViewController.h"
#import "RCAboutAndErWeiMaViewController.h"
#import "RCQuestionViewController.h"
#import "RCPassWordViewController.h"
#import "RCLoginViewController.h"
@interface RCSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *navView;



@end

@implementation RCSettingViewController
{
    NSArray * _ary;
    UILabel * _cachelab;
    RCAboutAndErWeiMaViewController * _aboutAndErWeiMa;
    NSUserDefaults * ud;
    NSString * _typeStr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _aboutAndErWeiMa =[[RCAboutAndErWeiMaViewController alloc]init];
    ud = [NSUserDefaults standardUserDefaults];
    _typeStr =[ud valueForKey:KKEYLogin_successORdefeat];
    
    
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
    self.tableView.rowHeight = 44*kScreeHeight/667;
   _tableView.sectionFooterHeight = 34*kScreeHeight/667;
    //去掉留白

    self.automaticallyAdjustsScrollViewInsets=NO;

    _tableView.tableHeaderView =[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.bounds.size.width, 0.01f)];
    
    _ary = @[@[@"问题反馈",@"清理缓存"],@[@"关于我们",@"去评分",@"修改密码"],@[@"退出登录"]];
    
     _cachelab =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    _cachelab.textColor = [UIColor grayColor];
    _cachelab.font = [UIFont fontWithName:@"Arial" size:15.0f];
    _cachelab.textAlignment = 2;
    
    
    float tmpSize = [[SDImageCache sharedImageCache] getSize];
    
//    NSLog(@"%f",tmpSize);
    NSString *clearCacheName = tmpSize >= 1024*1024 ? [NSString stringWithFormat:@"%.2fM",tmpSize/1024/1024] : [NSString stringWithFormat:@"%.2fK",tmpSize/1024];
    _cachelab.text =clearCacheName;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark--------------tableView--------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
        return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
        {
            if ([_typeStr isEqualToString:KKEYLogin_success]) {
                //登陆状态是成功
                return 3;
            }else
            {
                return 2;
            }
        }
            break;
        case 2:
            if ([_typeStr isEqualToString:KKEYLogin_success]) {
                //登陆状态是成功
                return 1;
            }else
            {
                return 0;
            }
            break;
        default:
            break;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //由于此方法调用十分频繁，cell的标示声明成静态变量有利于性能优化
    static NSString *cellIdentifier=@"UITableViewCellIdentifierKey1";
    //首先根据标示去缓存池取
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    //如果缓存池没有取到则重新创建并放到缓存池中
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
        if (indexPath.section == 0 && indexPath.row==1) {
            
                cell.accessoryView=_cachelab;
        }
            cell.textLabel.text = _ary[indexPath.section][indexPath.row];
//    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(20, cell.frame.size.height, cell.frame.size.width-20, 1)];
//    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    [cell addSubview:line];
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row == 0) {
                //问题反馈
                if (![_typeStr isEqualToString:KKEYLogin_success]) {
                    //登陆状态是bu成功
                    [self LoginSeting];
                }else{
                    //登陆状态是成功
                    RCQuestionViewController * question =[[RCQuestionViewController alloc]init];
                    question.title =@"问题反馈";
                    [self.navigationController pushViewController:question animated:YES];
                }

              
            }else if(indexPath.row == 1){
                //清理缓存
                [self WIPECACHE];
            }
            break;
        }
        case 1:{
            if (indexPath.row == 0) {
                //关于我们
                _aboutAndErWeiMa.title =@"关于我们";
                [self.navigationController pushViewController:_aboutAndErWeiMa animated:YES];
            }else if(indexPath.row == 1){
                //去评分
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=1119984571"]];
                
            }else if (indexPath.row == 2){
//            修改密码
                RCPassWordViewController * ps = [[RCPassWordViewController alloc]init];
                [self.navigationController pushViewController:ps animated:YES];
            }
            
            break;
        }
        case 2:
//退出
        {
            [self exit];
        }
            break;
        default:
            break;
    }
}
#pragma mark--------------btn--------------
-(void) WIPECACHE{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要清除缓存吗？" preferredStyle:  UIAlertControllerStyleAlert];
    
    UIAlertAction *call =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //  清除磁盘中的缓存
        [[SDImageCache sharedImageCache] clearDisk];
        //  清除缓存的存储
        [[SDImageCache sharedImageCache] clearMemory];
        
        _cachelab.text = @"";
        
        
        
        
        
//        _cachelab.text =@"";
//        [self.tableView reloadData];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancelAction];
    [alert addAction:call];
    //弹出提示框；
    [self presentViewController:alert animated:true completion:nil];
    
}
//退出
-(void)exit{
    
    ud =[NSUserDefaults standardUserDefaults];
    [ud setObject:KKEYLogin_defeat forKey:KKEYLogin_successORdefeat];
    [ud removeObjectForKey:KKEYHeadImageUrl];
    [ud removeObjectForKey:KKEYNickName];
    [ud removeObjectForKey:KKEYRefresh_token];
    [ud removeObjectForKey:KKEYAccess_token];
    [RCAlertView showMessage:@"注销登陆"];
    _typeStr =[ud valueForKey:KKEYLogin_successORdefeat];
    [self.tableView reloadData];
}
#pragma mark--------------------------------Appear--------------------------------
//隐藏导航栏
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
    
}
//取消隐藏
- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden=NO;
}
- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)LoginSeting {
    RCLoginViewController * login =[[RCLoginViewController alloc]init];
    [self presentViewController:login animated:NO completion:^{
        
    }];
}
@end
