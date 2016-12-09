//
//  RCMineViewController.m
//  HHause
//
//  Created by HHause on 16/5/3.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "RCMineViewController.h"

#import "RCMIneTableViewCell.h"
#import "RCMIne1TableViewCell.h"
#import "RCMine2TableViewCell.h"
#define IdentifierMine     @"RCMIneTableViewCell"
#define IdentifierMine1     @"RCMIne1TableViewCell"
#define IdentifierMine2     @"RCMine2TableViewCell"


#import "RCInterestViewController.h"
#import "RCHousinginformationViewController.h"
#import "RCSRDZViewController.h"
#import "RCSettingViewController.h"
#import "RCLoginViewController.h"
#import "RCQuestionViewController.h"

#import "RCInfoViewController.h"

#import "CExpandHeader.h"
#define HEADIMAGEWIDTH 86*kScreeHeight/667
#define HEADERHEIGHT 208*kScreeHeight/667
@interface RCMineViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation RCMineViewController
{
    RCInterestViewController * _interest;
    NSUserDefaults * ud;
    NSString * _tableViewType;
    NSString * _typeStr;
    NSArray * cellNameAry;
    CExpandHeader *_header;
    
    //headview
    UIImageView * _headImageView;
    UILabel * _nicknameLab;
    UIView * _headerView;
    UIButton * _headBtn;
    
    NSString * _favNum;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _interest =[[RCInterestViewController alloc]init];
    cellNameAry = @[@[@"收藏房源",@"推荐房源",@"最近浏览"],@[@"邀请好友",@"联系客服",@"设置"]];
   
    [self creatUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark ------------------creatUI---------
- (void) creatUI{
    
//    tableView
//    去掉留白
//    self.automaticallyAdjustsScrollViewInsets=NO;
    _tableViewType = @"偏好设置";
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
    self.tableView.rowHeight = 46*kScreeHeight/667;
//    _tableView.sectionHeaderHeight = 0;
    _tableView.sectionFooterHeight = 0;
    
    UINib * nib=[UINib nibWithNibName:IdentifierMine bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:IdentifierMine];
    
    
    _headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreeWidth, HEADERHEIGHT)];
    _headerView.backgroundColor = [UIColor whiteColor];
    
   UIImageView * headBgImageView= [[UIImageView alloc] initWithFrame:_headerView.frame];
    [headBgImageView setImage:[UIImage imageNamed:@"我的header"]];
    //关键步骤 设置可变化背景view属性
    headBgImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight| UIViewAutoresizingFlexibleWidth;
    headBgImageView.clipsToBounds = YES;
    headBgImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_headerView addSubview:headBgImageView];
    //
    _nicknameLab =[[UILabel alloc]initWithFrame:CGRectMake(0, HEADERHEIGHT-30, kScreeWidth, 30)];
    _nicknameLab.font =[UIFont fontWithName:@"Arial" size:20.0f];
    _nicknameLab.textColor = [UIColor whiteColor];
    _nicknameLab.textAlignment = 1;
    
    
//    headView
    _headImageView =[[UIImageView alloc]initWithFrame:CGRectMake((kScreeWidth-HEADIMAGEWIDTH)/2, _nicknameLab.frame.origin.y-HEADIMAGEWIDTH-10,HEADIMAGEWIDTH,HEADIMAGEWIDTH)];
    _headImageView.layer.masksToBounds=YES;
    _headImageView.layer.cornerRadius =HEADIMAGEWIDTH*0.5;
    _headImageView.layer.borderWidth = 2;
    _headImageView.layer.borderColor = [UIColor whiteColor].CGColor;
     _headImageView.image =[UIImage imageNamed:@"未登录"];

//
    _headBtn  =[UIButton buttonWithType:UIButtonTypeCustom];
    _headBtn.frame =CGRectMake(_headImageView.frame.origin.x,0, HEADIMAGEWIDTH, HEADERHEIGHT);
    _headBtn.backgroundColor = [UIColor clearColor];
    [_headBtn setTitle:@"" forState:UIControlStateNormal];
    [_headBtn addTarget:self action:@selector(LoginSeting) forControlEvents:UIControlEventTouchUpInside];
    
 
