//
//  RCIndexViewController.m
//  HHause
//
//  Created by HHause on 16/5/3.
//  Copyright © 2016年 HHause. All rights reserved.
// 首页

#import "RCIndexViewController.h"
#import "RCShare.h"
#import "RCHousinginformationViewController.h"
#import "RCSrearchViewController.h"
#import "CExpandHeader.h"
#import "RCSearchListViewController.h"

#import "RCCheckHousePriceViewController.h"
#import "RCCheckHousePriceCityListViewController.h"


#import "RCSRDZViewController.h"


#import "RCIndex1TableViewCell.h"
#import "RCIndex2TableViewCell.h"
#import "RCIndex4TableViewCell.h"
#import "RCIndexBtnTableViewCell.h"
#import "RCCityNameTableViewCell.h"

#define Identifier1     @"RCIndex1TableViewCell"
#define Identifier2     @"RCIndex2TableViewCell"
#define Identifier4     @"RCIndex4TableViewCell"
#define IdentifierBtn   @"RCIndexBtnTableViewCell"
#define IdentifierCityname @"RCCityNameTableViewCell"

@interface RCIndexViewController ()<UITableViewDataSource,UITableViewDelegate>



@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) UITableView *cityTableview;
@end

@implementation RCIndexViewController
{
    CExpandHeader *_header;
    UIView * _headView;
    UIView * _searchview;
    UIView * _searchview1;
    UILabel * _label;
    UILabel * _label1;
    UIImageView *headBgImageView;
    float  _searchviewOriginY;
    UIView * _navView;
    
    //首页城市列表
    NSArray * _cityAry;
    //热门区域
    NSMutableArray * _hot_areasAry;
    //精选好房
    NSMutableArray * _recommendsAry;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _tableview.dataSource=self;
    _tableview.delegate=self;
    
    
   
    _cityAry = @[@"城市",@"旧金山",@"西雅图",@"洛杉矶",@"圣地亚哥"];
    _hot_areasAry =[[NSMutableArray alloc]init];
    _recommendsAry = [[NSMutableArray alloc]init];
//    去掉留白
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self creatData];
    [self creatUI];
    
