//
//  RCCheckHousePriceViewController.m
//  HHause
//
//  Created by HHause on 2016/11/2.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "RCCheckHousePriceViewController.h"
#import "RCCheckHousePriceCityListViewController.h"
#import "RCHousePriceDataViewController.h"
#import "RCCheckHousePriceTableViewCell.h"
#import "RCCheckHousePrice2TableViewCell.h"
#import "RCUtils.h"
#define checkIdentifier @"RCCheckHousePriceTableViewCell"
#define check2Identifier @"RCCheckHousePrice2TableViewCell"
@interface RCCheckHousePriceViewController ()<UITableViewDelegate,UITableViewDataSource>

- (IBAction)backBtn:(id)sender;
- (IBAction)cityBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)shareBtn:(id)sender;

@end

@implementation RCCheckHousePriceViewController
{
    NSArray * _dataTypeAry;
    NSDictionary * _market_dataDict;
    NSString * _unit;//单位
    NSUserDefaults * ud;
    NSArray * _chartAry;
    NSString * _title;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    ud = [NSUserDefaults standardUserDefaults];
    _unit = @"英制";
    if ([_cityDict[@"name_cn"] isEqualToString:@""]||[_cityDict[@"name_cn"]isEqualToString:@"null"]) {
         _title= [NSString stringWithFormat:@"%@",_cityDict[@"name"]];
    }else{
         _title = [NSString stringWithFormat:@"%@",_cityDict[@"name_cn"]];
    }
    _titleLab.text = [NSString stringWithFormat:@"%@ ▼",_title];
     [_titleLab setAttributedText:[self changeLabelWithText:_titleLab.text]];
    
    
    [self creatData];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 120;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
//创建一个返回富文本的方法，用来让lable 显示字体大小不一样

-(NSMutableAttributedString*) changeLabelWithText:(NSString*)needText
{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:needText];
    
    UIFont *font = [UIFont systemFontOfSize:14];
    [attrString addAttribute:NSFontAttributeName value:font range:NSMakeRange(needText.length-1,1)];
    [attrString addAttribute:NSForegroundColorAttributeName value:K153GaryColor range:NSMakeRange(needText.length-1,1)];
    
    return attrString;
}
-(void)creatData{
    NSString * get_latestUrl = [NSString stringWithFormat:@"%@?region=%@&type=A",KAPIMarket_data_get_latest,_cityDict[@"market_region"]];
    NSString * utf8Get_latestUrl = [get_latestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [RCGETRequest requestWithUrl:utf8Get_latestUrl Complete:^(NSData *data) {
        //返回数据
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:NULL];
//        NSLog(@"房价数据--JSON: %@",dict);
        _market_dataDict = dict[@"market_data"];
        if (_market_dataDict.count == 0) {
             [RCAlertView showMessage:[NSString stringWithFormat:@"%@暂无数据",_title]];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
        _dataTypeAry = @[@[@"中位价格",_market_dataDict[@"Median_Sale_Price"],_market_dataDict[@"Median_Sale_Price_MoM"],_market_dataDict[@"Median_Sale_Price_YoY"],
                           @"Median_Sale_Price",@"Median_Sale_Price_MoM",@"Median_Sale_Price_YoY"
                           ],
                         @[@"单位均价",_market_dataDict[@"Price_Per_Square_Feet"],_market_dataDict[@"Price_Per_Square_Feet_Mom"],_market_dataDict[@"Price_Per_Square_Feet_Yoy"],
                           @"Price_Per_Square_Feet",@"Price_Per_Square_Feet_Mom",@"Price_Per_Square_Feet_Yoy"
                           ],
                         @[@"市场存量",_market_dataDict[@"Inventory"],_market_dataDict[@"Inventory_MoM"],_market_dataDict[@"Inventory_YoY"],
                           @"Inventory",@"Inventory_MoM",@"Inventory_YoY"
                           ],
                         @[@"留存时间",_market_dataDict[@"Days_on_Market"],_market_dataDict[@"Days_on_Market_MoM"],_market_dataDict[@"Days_on_Market_YoY"],
                           @"Days_on_Market",@"Days_on_Market_MoM",@"Days_on_Market_YoY"
                           ]
                         ];
        [self.tableView reloadData];
        }
    } faile:^(NSError *error) {
        NSLog(@"房价数据error%@",error);
    }];
    NSString * get_ALLUrl = [NSString stringWithFormat:@"%@?region=%@&type=A",KAPIMarket_data_get_all,_cityDict[@"market_region"]];
    NSString * utf8Gget_ALLUrl = [get_ALLUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [RCGETRequest requestWithUrl:utf8Gget_ALLUrl Complete:^(NSData *data) {
        //返回数据
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:NULL];
//        NSLog(@"房价图表数据--JSON: %@",dict);
//        Median_Sale_Price  中位价
//        Price_Per_Square_Feet 单位均价
//        Inventory 市场存量
//        Days_on_Market 留存时间
        NSArray * ary = dict[@"market_data"];
        if (ary.count == 0) {
            [RCAlertView showMessage:[NSString stringWithFormat:@"%@暂无数据",_title]];
             [self.navigationController popViewControllerAnimated:YES];
        }else{
        NSArray * smallary = [ary subarrayWithRange:NSMakeRange(ary.count-12, 12)];
        
        NSMutableArray * Median_Sale_PriceAry = [[NSMutableArray alloc]init];
        NSMutableArray * Price_Per_Square_FeetAry = [[NSMutableArray alloc]init];
        NSMutableArray * InventoryAry = [[NSMutableArray alloc]init];
        NSMutableArray * Days_on_MarketAry = [[NSMutableArray alloc]init];
        
        NSInteger jizhi0 = [smallary[0][@"Median_Sale_Price"] integerValue]*0.7;
        NSInteger jizhi1 = [smallary[0][@"Price_Per_Square_Feet"] integerValue]*0.7;
        for (NSDictionary * dict in smallary) {
            
            [Median_Sale_PriceAry addObject:[NSNumber numberWithInteger:[dict[@"Median_Sale_Price"] integerValue] - jizhi0]];
            
            [Price_Per_Square_FeetAry addObject:[NSNumber numberWithInteger:[dict[@"Price_Per_Square_Feet"] integerValue] - jizhi1]];
            
            [InventoryAry addObject:[NSNumber numberWithInteger:[dict[@"Inventory"] integerValue]]];
            
            [Days_on_MarketAry addObject:[NSNumber numberWithInteger:[dict[@"Days_on_Market"] integerValue]]];
        }
        _chartAry = @[Median_Sale_PriceAry,Price_Per_Square_FeetAry,InventoryAry,Days_on_MarketAry];
//        NSLog(@"%@",_chartAry);
            [self.tableView reloadData];
        }
    } faile:^(NSError *error) {
        NSLog(@"房价图表数据error%@",error);
    }];

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
    [super viewWillDisappear:(BOOL)animated];
    self.navigationController.navigationBar.hidden=NO;
}
#pragma ----------tableview-----------------
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 204*kScreeHeight/667;
//
//}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * sectionHeaderView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 55)];
    sectionHeaderView1.backgroundColor = [UIColor whiteColor];
    UIView * sectionHeaderView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 55)];
    sectionHeaderView2.backgroundColor =[UIColor whiteColor];
    
    
    
    
    UIView * decorateView = [[UIView alloc]initWithFrame:CGRectMake(16, (55-18.5)/2, 3.5, 18.5)];
    decorateView.backgroundColor = K102GaryColor;
    decorateView.layer.masksToBounds = YES;
    decorateView.layer.cornerRadius = 1.7;
   
    
    UILabel * sectionTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(26, decorateView.frame.origin.y,80,decorateView.frame.size.height )];
    sectionTitleLab.textColor = K102GaryColor;
    sectionTitleLab.font = [UIFont systemFontOfSize:18];
    
    
    
    UILabel * timeLab = [[UILabel alloc]initWithFrame:CGRectMake((kScreeWidth-80)/2, decorateView.frame.origin.y, 80, decorateView.frame.size.height)];

    
    timeLab.text = _market_dataDict[@"Period_End"];
    timeLab.textColor = K102GaryColor;
    timeLab.font = [UIFont systemFontOfSize:15];
    timeLab.textAlignment = NSTextAlignmentCenter;
    
    
    UISegmentedControl * segmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"公制",@"英制"]];
    segmentedControl.frame = CGRectMake(kScreeWidth-17-90,(55-28)/2,90,28);
    // 设置默认选择项索引
    if ([_unit isEqualToString:@"公制"]) {
        segmentedControl.selectedSegmentIndex = 0;
    }else{
        segmentedControl.selectedSegmentIndex = 1;
    }
    
    segmentedControl.tintColor = KTextColor;
    [segmentedControl addTarget:self
                                action:@selector(didClicksegmentedControlAction:)
                      forControlEvents:UIControlEventValueChanged];
    
    
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(16, 54.5, kScreeWidth-32, 0.5)];
    lineView.backgroundColor = K153GaryColor;
    
    
    
    if(section ==0){
        sectionTitleLab.text = @"数据类型";
         [sectionHeaderView1 addSubview:decorateView];
        [sectionHeaderView1 addSubview:sectionTitleLab];
         [sectionHeaderView1 addSubview:timeLab];
        [sectionHeaderView1 addSubview:segmentedControl];
        [sectionHeaderView1 addSubview:lineView];
        
         return sectionHeaderView1;
    }else if (section == 1){
        sectionTitleLab.text = @"精选好房";
        [sectionHeaderView2 addSubview:decorateView];
        [sectionHeaderView2 addSubview:sectionTitleLab];
        return sectionHeaderView2;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section  {
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 55;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UINib * nib=[UINib nibWithNibName:checkIdentifier bundle:nil];
        [_tableView registerNib:nib forCellReuseIdentifier:checkIdentifier];
        RCCheckHousePriceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:checkIdentifier forIndexPath:indexPath ];
        cell.dataTypeLab.text = _dataTypeAry[indexPath.row][0];
        
        float rate = [_dataTypeAry[indexPath.row][3] floatValue];
        if (rate>0) {
            cell.rateLab.text =[NSString stringWithFormat:@"同比%@%%↑",_dataTypeAry[indexPath.row][3]];
            cell.rateLab.textColor = [UIColor colorWithRed:231/255.0 green:1/255.0 blue:29/255.0 alpha:1];
        }else if(rate<0){
            cell.rateLab.text =[NSString stringWithFormat:@"同比%@%%↓",_dataTypeAry[indexPath.row][3]];
            cell.rateLab.textColor = [UIColor colorWithRed:0/255.0 green:193/255.0 blue:67/255.0 alpha:1];
        }else{
            cell.rateLab.text =[NSString stringWithFormat:@"同比%@%%",_dataTypeAry[indexPath.row][3]];
            cell.rateLab.textColor = [UIColor blackColor];
        }
        
        
        
         NSString * untilstr =  [RCUtils ChangeNumberFormat:_dataTypeAry[indexPath.row][1]];
        NSString * exchange_rate = [ud valueForKey:KKEYExchange];
        switch (indexPath.row) {
            case 0:
            {
                if ([_unit isEqualToString:@"公制"]) {
                    cell.dataLab.text = [NSString stringWithFormat:@"￥%.1f万",[_dataTypeAry[indexPath.row][1] floatValue]*[exchange_rate floatValue]*0.1];
                    
                }else if ([_unit isEqualToString:@"英制"]){
                    cell.dataLab.text = [NSString stringWithFormat:@"$%@,000",untilstr];
                }
                break;
            }
            case 1:
            {
                if ([_unit isEqualToString:@"公制"]) {
                    cell.dataLab.text = [NSString stringWithFormat:@"￥%.1f万/㎡",[_dataTypeAry[indexPath.row][1] floatValue]*[exchange_rate floatValue]*10.7639104/10000];
//                    NSLog(@"%.f",[_dataTypeAry[indexPath.row][1] floatValue]*[exchange_rate floatValue]*10.7639104);
                }else if ([_unit isEqualToString:@"英制"]){
                    cell.dataLab.text = [NSString stringWithFormat:@"$%@/ft²",untilstr];
                }
                break;
            }
            case 2:
            {
                cell.dataLab.text = [NSString stringWithFormat:@"%@套",untilstr];
                break;
            }
            case 3:
            {
                cell.dataLab.text = [NSString stringWithFormat:@"%@天",untilstr];
                break;
            }
            default:
                break;
        }
        

//            NSArray * ary =@[@[[NSNumber numberWithInt:5000], @34000, @30000, @40000, @50000, @36000, @47000, @60000, @50000, @30000,
//                           @45000, @50000],
//                         @[@20500, @44000, @37000, @30000, @33000, @36000, @27000, @40000, @30000, @35000,
//                           @35800, @45000],
//                         @[@105, @140, @200, @340, @250, @230, @304, @305, @250, @130,
//                           @450, @250],
//                         @[@4052, @3480, @3003, @2400, @3500, @3000, @4000, @3400, @5300, @3200,
//                           @4500, @5000]
//                         ];
        if (!(_chartAry == nil)) {
            [cell creatBar:_chartAry[indexPath.row]];
        }
        
        return cell;
    }else if (indexPath.section == 1){
        UINib * nib=[UINib nibWithNibName:check2Identifier bundle:nil];
        [_tableView registerNib:nib forCellReuseIdentifier:check2Identifier];
        RCCheckHousePrice2TableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:check2Identifier forIndexPath:indexPath ];
       
        return cell2;
    }
    
    
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        RCHousePriceDataViewController * HousePriceData = [[RCHousePriceDataViewController alloc]init];
        HousePriceData.market_dataAry = _dataTypeAry[indexPath.row];
        HousePriceData.name = _cityDict[@"name"];
        HousePriceData.name_cn = _cityDict[@"name_cn"];
        HousePriceData.market_region = _cityDict[@"market_region"];
        
        [self.navigationController pushViewController:HousePriceData animated:YES];
    }
}
#pragma mark--------------------------------公制英制转换、分享、返回--------------------------------
-(void)didClicksegmentedControlAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    
    switch (Index) {
        case 0:
        {
            _unit = @"公制";
            [self.tableView reloadData];
            break;
        }
        case 1:
        {
            _unit = @"英制";
            [self.tableView reloadData];
            break;
        }
        default:  
            break;  
    }
}
- (IBAction)shareBtn:(id)sender {
//    NSLog(@"%@",_cityDict);
    NSDictionary * dict = @{@"AUS":@"Austin",@"SF":@"San Francisco",@"SD":@"San Diego",@"LA":@"Los Angeles",@"SEA":@"Seattle"};
    NSString * shareUrl0 = [NSString stringWithFormat:@"%@/%@",dict[_cityDict[@"metro_area"]],_cityDict[@"name"]];
    NSString * shareUrl1 = [shareUrl0 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *shareUrl = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.hhause.com/market/%@",shareUrl1]];
    NSString * sharetitle = [NSString stringWithFormat:@" %@ %@ 房价",_cityDict[@"name_cn"],_cityDict[@"name"]];
    
    

    NSString * getUrl = [NSString stringWithFormat:@"%@?name=%@&strip=true",KAPICity_get,_cityDict[@"name"]];
    NSString * utf8Gget_ALLUrl = [getUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [RCGETRequest requestWithUrl:utf8Gget_ALLUrl Complete:^(NSData *data) {
        //返回数据
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:NULL];
        NSString * shareText = dict[@"city"][@"intro"];
        
//        NSRange range = [shareText rangeOfString:@"</strong>"];//匹配得到的下标
//        NSLog(@"rang:%@",NSStringFromRange(range));
//        shareText = [shareText substringWithRange:NSMakeRange(range.location+range.length,shareText.length-range.location-range.length)];
         NSString * shareImage = [NSString stringWithFormat:@"%@%@?imageMogr2/thumbnail/200",KAPIQINIU,dict[@"city"][@"preview"]];
        
         [RCShare shareText:shareText imageArray:shareImage url:shareUrl title:sharetitle];
    } faile:^(NSError *error) {
        NSLog(@"城市数据error%@",error);
    }];

   
}
- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cityBtn:(id)sender {
    
    RCCheckHousePriceCityListViewController * citylist = [[RCCheckHousePriceCityListViewController alloc]init];
    if ([_flag isEqualToString:@"首页"]) {
        [self.navigationController pushViewController:citylist animated:NO];
    }else{
        [self.navigationController popViewControllerAnimated:NO];
    }
    
}
@end