//修改信息
//    _infoBtn  =[UIButton buttonWithType:UIButtonTypeCustom];
//    _infoBtn.frame =CGRectMake(kScreeWidth-50,10, 50, 30);
//    [_infoBtn setTitle:@"修改" forState:UIControlStateNormal];
//    _infoBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
//    _infoBtn.hidden = YES;
//    [_infoBtn setTitleColor:[UIColor blueColor]forState:UIControlStateNormal];
//    [_infoBtn addTarget:self action:@selector(infoBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [_headerView addSubview:_headBtn];
    [_headerView addSubview:_headImageView];
    [_headerView addSubview:_nicknameLab];

        _header = [CExpandHeader expandWithScrollView:_tableView expandView:_headerView];
}
//收藏房源数量
-(void) creatHousesNum{
//        NSLog(@"%@",[ud valueForKey:KKEYAccess_token]);
        NSString * urlstring = [NSString stringWithFormat:@"%@?require_total=true&pagesize=1&access_token=%@",KAPIFAVOR_list_homes,[ud valueForKey:KKEYAccess_token]];
//        NSLog(@"收藏列表:%@",urlstring);
        [RCGETRequest requestWithUrl:urlstring Complete:^(NSData *data) {
            //返回数据
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:NULL];
//            NSLog(@"收藏列表--JSON: %@",dict);
            _favNum = [NSString stringWithFormat:@"%@",dict[@"total"]];
            [self.tableView reloadData];
        } faile:^(NSError *error) {
//            NSLog(@"error:%@",error);
        }];
}
//隐藏导航栏
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     self.navigationController.navigationBar.hidden=YES;
    ud = [NSUserDefaults standardUserDefaults];
    _typeStr =[ud valueForKey:KKEYLogin_successORdefeat];
   _favNum = @"";
    if ([_typeStr isEqualToString:KKEYLogin_success]) {
        //登陆状态是成功
        [self creatHousesNum];
        _nicknameLab.text =[ud valueForKey:KKEYNickName];
        NSString * type =[NSString stringWithFormat:@"%@",[[ud valueForKey:KKEYHeadImageUrl] class]];
        if ([type isEqualToString:@"__NSCFData"] ) {
            NSData * imageData =[ud valueForKey:KKEYHeadImageUrl];
            UIImage * image = [UIImage imageWithData:imageData];
            if (image) {
                _headImageView.image =image;
            }
            else
            {
                _headImageView.image =[UIImage imageNamed:@"登录"];
            }
        }
        else if([type isEqualToString:@"(null)"]||[type isEqualToString:@"__NSCFConstantString"]){
            _headImageView.image =[UIImage imageNamed:@"登录"];
            }
        else{
            [_headImageView sd_setImageWithURL:[NSURL URLWithString:[ud valueForKey:KKEYHeadImageUrl]]];
        }
        _headBtn.hidden = YES;
    }
//    else if([_typeStr isEqualToString:KKEYLogin_defeat])
    else
    {
        //登陆状态是失败
        _headImageView.image =[UIImage imageNamed:@"未登录"];
     _nicknameLab.text =@"登录/注册";
//        _infoBtn.hidden = YES;
        _headBtn.hidden = NO;
    }
}

//取消隐藏
- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
-(void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
//    self.navigationController.navigationBar.hidden = NO;
}

#pragma mark--------------tableView--------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
        return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
            return 3;
        }
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 20*kScreeHeight/667;
    }
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"***%ld,**%ld",(long)indexPath.section,(long)indexPath.row);
     RCMIneTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:IdentifierMine forIndexPath:indexPath];
    cell.cellNameLab.text = cellNameAry[indexPath.section][indexPath.row];
    cell.cellImageView.image = [UIImage imageNamed:cellNameAry[indexPath.section][indexPath.row]];
    if (indexPath.row == 0&& indexPath.section == 0) {
       cell.numLab.text = _favNum;
    }else{
        cell.numLab.text = @"";
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:case 1:
            {
//                收藏房源，最近浏览，推荐房源
                
                if (![_typeStr isEqualToString:KKEYLogin_success]) {
                    //登陆状态是不成功
                    [self LoginSeting];
                }else{
                    
                    //登陆状态是成功
                    RCInterestViewController * interest=[[RCInterestViewController alloc]init];
                    interest.title = cellNameAry[indexPath.section][indexPath.row];
                    interest.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:interest animated:YES];
                }
                break;
            }
            case 2:
            {
                RCInterestViewController * interest=[[RCInterestViewController alloc]init];
                interest.title = cellNameAry[indexPath.section][indexPath.row];
                interest.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:interest animated:YES];
                break;
            }
            default:
                break;
        }
    }else{
        switch (indexPath.row) {
            case 0:
            {
//                邀请好友
                [self share];
                break;
            }
            case 1:
            {
//                客服
                [self ContactUs];
                break;
            }
            case 2:
            {
                RCSettingViewController * setting = [[RCSettingViewController alloc]init];
                setting.title = @"设置";
                setting.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:setting animated:YES];
                break;
            }
            default:
                break;
        }

    }
}
#pragma mark---------------------------
//邀请好友
-(void) share{
    //1、创建分享参数
    NSArray* imageArray = imageArray = @[[UIImage imageNamed:@"60"]];
    
    //    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    //    //分享链接
    NSURL * _shareUrl =[NSURL URLWithString:@"http://www.hhause.com/app.html"];
    [RCShare shareText:@"海际悦家,值得信赖的海外置业一站式服务专家" imageArray:imageArray url:_shareUrl title:@"海际悦家"];
}
// 联系客服
-(void) ContactUs{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"悦家咨询" message:@"" preferredStyle:  UIAlertControllerStyleActionSheet];
    
    UIAlertAction *call =[UIAlertAction actionWithTitle:@"拨打电话" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //点击按钮的响应事件；
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"13910546621"];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancelAction];
    [alert addAction:call];
    //弹出提示框；
    [self presentViewController:alert animated:true completion:nil];
}

#pragma mark-------------btn----------------
- (void)LoginSeting {
    RCLoginViewController * login =[[RCLoginViewController alloc]init];
    [self presentViewController:login animated:NO completion:^{
        
    }];
}

- (IBAction)infoBtn:(id)sender {
    RCInfoViewController * info =[[RCInfoViewController alloc]init];
    [self.navigationController pushViewController:info animated:YES];
}
@end