//    UINib * nib=[UINib nibWithNibName:Identifier bundle:nil];
//    [_tableview registerNib:nib forCellReuseIdentifier:Identifier];
    // 把返回文字的标题设置为空字符->下一级
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    _hot_areasAry =[NSMutableArray arrayWithArray:@[@{@"city":@"Irvine",
                        @"city_cn":@"尔湾",
                        @"image":@"http://media.hhause.com/city/Irvine/1.jpg"},
                      @{@"city":@"Walnut",
                        @"city_cn":@"核桃市",
                        @"image":@"http://media.hhause.com/city/Walnut/1.jpg"},
                      @{@"city":@"Newport Beach",
                        @"city_cn":@"纽波特比",
                        @"image":@"http://media.hhause.com/city/NewportBeach/1.jpg"},
                      @{@"city":@"Mountain View",
                        @"city_cn":@"山景城",
                        @"image":@"http://media.hhause.com/city/MountainView/1.jpg"}]
                    ];
    _recommendsAry =[NSMutableArray arrayWithArray:@[@{@"attributes":@"2",
                                                       @"bedrooms" :@"4",
                                                       @"built_year" : @"2000",
                                                       @"city" : @"Thousand Oaks",
                                                       @"floor_area" :@"2927",
                                                       @"full_baths" :@"3",
                                                       @"id" :@"55942",
                                                       @"mls" :@"216010905",
                                                       @"partial_baths":@"0",
                                                       @"preview" :@"FvYDJHqaygnmnS9-SLH5reqozPET",
                                                       @"price" :@"944500",
                                                       @"space_area":@"8299",
                                                       @"title" :@"",
                                                       @"type":@"H"},
                                                     @{@"attributes":@"2",
                                                       @"bedrooms" :@"4",
                                                       @"built_year" : @"2000",
                                                       @"city" : @"Thousand Oaks",
                                                       @"floor_area" :@"2927",
                                                       @"full_baths" :@"3",
                                                       @"id" :@"55942",
                                                       @"mls" :@"216010905",
                                                       @"partial_baths":@"0",
                                                       @"preview" :@"FvYDJHqaygnmnS9-SLH5reqozPET",
                                                       @"price" :@"944500",
                                                       @"space_area":@"8299",
                                                       @"title" :@"",
                                                       @"type":@"H"},
                                                     @{@"attributes":@"2",
                                                       @"bedrooms" :@"4",
                                                       @"built_year" : @"2000",
                                                       @"city" : @"Thousand Oaks",
                                                       @"floor_area" :@"2927",
                                                       @"full_baths" :@"3",
                                                       @"id" :@"55942",
                                                       @"mls" :@"216010905",
                                                       @"partial_baths":@"0",
                                                       @"preview" :@"FvYDJHqaygnmnS9-SLH5reqozPET",
                                                       @"price" :@"944500",
                                                       @"space_area":@"8299",
                                                       @"title" :@"",
                                                       @"type":@"H"},
                                                     @{@"attributes":@"2",
                                                       @"bedrooms" :@"4",
                                                       @"built_year" : @"2000",
                                                       @"city" : @"Thousand Oaks",
                                                       @"floor_area" :@"2927",
                                                       @"full_baths" :@"3",
                                                       @"id" :@"55942",
                                                       @"mls" :@"216010905",
                                                       @"partial_baths":@"0",
                                                       @"preview" :@"FvYDJHqaygnmnS9-SLH5reqozPET",
                                                       @"price" :@"944500",
                                                       @"space_area":@"8299",
                                                       @"title" :@"",
                                                       @"type":@"H"},
                                                     @{@"attributes":@"2",
                                                       @"bedrooms" :@"4",
                                                       @"built_year" : @"2000",
                                                       @"city" : @"Thousand Oaks",
                                                       @"floor_area" :@"2927",
                                                       @"full_baths" :@"3",
                                                       @"id" :@"55942",
                                                       @"mls" :@"216010905",
                                                       @"partial_baths":@"0",
                                                       @"preview" :@"FvYDJHqaygnmnS9-SLH5reqozPET",
                                                       @"price" :@"944500",
                                                       @"space_area":@"8299",
                                                       @"title" :@"",
                                                       @"type":@"H"}]

                    ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)creatUI{
//导航栏 搜索
     _navView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreeWidth, 64)];
    [self.view addSubview:_navView];
    _searchview =[[UIView alloc]initWithFrame:CGRectMake(24*kScreeWidth/375,20+(44-39*kScreeWidth/375)/2, 328*kScreeWidth/375, 39*kScreeWidth/375)];
    //图片两种方式
//    NSString *path = [[NSBundle mainBundle]pathForResource:@"组-2@2x"ofType:@"png"];
    //    UIImage *image = [UIImage imageWithContentsOfFile:path];
    UIImage * image =[UIImage imageNamed:@"组-3"];

     _searchview.layer.contents = (id)image.CGImage;
    
    [_navView addSubview:_searchview];
    
    UIButton * citybtn = [UIButton buttonWithType:UIButtonTypeSystem];
    citybtn.frame = CGRectMake(0, 0, 60*kScreeWidth/375,_searchview.frame.size.height);
    [citybtn addTarget:self action:@selector(city:) forControlEvents:UIControlEventTouchUpInside];
    [_searchview addSubview:citybtn];
    _label = [[UILabel alloc]initWithFrame:CGRectMake(5*kScreeWidth/375, 0, 55*kScreeWidth/375, _searchview.frame.size.height)];
    _label.numberOfLines = 1;
    _label.text =@"城市";
    _label.font = [UIFont systemFontOfSize:13];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.adjustsFontSizeToFitWidth = YES;
    _label.minimumScaleFactor = 0.1;
    [_searchview addSubview:_label];
    
    UIButton * searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(citybtn.frame.size.width, 0,_searchview.frame.size.width-citybtn.frame.size.width,_searchview.frame.size.height);
    [searchBtn addTarget:self action:@selector(searchBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_searchview addSubview:searchBtn];
    
//    UIImageView * imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, citybtn.frame.size.width, citybtn.frame.size.height)];
//    [imageview setImage:[UIImage imageNamed:@""]];
//    [_searchview addSubview:imageview];
#pragma ---------------------------------------------------------  
    //headView
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,kScreeWidth, 223*kScreeWidth/375)];
    
    
    headBgImageView= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreeWidth, _headView.frame.size.height)];
    [headBgImageView setImage:[UIImage imageNamed:@"bg-4"]];
    //关键步骤 设置可变化背景view属性
    headBgImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight| UIViewAutoresizingFlexibleWidth;
    headBgImageView.clipsToBounds = YES;
    headBgImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_headView addSubview:headBgImageView];
    

    //headView 搜索栏
    if (kScreeWidth==414) {
        _searchview1 =[[UIView alloc]initWithFrame:CGRectMake(24*kScreeWidth/375,161, 328*kScreeWidth/375, 39*kScreeWidth/375)];
    }
    else{
    _searchview1 =[[UIView alloc]initWithFrame:CGRectMake(24*kScreeWidth/375,161*kScreeWidth/375, 328*kScreeWidth/375, 39*kScreeWidth/375)];
    }
//    NSLog(@"!!!!!!!!!!!!!!@@@%f,%f",_searchview1.frame.origin.y,_searchview1.frame.size.height);
    _searchviewOriginY = _searchview1.frame.origin.y;
    _searchview1.layer.contents = (id)image.CGImage;
    
     [_headView addSubview:_searchview1];
    UIButton * citybtn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    citybtn1.frame = CGRectMake(0, 0, 60*kScreeWidth/375,_searchview1.frame.size.height);
    [citybtn1 addTarget:self action:@selector(city:) forControlEvents:UIControlEventTouchUpInside];
    [_searchview1 addSubview:citybtn1];
    
    _label1 = [[UILabel alloc]initWithFrame:CGRectMake(5*kScreeWidth/375, 0, 55*kScreeWidth/375, _searchview.frame.size.height)];
    _label1.text =@"城市";
    _label1.numberOfLines = 1;
    _label1.font = [UIFont systemFontOfSize:13];
    _label1.textAlignment = NSTextAlignmentCenter;
     _label1.adjustsFontSizeToFitWidth = YES;
    _label1.minimumScaleFactor = 0.1;
    [_searchview1 addSubview:_label1];
    
    UIButton * searchBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [searchBtn1 setImage:[UIImage imageNamed:@"搜索条.png"] forState:UIControlStateNormal];
    searchBtn1.frame = CGRectMake(citybtn.frame.size.width+20, 0,_searchview1.frame.size.width-citybtn.frame.size.width-20,_searchview1.frame.size.height);
    [searchBtn1 addTarget:self action:@selector(searchBtn:) forControlEvents:UIControlEventTouchUpInside];

    [_searchview1 addSubview:searchBtn1];
    
//    UIImageView * imageview1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, citybtn1.frame.size.width, citybtn1.frame.size.height)];
//    [imageview1 setImage:[UIImage imageNamed:@""]];
//    [_searchview1 addSubview:imageview1];
//----------------------------
//    UIImageView * iconView =[[UIImageView alloc]initWithFrame:CGRectMake((kScreeWidth-150)/2, 54, 150, 50)];
//    iconView.image = [UIImage imageNamed:@"logo1"];
//    [_headView addSubview:iconView];
    
    [_headView addSubview:_searchview1];
    _header = [CExpandHeader expandWithScrollView:_tableview expandView:_headView];
    
    
    
    _cityTableview =[[UITableView alloc]initWithFrame:CGRectMake(_searchview.frame.origin.x+1, 0, citybtn1.frame.size.width+18, 0)];
//    _cityTableview.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
//    _cityTableview.layer.borderWidth = 0.5;
    _cityTableview.layer.masksToBounds = NO;
    _cityTableview.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    _cityTableview.layer.shadowOffset = CGSizeMake(0,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    _cityTableview.layer.shadowOpacity = 0.18;//阴影透明度，默认0
    _cityTableview.layer.shadowRadius = 3;//阴影半径，默认3
    
    
    
    _cityTableview.delegate = self;
    _cityTableview.dataSource = self;
    _cityTableview.alpha = 0;
    _cityTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_cityTableview];
    
}
-(void)creatData{
    //精选好房
    [RCGETRequest requestWithUrl:KAPIGet_recommendeds Complete:^(NSData *data) {
        //返回数据
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:NULL];
//        NSLog(@"精选好房--JSON: %@",dict);
        
        [_recommendsAry removeAllObjects];
        _recommendsAry = [NSMutableArray arrayWithArray:dict[@"recommends"]];
        
//        NSIndexPath *path = [NSIndexPath indexPathForRow:2 inSection:0];
//        [self.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObject:path] withRowAnimation:UITableViewRowAnimationFade];
                [self.tableview reloadData];
    } faile:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];
//精选区域
    [RCGETRequest requestWithUrl:KAPIGet_hot_areas Complete:^(NSData *data) {
        //返回数据
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:NULL];
//        NSLog(@"热门区域--JSON: %@",dict);
        [_hot_areasAry removeAllObjects];
        _hot_areasAry = [NSMutableArray arrayWithArray:dict[@"hot_areas"]];
        //刷新部分tableview（先更改数据源  再刷新）
        
//        NSIndexPath *path = [NSIndexPath indexPathForRow:1 inSection:0];
//        [self.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObject:path] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableview reloadData];
    } faile:^(NSError *error) {
//        NSLog(@"error:%@",error);
    }];

}
#pragma mark--------------------------------tableview--------------------------------

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_tableview]) {
        switch (indexPath.row) {
            case 0:
                return 208*kScreeWidth/375;
                break;
            case 1:
                return 210*kScreeWidth/375;
                break;
            case 2:
                return 210*kScreeWidth/375;
                break;
//            case 3:
//                return 210*kScreeWidth/375;
//                break;
            case 3:
                return 220*kScreeWidth/375;
                break;
            default:
                break;
        }
        return 0;

    }
    else
        return 30;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:_tableview]) {
        return 4;
    }else
        return _cityAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* cityDict = @{@"洛杉矶":@"LA",@"旧金山":@"SF",@"圣地亚哥":@"SD",@"西雅图":@"SEA",@"城市":@""};
    if ([tableView isEqual:_tableview]) {
        switch (indexPath.row) {
            case 0:
            {
                UINib * nib=[UINib nibWithNibName:IdentifierBtn bundle:nil];
                [_tableview registerNib:nib forCellReuseIdentifier:IdentifierBtn];
                RCIndexBtnTableViewCell * BtnCell = [tableView
                                                     dequeueReusableCellWithIdentifier:IdentifierBtn forIndexPath:indexPath];
                BtnCell.btnBlock=^(NSString *type) {
                    /*函数回调 当block执行时就会回到这里*/

                    if ([type isEqualToString:@"查学校"]) {
                       [RCAlertView showMessage:@"暂未开通该功能"];
                    }
                    else if ([type isEqualToString:@"查房价"])
                    {
                        for (int i = 0; i<_cityAry.count; i++) {
                            if ([_label.text isEqualToString:_cityAry[i]]){
                                RCCheckHousePriceCityListViewController * citylist = [[RCCheckHousePriceCityListViewController alloc]init];
                                citylist.hidesBottomBarWhenPushed = YES;
                                citylist.index = i;
                                [self.navigationController pushViewController:citylist animated:YES];
                            }
                        }
//                        if ([_label.text isEqualToString:@"城市"]) {
//                            
//                        }else{
//                            RCCheckHousePriceViewController * checkHousePrice = [[RCCheckHousePriceViewController alloc]init];
//                            checkHousePrice.flag =@"首页";
//                            checkHousePrice.cityDict = @{@"name_cn":_label.text};
//                           
//                              checkHousePrice.hidesBottomBarWhenPushed = YES;
//                            [self.navigationController pushViewController:checkHousePrice animated:YES];
//                        }
                    }
                    else if ([type isEqualToString:@"新房"])
                    {
                        [RCAlertView showMessage:@"暂未开通该功能"];
                    }
                    else if ([type isEqualToString:@"私人定制"]){
//                        RCSRDZViewController * srdz =[[RCSRDZViewController alloc]init];
//                        [self presentViewController:srdz animated:NO completion:^{
////
//                        }];
                        [RCAlertView showMessage:@"暂未开通该功能"];
                    }
                    
                    else{
                    RCSearchListViewController * search=[[RCSearchListViewController alloc]init];
                    
                        if([type isEqualToString:@"学区房"]){
                            search.attributes = @"2";
                        }else if ([type isEqualToString:@"投资房"]){
                            search.attributes = @"1";
                        }
                        else if ([type isEqualToString:@"豪宅"]){
                            search.attributes = @"4";
                        }else{
                            search.attributes = @"0";
                        }
                        
                        
//                        NSLog(@"%@",cityDict[_label.text]);
                        search.metro_area  = cityDict[_label.text];
                        NSString * citynamete = _label.text;
                        if ([_label.text isEqualToString:@"城市"]) {
                            citynamete = @"";
                        }
                        search.mytitle = [NSString stringWithFormat:@"%@%@",citynamete,type];
                    search.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:search animated:YES];
                   
                    }
                    
                
                };
                return BtnCell;
                break;
            }
//          热门区域
            case 1:case 2:
            {
                UINib * nib=[UINib nibWithNibName:Identifier1 bundle:nil];
                [_tableview registerNib:nib forCellReuseIdentifier:Identifier1];
                RCIndex1TableViewCell * Index1Cell = [tableView dequeueReusableCellWithIdentifier:Identifier1 forIndexPath:indexPath];
                if (indexPath.row == 1) {
                    Index1Cell.type = @"热门区域";
                    Index1Cell.titleLab.text= @"热门区域";
                    [Index1Cell setArrayCerImages:_hot_areasAry];
                    Index1Cell.COLLBlock=^(NSString *city,NSString * city_cn) {
                        /*函数回调 当block执行时就会回到这里*/
                        RCSearchListViewController * search=[[RCSearchListViewController alloc]init];
                        search.mytitle = city_cn;
                        search.city = city;
                        search.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:search animated:YES];
                        
                    };
                }else
                {
                    Index1Cell.titleLab.text= @"精选好房";
                    Index1Cell.type = @"精选好房";
                    
                    [Index1Cell setArrayCerImages:_recommendsAry];
                    Index1Cell.COBlock=^(NSString *houseID,NSString *mls,NSString * city) {
                        /*函数回调 当block执行时就会回到这里*/
                        RCHousinginformationViewController * housinginfo=[[RCHousinginformationViewController alloc]init];
                        housinginfo.houseId =houseID;
                        housinginfo.mls = mls;
                        housinginfo.city = city;
                        

                        housinginfo.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:housinginfo animated:YES];
                    };
                    
                }
                
                return Index1Cell;
                break;
            }
//          精选好房
//            case 2:
//            {
//                UINib * nib=[UINib nibWithNibName:Identifier2 bundle:nil];
//                [_tableview registerNib:nib forCellReuseIdentifier:Identifier2];
//                RCIndex2TableViewCell * index2Cell = [tableView dequeueReusableCellWithIdentifier:Identifier2 forIndexPath:indexPath];
//                [index2Cell setArrayCerImages:_recommendsAry];
//                index2Cell.COLBlock=^(NSString *houseID,NSString *mls,NSString * city,NSString * shareTitle,NSString *shareSummary) {
//                    /*函数回调 当block执行时就会回到这里*/
//                    RCHousinginformationViewController * housinginfo=[[RCHousinginformationViewController alloc]init];
//                    housinginfo.houseId =houseID;
//                    housinginfo.mls = mls;
//                    housinginfo.city = city;
//                    housinginfo.shareTitle = shareTitle;
//                    housinginfo.shareSummary = shareSummary;
//                    housinginfo.hidesBottomBarWhenPushed = YES;
//                    [self.navigationController pushViewController:housinginfo animated:YES];
//                   
//                };
//                
//                
//                return index2Cell;
//                break;
//            }
//            分享好友
            case 3:
            {
                UINib * nib=[UINib nibWithNibName:Identifier4 bundle:nil];
                [_tableview registerNib:nib forCellReuseIdentifier:Identifier4];
                RCIndex4TableViewCell * index4Cell = [tableView dequeueReusableCellWithIdentifier:Identifier4 forIndexPath:indexPath];
                return index4Cell;
                break;
            }
            default:
                break;
        }

    }
    UINib * nib=[UINib nibWithNibName:IdentifierCityname bundle:nil];
    [_cityTableview registerNib:nib forCellReuseIdentifier:IdentifierCityname];
    RCCityNameTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:IdentifierCityname forIndexPath:indexPath];
    cell.CityNameLab.text = _cityAry[indexPath.row];

        return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ([tableView isEqual:_tableview]) {
        if (indexPath.row == 3) {
            //1、创建分享参数
            NSArray* imageArray =  @[[UIImage imageNamed:@"60"]];
            
            //    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
            //    //分享链接
//            NSURL * _shareUrl =[NSURL URLWithString:@"http://www.hhause.com/app.html"];
             NSURL * _shareUrl =[NSURL URLWithString:@"https://itunes.apple.com/us/developer/hai-ji-yue-jia/id1119984570"];
            [RCShare shareText:@"值得信赖的海外置业一站式服务专家" imageArray:imageArray url:_shareUrl title:@"海际悦家"];
        }

    }else
    {
        _label.text = _cityAry[indexPath.row];
        _label1.text =_cityAry[indexPath.row];
      [self animationWithDuration:0.2 viewAlpha:0 height:0];
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"offset---scroll:%f",self.tableview.contentOffset.y);
    
    CGFloat offset=scrollView.contentOffset.y;
    if ([scrollView isEqual:_tableview]) {
        [self animationWithDuration:0.2 viewAlpha:0 height:0];
        if (offset<-223) {
            _searchview1.frame = CGRectMake(_searchview1.frame.origin.x,_searchviewOriginY-offset-223, _searchview1.frame.size.width, _searchview1.frame.size.height);
        }
//        if (offset<-114) {
//            _navView.hidden = YES;
//            _searchview1.hidden = NO;
//            _navView.alpha = 0;
//            _searchview1.alpha =1;
//            
//        }else {
        
//            _searchview1.hidden=YES;
//           
//            _navView.hidden = NO;
//            _searchview1.alpha = 0;
//            _navView.alpha = 1;
            
//            _navView.backgroundColor = KColor;
//            
//        }
        _navView.backgroundColor = KColor;
        if (offset<-64&&offset>-114) {
            _searchview1.alpha = 0.01*(-64-offset)*2;
            _navView.alpha = 0.01* (100-(-64-offset)*2);
        }else if (offset<-114) {
            //            _navView.hidden = YES;
            //            _searchview1.hidden = NO;
            _navView.alpha = 0;
            _searchview1.alpha =1;
            
        }else if (offset >-64){
            _navView.alpha = 1;
            _searchview1.alpha =0;
        }

    }
}
-(UIImage *)imageWithBgColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}
#pragma mark--------------------------------关于导航栏--------------------------------
//隐藏导航栏
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;

}
-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    self.navigationController.navigationBar.hidden=YES;
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
//取消隐藏
- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:(BOOL)animated];
   self.navigationController.navigationBar.hidden=NO;
//  [self.navigationController setNavigationBarHidden:NO animated:YES];
//     self.navigationController.navigationBar.alpha = 0;
    
}
#pragma --------------关于按钮--------------------
- (IBAction)searchBtn:(id)sender {
    
//    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    [ud setObject:_label.text forKey:KKEYSearch_suggest];
    RCSrearchViewController * searchcor = [[RCSrearchViewController alloc]init];
     searchcor.hidesBottomBarWhenPushed = YES;
    searchcor.metro_area = _label.text;
    [self.navigationController pushViewController:searchcor animated:YES];
}
- (IBAction)houseTypeBtn:(id)sender {
    UIButton * btn = sender;
    NSString * title=btn.titleLabel.text;

    RCSearchListViewController * search=[[RCSearchListViewController alloc]init];
    search.mytitle = title;
    search.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:search animated:YES];
}
-(void)city:(id)sender {
    UIButton * cityBtn =sender;
    
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGPoint firstLabCGpoint = [cityBtn convertPoint:cityBtn.bounds.origin toView:window];
    firstLabCGpoint.y = firstLabCGpoint.y + cityBtn.frame.size.height-1;
    _cityTableview.transform = CGAffineTransformMakeTranslation(0, firstLabCGpoint.y);
    
    if (_cityTableview.alpha ==0) {
        [self animationWithDuration:0.2 viewAlpha:1 height:30*_cityAry.count];
    }else
    {
         [self animationWithDuration:0.2 viewAlpha:0 height:0];
    }

}
// 动画
-(void)animationWithDuration:(NSTimeInterval)duration viewAlpha:(CGFloat)alpha height:(CGFloat)height{
    
    CGRect frame = _cityTableview.frame;
    frame.size.height=height;
    [UIView animateWithDuration:duration animations:^{
        _cityTableview.alpha = alpha;
        _cityTableview.frame = frame;
        
    }];
}
- (void)dealloc
{
    NSLog(@"\n\t\n\t\n\t  index 释放了  \n\t\n\t\n\t");
    
}
@end
