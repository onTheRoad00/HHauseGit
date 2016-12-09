//
//  RCHousinginformationViewController.m
//  HHause
//
//  Created by HHause on 16/5/4.
//  Copyright © 2016年 HHause. All rights reserved.
//  房源信息页

#import "RCHousinginformationViewController.h"
#import "RCShare.h"
#import "RCSchoolAroundTheHouseViewController.h"

#import "PhotoBrowserView.h"
#import "RCHouseModel.h"
#import "RCAroundSchool.h"
#import "RCLoginViewController.h"

#import "RCFYJSTableViewCell.h"
#import "RCSHHJTableViewCell.h"
#import "RCXQXXTableViewCell.h"
#import "RCXQXX2TableViewCell.h"
#import "RCJYJLTableViewCell.h"
#import "RCQYJSTableViewCell.h"


#import "RCImagesCollectionViewCell.h"
#import "UIImageView+WebCache.h"

#define reuseIdentifier11 @"RCImagesCollectionViewCell"

#define sectionHeaderHight 47
static int rowSHHJ = 0;
static int rowQYJS = 0;
@interface RCHousinginformationViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>


@property (nonatomic,strong) CLGeocoder *geocoder;
@property (nonatomic,strong) PhotoBrowserView *photoBrowserView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)shareBtn:(id)sender;
- (IBAction)ContactBtn:(id)sender;
- (IBAction)cancelBtn:(id)sender;
- (IBAction)collectBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *is_my_favorBtn;




@property (weak, nonatomic) IBOutlet UILabel *addr_city_stateLab;
@property (weak, nonatomic) IBOutlet UILabel *mlsLab;
@property (weak, nonatomic) IBOutlet UILabel *typeLab;
@property (weak, nonatomic) IBOutlet UILabel *flool_areaLab;


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic,copy) NSString * shareTitle;
@property (nonatomic,copy) NSString * shareSummary;

@property (weak, nonatomic) IBOutlet UIView *navView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;


@end

@implementation RCHousinginformationViewController
{
    NSMutableArray * _urlary;
    NSMutableArray * _sectionViewAry;
    NSMutableArray * _sectionButtonAry;
    
    NSString * _transmittype;//转发类型
    NSDictionary * _parameters;//转发参数
    
    RCSHHJTableViewCell * shhjcell;
    
    NSMutableArray * housesAry;
    NSMutableArray * schoolAry;
//    NSMutableArray * cityAry;
    NSMutableDictionary * city_dataDict;
    NSUserDefaults * ud;
    
    NSArray * colorAry;
    
    BOOL _is_metric;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    housesAry = [[NSMutableArray alloc]init];
    schoolAry = [[NSMutableArray alloc]init];
    city_dataDict = [[NSMutableDictionary alloc]init];
    ud = [NSUserDefaults standardUserDefaults];
    

    
    self.title=@"房产名";
    //顶部转换图片
    _urlary = [[NSMutableArray alloc]init];

    [self creatCollectionView];
#pragma warning-----
    //tableView
    
    [self AbouttableView];
    
    //学校颜色
    UIColor * color10 = [UIColor colorWithRed:145/255.0 green:209/255.0 blue:60/255.0 alpha:1];
    UIColor * color9 = [UIColor colorWithRed:145/255.0 green:209/255.0 blue:60/255.0 alpha:1];
    UIColor * color8 = [UIColor colorWithRed:145/255.0 green:209/255.0 blue:60/255.0 alpha:1];
    
    UIColor * color7 = [UIColor colorWithRed:238/255.0 green:138/255.0 blue:65/255.0 alpha:1];
    UIColor * color6 = [UIColor colorWithRed:238/255.0 green:138/255.0 blue:65/255.0 alpha:1];
    UIColor * color5 = [UIColor colorWithRed:238/255.0 green:138/255.0 blue:65/255.0 alpha:1];
    UIColor * color4 = [UIColor colorWithRed:238/255.0 green:138/255.0 blue:65/255.0 alpha:1];
    
    UIColor * color3 = [UIColor colorWithRed:238/255.0 green:86/255.0 blue:65/255.0 alpha:1];
    UIColor * color2 = [UIColor colorWithRed:238/255.0 green:86/255.0 blue:65/255.0 alpha:1];
    UIColor * color1 = [UIColor colorWithRed:238/255.0 green:86/255.0 blue:65/255.0 alpha:1];
    UIColor * color0 = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    
    colorAry = @[color0,color1,color2,color3,color4,color5,color6,color7,color8,color9,color10];
    
    _is_metric = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//#pragma mark--------------------------------轮转图片--------------------------------
//- (void) imageReplace{
//    
//    
//    //用代理处理图片点击
//    self.carouselView.delegate = self;
//    //    self.carouselView.imageArray=_urlarr;
//    
//    //    //设置分页控件指示器的颜色
//    //    [_carouselView setPageColor:[UIColor blueColor] andCurrentPageColor:[UIColor redColor]];
//    
//    //    //设置分页控件的图片,不设置则为系统默认
//    //    [_carouselView setPageImage:[UIImage imageNamed:@"other"] andCurrentPageImage:[UIImage imageNamed:@"current"]];
//    //
//    //    //设置分页控件的位置，默认为PositionBottomCenter
//    //    _carouselView.pagePosition = PositionBottomRight;
//    
//    //    //开启定时器
//    //    _carouselView.isTime=YES;
//    //    //设置图片切换的方式
//    _carouselView.changeMode = ChangeModeFade;
//    
//    //设置每张图片的停留时间
//    //    _carouselView.time = 2;
//    
//}
//#pragma  XRCarouselViewDelegate
//- (void)carouselView:(XRCarouselView *)carouselView didClickImage:(NSInteger)index {
//    NSLog(@"点击了第%ld张图片", (long)index);
//    //隐藏导航栏
//    /*功能描述：
//     1.放大缩小（缩小时背景透明），
//     2.缩小时，两根手指随意全屏拖拽图片
//     3.滚动，计数，默认显示第几张等功能
//     4，集成方便，一句话搞定
//     */
//    
//    
//    
//    //图片浏览器
//    /*
//     urlArray: url 数组
//     CurrentIndex 默认显示第几张图片 （要小于数组长度）
//     frame:大小
//     */
//    _photoBrowserView=[[PhotoBrowserView alloc]initWithFrame:CGRectMake(0, 0, kScreeWidth, kScreeHeight) WithArray:_urlary andCurrentIndex:(int)index];
//    [self.view addSubview:_photoBrowserView];
//}
#pragma mark--------------------------------tableView--------------------------------
-(void)AbouttableView{
    _sectionViewAry =[[NSMutableArray alloc]init];
    _sectionButtonAry  = [[NSMutableArray alloc]init];
    _tableView.delegate=self;
    _tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    NSArray * sectionNameAry =@[@"  房源介绍",@"  生活环境",@"  学区信息",[NSString stringWithFormat:@"  区域介绍 - %@",_city]];
    for (int i = 0; i<sectionNameAry.count; i++) {
        [self creatSectionUI:sectionNameAry[i] Btntag:1000+i];
    }
    //去掉留白
    self.automaticallyAdjustsScrollViewInsets=NO;
}
-(void)creatSectionUI:(NSString *)sectionName Btntag:(NSInteger)tag{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 5,kScreeWidth, sectionHeaderHight-5);
    button.backgroundColor=[UIColor clearColor];
    button.tag= tag;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.selected= YES;
    
    UILabel * lable =[[UILabel alloc]initWithFrame:CGRectMake(7, 2, kScreeWidth-90, sectionHeaderHight-2)];
    
    lable.text=sectionName;
    lable.font = [UIFont systemFontOfSize:18];
    
    lable.textColor=[UIColor grayColor];
    
    
    UIImageView * imageview =[[UIImageView alloc]initWithFrame:CGRectMake(kScreeWidth-30,(sectionHeaderHight-10)/2+5, 20, 10)];
    imageview.image = [UIImage imageNamed:@"箭头2"];
    imageview.tag = button.tag-100;
    
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreeWidth, 2)];
    line.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
    
    UIView * view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreeWidth, sectionHeaderHight)];
    view.backgroundColor = [UIColor whiteColor];
    //    view.alpha = 0.5;
    [view addSubview:line];
    [view addSubview:lable];
    [view addSubview:imageview];
    [view addSubview:button];
    
    [_sectionButtonAry addObject:button];
    [_sectionViewAry addObject:view];
}
-(void)buttonClick:(UIButton *)button{
    button.selected = !button.selected;
    UIImageView * imageview =(UIImageView *)[self.view viewWithTag:button.tag-100];
    if (button.selected) {
        imageview.image =[UIImage imageNamed:@"箭头2"];
    }
    else
    {
        imageview.image =[UIImage imageNamed:@"箭头"];
    }
#pragma -----------------体验问题---------------------------------------------------------------
    [self.tableView reloadData];
    //    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:button.tag-1000] withRowAnimation:UITableViewRowAnimationTop];
}
#pragma mark--------------------------------tableViewDelegate--------------------------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _sectionViewAry.count;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return _sectionViewAry[section];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section  {
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return sectionHeaderHight+5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    UIButton * button =_sectionButtonAry[section];
    if (button.selected==NO) {
        return 0;
    }
    else if(housesAry.count>0)
    {
        switch (section) {
            case 0:
                return 1;
                break;
            case 1:
                return 1;
                break;
            case 2:
            {
                NSInteger num  = schoolAry.count;
                if (num>0) {
                    num+=1;
                }
                return num;
                break;
            }
            case 3:
                if (city_dataDict==nil) {
                    return 0;
                }
                return 1;
                break;
            default:
                break;
        }
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RCHouseModel * housemodel =housesAry[0];
    NSString * rate = [ud valueForKey:KKEYExchange];
    switch (indexPath.section) {
        case 0:
        {
            
            UINib * nib=[UINib nibWithNibName:@"RCFYJSTableViewCell" bundle:nil];
            [_tableView registerNib:nib forCellReuseIdentifier:@"RCFYJSTableViewCell"];
            RCFYJSTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"RCFYJSTableViewCell" forIndexPath:indexPath];
            
            if(!_is_metric){
#pragma mark-----英制
                cell.metric_ConversionsBtn.selected = NO;
                //月租金 est_rent
                NSString * est_rent         =   [NSString stringWithFormat:@"%@",housemodel.est_rent];
                if (!([est_rent isEqualToString:@""]||[est_rent isEqualToString:@"0"])) {
                    cell.est_rentLab.text   =   [NSString stringWithFormat:@"$%@元/月",[RCUtils ChangeNumberFormat:est_rent]];
                }
                
                //物业费 hoa
                NSString * hoa_fee   =[NSString stringWithFormat:@"%@",housemodel.hoa_fee];
                if (!([hoa_fee isEqualToString:@""]||[hoa_fee isEqualToString:@"0"])) {
                    cell.hoa_feeLab.text    =   [NSString stringWithFormat:@"$%@元/月",[RCUtils ChangeNumberFormat:hoa_fee]];
                }
                //单价 price_sqft
                NSString * price_sqft       =   [NSString stringWithFormat:@"%@",housemodel.price_sqft ];
                if (!([price_sqft isEqualToString:@""]||[price_sqft isEqualToString:@"0.0"])) {
                    cell.price_sqftLab.text =   [NSString stringWithFormat:@"$%@/ft²",price_sqft];
                }
                //房产税  tax_rate
                NSString * tax_rate = [NSString stringWithFormat:@"%@",housemodel.tax_rate];
                if (!([tax_rate isEqualToString:@"null"]||[tax_rate isEqualToString:@"(null)"])) {
                    NSString * tax = [NSString stringWithFormat:@"%.f",[housemodel.tax_rate floatValue]*0.01*[housemodel.price floatValue]];
                    cell.tax_rate.text = [NSString stringWithFormat:@"$%@/年",[RCUtils ChangeNumberFormat:tax]];
                }
                //建筑面积 floor_area
                NSString * floor_number       =   [NSString stringWithFormat:@"%@",housemodel.floor_area];
                if (!([floor_number isEqualToString:@""]||[floor_number isEqualToString:@"0"])) {
                    cell.floor_number.text =   [NSString stringWithFormat:@"%@ft²",[RCUtils ChangeNumberFormat:floor_number]];
                }
                //占地面积 space_area
                NSString * space_area       =   [NSString stringWithFormat:@"%@",housemodel.space_area];
                if (!([space_area isEqualToString:@""]||[space_area isEqualToString:@"0"])) {
                    cell.space_areaLab.text =   [NSString stringWithFormat:@"%@ft²",[RCUtils ChangeNumberFormat:space_area]];
                }
            }else{
#pragma mark-----公制
                cell.metric_ConversionsBtn.selected = YES;
                //月租金 est_rent
                NSString * est_rent         =   [NSString stringWithFormat:@"%.f",(int)[housemodel.est_rent floatValue]*[rate floatValue]];
                if (!([est_rent isEqualToString:@""]||[est_rent isEqualToString:@"0"])) {
                    cell.est_rentLab.text   =   [NSString stringWithFormat:@"￥%@元/月",[RCUtils ChangeNumberFormat:est_rent]];
                }
                
                //物业费 hoa
                NSString * hoa_fee   =[NSString stringWithFormat:@"%.f",(int)[housemodel.hoa_fee floatValue]*[rate floatValue]];
                if (!([hoa_fee isEqualToString:@""]||[hoa_fee isEqualToString:@"0"])) {
                    cell.hoa_feeLab.text    =   [NSString stringWithFormat:@"￥%@元/月",[RCUtils ChangeNumberFormat:hoa_fee]];
                }
                //单价 price_sqft
                NSString * price_sqft       =   [NSString stringWithFormat:@"%.1f",(int)[housemodel.price_sqft floatValue]*[rate floatValue]*10.7639104/10000];
                if (!([price_sqft isEqualToString:@""]||[price_sqft isEqualToString:@"0.0"])) {
                    cell.price_sqftLab.text =   [NSString stringWithFormat:@"￥%@万/㎡",price_sqft];
                }
                //房产税  tax_rate
                NSString * tax_rate = [NSString stringWithFormat:@"%@",housemodel.tax_rate];
                if (!([tax_rate isEqualToString:@"null"]||[tax_rate isEqualToString:@"(null)"])) {
                    NSString * tax = [NSString stringWithFormat:@"%.1f",[housemodel.tax_rate floatValue]*0.01*[housemodel.price floatValue]*[rate floatValue]/10000];
                    cell.tax_rate.text = [NSString stringWithFormat:@"￥%@万/年",[RCUtils ChangeNumberFormat:tax]];
                }
                //建筑面积 floor_area
                NSString * floor_number       =   [NSString stringWithFormat:@"%.f",[housemodel.floor_area floatValue]/10.7639104];
                if (!([floor_number isEqualToString:@""]||[floor_number isEqualToString:@"0"])) {
                    cell.floor_number.text =   [NSString stringWithFormat:@"%@㎡",[RCUtils ChangeNumberFormat:floor_number]];
                }
                //占地面积 space_area
                NSString * space_area       =   [NSString stringWithFormat:@"%.f",[housemodel.space_area floatValue]/10.7639104];
                if (!([space_area isEqualToString:@""]||[space_area isEqualToString:@"0"])) {
                    cell.space_areaLab.text =   [NSString stringWithFormat:@"%@㎡",[RCUtils ChangeNumberFormat:space_area]];
                }
            }
//税率
            
            cell.rateLab.text = [NSString stringWithFormat:@"%@",rate];
//车位数
            NSString * parkings = [NSString stringWithFormat:@"%@",housemodel.parkings];
            if (!([parkings isEqualToString:@""]||[parkings isEqualToString:@"0"])) {
                cell.parking_placeLab.text   =   parkings;
            }
//卧室 bedroom
            NSString * bedroom          =   [NSString stringWithFormat:@"%@",housemodel.bedrooms];
            if (!([bedroom isEqualToString:@""]||[bedroom isEqualToString:@"0"])) {
                cell.bedroomsLab.text   =   [NSString stringWithFormat:@"%@间",bedroom];
            }
//卫浴
            NSString * partial_baths = [NSString stringWithFormat:@"%@",housemodel.partial_baths];
            if (!([partial_baths isEqualToString:@""]||[partial_baths isEqualToString:@"0"])) {
                partial_baths = [NSString stringWithFormat:@"%@间客用",partial_baths];
            }
            else{
                partial_baths = [NSString stringWithFormat:@""];
            }
            cell.bathsLab.text = [NSString stringWithFormat:@"%@间完整%@",housemodel.full_baths,partial_baths];
//建筑年代 built_year
            NSString * built_year =[NSString stringWithFormat:@"%@",housemodel.built_year];
            if (!([built_year isEqualToString:@""]||[built_year isEqualToString:@"0"])) {
                cell.built_yearLab.text     =   [NSString stringWithFormat:@"%@年",built_year];
            }
//  价格->mls
            cell.priceLab.text = housemodel.mls;

            __weak typeof(cell) weakCell = cell;
            __weak typeof(self) weakself = self;
            cell.btnBlock=^(BOOL select) {
                /*函数回调 当block执行时就会回到这里*/
                if (select) {
                    weakCell.houseDescription.text =housemodel.intro;
                    [weakself.tableView reloadData];
                }
                else
                {
                    weakCell.houseDescription.text =nil;
                    [weakself.tableView reloadData];
                }
            };
            cell.metic_ConversionBlock = ^(BOOL metic){
                _is_metric = metic;
                
                //修改顶部信息
                RCHouseModel * housemodel;
                if(housesAry.count>0){
                    housemodel=housesAry[0];
                }
                //      房子类型
                NSString * housetype;
                if ([housemodel.type isEqualToString:@"A"]) {
                    housetype = @"公寓";
                }else if ([housemodel.type isEqualToString:@"H"]){
                    housetype = @"独栋别墅";
                }else if ([housemodel.type isEqualToString:@"T"]){
                    housetype = @"联排别墅";
                }
                _typeLab.text = housetype;

                
                if (!_is_metric) {
                    //英制
                    //面积
                    _flool_areaLab.text = [NSString stringWithFormat:@"%@平方英尺",housemodel.floor_area];
                    //        //      MLS->价格|平方英尺|类型
                    _mlsLab.text = [NSString stringWithFormat:@"$ %.f万  丨  %@  丨  %@",[housemodel.price floatValue]/10000,_flool_areaLab.text,housetype];
//                    NSLog(@"%.1d,%.1f,%.1f",(int)[housemodel.price floatValue]/10000,[housemodel.price floatValue]/10000,(float)[housemodel.price intValue]/10000);
                }else
                {
                    //公制
                    //面积
                    _flool_areaLab.text = [NSString stringWithFormat:@"%.f平方米",[housemodel.floor_area floatValue]/10.7639104];
                    //        //      MLS->价格|平方英尺|类型
                    _mlsLab.text = [NSString stringWithFormat:@"￥ %.f万  丨  %@  丨  %@",[housemodel.price floatValue]*[rate floatValue]/10000,_flool_areaLab.text,housetype];
                }
                
                /*
                 UITableViewRowAnimationFade,
                 UITableViewRowAnimationRight,           // slide in from right (or out to right)
                 UITableViewRowAnimationLeft,
                 UITableViewRowAnimationTop,
                 UITableViewRowAnimationBottom,
                 UITableViewRowAnimationNone,            // available in iOS 3.0
                 UITableViewRowAnimationMiddle,
                 */
//              [weakself.tableView reloadData];
                [weakself.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationLeft];
                
            };
            return cell;
        }
            break;
        case 1:
        {
            UINib * nib=[UINib nibWithNibName:@"RCSHHJTableViewCell" bundle:nil];
            [_tableView registerNib:nib forCellReuseIdentifier:@"RCSHHJTableViewCell"];
            shhjcell=[tableView dequeueReusableCellWithIdentifier:@"RCSHHJTableViewCell" forIndexPath:indexPath];
            if (rowSHHJ == 0) {
                 [shhjcell getLocationLatitude:housemodel.lat longitude:housemodel.lng title:_shareTitle subtitle:@""];
                rowSHHJ++;
            }
//            NSLog(@"SHHJ:%d",rowSHHJ);
            return shhjcell;
        }
            break;
        case 2:
        {
            if (indexPath.row!=schoolAry.count){
                UINib * nib=[UINib nibWithNibName:@"RCXQXXTableViewCell" bundle:nil];
                [_tableView registerNib:nib forCellReuseIdentifier:@"RCXQXXTableViewCell"];
                RCXQXXTableViewCell * cell  =   [tableView dequeueReusableCellWithIdentifier:@"RCXQXXTableViewCell" forIndexPath:indexPath];
                RCAroundSchool * schoolMode =   schoolAry[indexPath.row];
//                学校名字
                cell.schoolNameLab.text = schoolMode.sch_name;
//                学校评分
                if ([schoolMode.rating isEqualToString:@"0"]) {
                    cell.scoreLab.text      =   @"";
                }else{
                    cell.scoreLab.text      =   schoolMode.rating;
                }
                cell.scoreLab.backgroundColor = colorAry[[schoolMode.rating integerValue]];
//                学校类型
                NSString * ed_level;
                NSString * isPublic = @"公立";
                if ([schoolMode.ed_level isEqualToString:@"P"]) {
                    ed_level = @"小学";
                }else if([schoolMode.ed_level isEqualToString:@"M"]){
                    ed_level = @"中学";
                }else if ([schoolMode.ed_level isEqualToString:@"H"]){
                    ed_level = @"高中";
                }else if ([schoolMode.ed_level isEqualToString:@"PH"]){
                    ed_level = @"小学+中学";
                }
                if([isPublic isEqualToString:@"0"]){
                    isPublic = @"私立";
                }
                cell.schoolTypeLab.text =[NSString stringWithFormat:@"%@ %@",isPublic,ed_level];
                if ([schoolMode.isPrimary isEqualToString:@"1"]) {
                    cell.schoolTypeLab.text =[NSString stringWithFormat:@"%@ %@  分配",isPublic,ed_level];
                }

//                距离
                cell.distanceLab.text =[NSString stringWithFormat:@"%.2fkm",[schoolMode.distance floatValue]*1.609344];
                return cell;
            }
            UINib * nib = [UINib nibWithNibName:@"RCXQXX2TableViewCell" bundle:nil];
            [_tableView registerNib:nib forCellReuseIdentifier:@"RCXQXX2TableViewCell"];
            RCXQXX2TableViewCell * cell2 = [tableView dequeueReusableCellWithIdentifier:@"RCXQXX2TableViewCell" forIndexPath:indexPath];
            return  cell2;
        }
            break;
        case 3:
        {
            UINib * nib=[UINib nibWithNibName:@"RCQYJSTableViewCell"bundle:nil];
            [_tableView registerNib:nib forCellReuseIdentifier:@"RCQYJSTableViewCell"];
            RCQYJSTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"RCQYJSTableViewCell" forIndexPath:indexPath];
            if (rowQYJS ==0) {
                //            家庭年均收入
                
                    //英制
                    NSString *income =[NSString stringWithFormat:@"%@",city_dataDict[@"income"]];
                    if(![income isEqualToString:@"<null>"]){
                        cell.percapitaIncomeLab.text=[NSString stringWithFormat:@"$%@",[RCUtils ChangeNumberFormat:city_dataDict[@"income"]]];
                    }
                
////
                
            
                //            大学生教育比例
                
                if(![[NSString stringWithFormat:@"%@",city_dataDict[@"bachelor"]] isEqualToString:@"<null>"]){
                    cell.educationLab.text =[NSString stringWithFormat:@"%@%%",city_dataDict[@"bachelor"]];
                }
                //            人口
                
                if(![[NSString stringWithFormat:@"%@",city_dataDict[@"population"]] isEqualToString:@"<null>"]){
                    cell.population.text=[NSString stringWithFormat:@"%@",[RCUtils ChangeNumberFormat:city_dataDict[@"population"]]];
                }
                //            失业率
                if(!([[NSString stringWithFormat:@"%@",city_dataDict[@"unemployment"]] isEqualToString:@"<null>"]||[[NSString stringWithFormat:@"%@",city_dataDict[@"unemployment"]] isEqualToString:@"(null)"])){
                    cell.UnemploymentLab.text=[NSString stringWithFormat:@"%@%%",city_dataDict[@"unemployment"]];
                }
                //            饼图
                if (![[NSString stringWithFormat:@"%@",city_dataDict[@"white"]] isEqualToString:@"<null>"]) {
                    NSString * white = city_dataDict[@"white"];
                    NSString * asian = city_dataDict[@"asian"];
                    NSString * black = city_dataDict[@"black"];
                    NSString * hispanic = city_dataDict[@"hispanic"];
                    NSString * other =[NSString stringWithFormat:@"%.1f",100-[white floatValue]-[asian floatValue]-[black floatValue]-[hispanic floatValue]];
                    [cell showPieChart:@[[NSString stringWithFormat:@"%@%%",asian],[NSString stringWithFormat:@"%@%%",white],[NSString stringWithFormat:@"%@%%",black],[NSString stringWithFormat:@"%@%%",hispanic],[NSString stringWithFormat:@"%@%%",other]]];
                }
                else{
                    [cell showPieChart:@[@"-",@"-",@"-",@"-",@"-"]];
                }
                //            安全指数
                if (![[NSString stringWithFormat:@"%@",city_dataDict[@"cri"]] isEqualToString:@"<null>"]) {
                    [cell safe:city_dataDict[@"cri"]];
                }
                rowQYJS++;
            }
//            NSLog(@"rowQYJS:%d",rowQYJS);
            return cell;
        }
            break;
        default:
            break;
    }
    
    
    static NSString *cellID = @"CELUD";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    //    cell.backgroundColor = [UIColor yellowColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"%ld,%ld,%lu",(long)indexPath.section,(long)indexPath.row,(unsigned long)schoolAry.count);
    if(indexPath.section ==2 && indexPath.row==schoolAry.count){
        RCSchoolAroundTheHouseViewController * schoolController = [[RCSchoolAroundTheHouseViewController alloc]init];
        schoolController.mls = _mls;
        [self.navigationController pushViewController:schoolController animated:YES];
    }

}
#pragma mark--------------------------------share--------------------------------
- (IBAction)shareBtn:(id)sender {
    RCHouseModel * housemodel;
//    NSLog(@"housesAry:%@,%@",housesAry,housesAry[0]);
    if(housesAry.count>0){
       housemodel=housesAry[0];
    }
    NSString * imageStr = [NSString stringWithFormat:@"%@%@?imageMogr2/thumbnail/200",KAPIQINIU,housemodel.preview];
    //1、创建分享参数
    NSArray* imageArray  = @[imageStr];
    
    //    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    //    //分享链接
    NSURL * _shareUrl =[NSURL URLWithString:[NSString stringWithFormat:@"http://hhause.com/home/%@?from=weixin",_houseId]];
    
    
    NSString * housetype =_typeLab.text;
//    if ([housemodel.type isEqualToString:@"A"]) {
//        housetype = @"公寓";
//    }else if ([housemodel.type isEqualToString:@"H"]){
//        housetype = @"独栋别墅";
//    }else if ([housemodel.type isEqualToString:@"T"]){
//        housetype = @"联排别墅";
//    }else{
//        housetype = @"房子";
//    }
    //
    /**
     *房源属性。
     0 = 不具备以下任何属性。注意：不等于不限属性
     1 = 投资房
     2 = 学区房
     4 = 豪宅
     3 = 投资房 + 学区房
     5 = 投资房 + 豪宅
     6 = 学区房 + 豪宅
     7 = 投资房 + 学区房 + 豪宅
     */
    NSString * house_attributes;
    switch ([housemodel.attributes intValue]) {
            
        case 0:
            house_attributes = @"";
            break;
        case 1:
            house_attributes = @"投资房";
            break;
        case 2:
            house_attributes = @"学区房";
            break;
        case 3:
            house_attributes = @"豪宅";
            break;
        case 4:
            house_attributes = @"投资房+学区房";
            break;
        case 5:
            house_attributes = @"投资房+豪宅";
            break;
        case 6:
            house_attributes = @"学区房+豪宅";
            break;
        case 7:
            house_attributes = @"投资房+学区房+豪宅";
            break;
        default:
            break;
    }
    /**
    *都市圈代码
    SF = San Francisco 旧金山
    LA = Los Angeles 洛杉矶
    SD = San Diego 圣地亚哥
    SEA = Seattle 西雅图
    */
    NSString * house_metro_area ;
    if ([housemodel.metro_area isEqualToString:@"SF"]) {
        house_metro_area = @"旧金山 · ";
    }else if ([housemodel.metro_area isEqualToString:@"LA"]) {
        house_metro_area = @"洛杉矶 · ";
    }else if ([housemodel.metro_area isEqualToString:@"SD"]) {
        house_metro_area = @"圣地亚哥 · ";
    }else if ([housemodel.metro_area isEqualToString:@"SEA"]) {
        house_metro_area = @"西雅图 · ";
    }else if ([housemodel.metro_area isEqualToString:@"SAO"]) {
        house_metro_area = @"圣安东尼奥 · ";
    }
    else{
        house_metro_area = @"";
    }
    _shareTitle    = [NSString stringWithFormat:@"%@%@ | %@ | %@室%d卫 | %@ | $%.f万",house_metro_area,housemodel.city,house_attributes,housemodel.bedrooms,[housemodel.full_baths intValue]+[housemodel.partial_baths intValue],housetype,[housemodel.price floatValue]/10000];
    
    _shareSummary = [NSString stringWithFormat:@"建于%@年%@ft²的%@室%d卫%@仅售$%.f万",housemodel.built_year,housemodel.floor_area,housemodel.bedrooms,(int)[housemodel.full_baths intValue]+[housemodel.partial_baths intValue],housetype,[housemodel.price floatValue]/10000];
//    NSLog(@"%@,%@",_shareTitle,_shareSummary);
    [RCShare shareText:_shareSummary imageArray:imageStr url:_shareUrl title:_shareTitle];
}

- (IBAction)ContactBtn:(id)sender {
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

- (IBAction)cancelBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    //    [self dismissViewControllerAnimated:NO completion:^{
    //
    //    }];
}
#pragma mark-------------------------------share--------------------------
- (IBAction)collectBtn:(id)sender {
//    1、判断是否登陆
//    2、未登录-登陆
//    3、判断selected----->yes: 移除，---no:收藏
//    3、  请求
//    4、   改变selected

//    1、判断是否登陆
    if ([[ud valueForKey:KKEYLogin_successORdefeat]isEqualToString:KKEYLogin_success]) {
//        已登录登陆
//    3、判断selected----->yes: 移除，---no:收藏
        UIButton * btn = sender;
        NSString * collectstate;
        if (btn.selected) {
//            已收藏，移除
            collectstate =  [NSString stringWithFormat:@"%@?home_id=%@&access_token=%@",KAPIFAVOER_romeve_home,_houseId,[ud valueForKey:KKEYAccess_token]];
        }else{
//            未收藏，收藏
            collectstate =  [NSString stringWithFormat:@"%@?home_id=%@&access_token=%@",KAPIFAVOR_add_home,_houseId,[ud valueForKey:KKEYAccess_token]];
        }
        [RCGETRequest requestWithUrl:collectstate Complete:^(NSData *data) {
            //返回数据
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:NULL];
//            NSLog(@"收藏或移除收藏：\n\n%@\n\n",dict);
            if (dict[@"success"]) {
                if (btn.selected) {
//                    NSLog(@"移除收藏--JSON: %@",dict);
                    btn.selected =NO;
                    
                }else
                {
//                    NSLog(@"添加为收藏房源--JSON: %@",dict);
                     btn.selected =YES;
                }
#pragma mark---
//                if (btn.selected) {
//                    [ud setValue:@"1" forKey:@"indexPathSelected"];
//                }else{
//                    [ud setValue:@"0" forKey:@"indexPathSelected"];
//                }
                //////// searchlist cell block
                if (self.favBlock1) {
                    self.favBlock1(btn.selected);
                }
 #pragma mark---               
            }
            else{
                [RCAlertView showMessage:@"操作失败"];
            }
            
            
        } faile:^(NSError *error) {
//            NSLog(@"error:%@",error);
        }];

    }else
    {
//    2、未登录-登陆
        RCLoginViewController * login =[[RCLoginViewController alloc]init];
        [self presentViewController:login animated:YES completion:^{
            
        }];
    }
    
    

 
    
}
-(void)creatData{
///////////基本数据/////////////////
     [SVProgressHUD show];
    NSString * access_token = [ud valueForKey:KKEYAccess_token];
    if ([access_token isEqualToString:@"(null)"]) {
        access_token = @"";
    }
//    NSLog(@"房源数据URL:%@",[NSString stringWithFormat:@"%@?id=%@&access_token=%@",KAPIHome_get,_houseId,access_token]);
    [RCGETRequest requestWithUrl:[NSString stringWithFormat:@"%@?id=%@&access_token=%@",KAPIHome_get,_houseId,access_token] Complete:^(NSData *data) {
         [SVProgressHUD dismiss];
        //返回数据
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:NULL];
//        NSLog(@"房源详情--JSON: %@",dict);
        if (dict[@"error"]) {
            [RCAlertView showMessage:[NSString stringWithFormat:@"%@",dict[@"error"][@"msg"]]];
        }else{
        RCHouseModel * housemodel =[[RCHouseModel alloc]initWithDictionary:dict[@"home"] error:nil];
        
        [housesAry addObject:housemodel];
        //      房子类型
        NSString * housetype;
        if ([housemodel.type isEqualToString:@"A"]) {
            housetype = @"公寓";
        }else if ([housemodel.type isEqualToString:@"H"]){
            housetype = @"独栋别墅";
        }else if ([housemodel.type isEqualToString:@"T"]){
            housetype = @"联排别墅";
        }else{
            housetype = @"";
        }
        _typeLab.text = housetype;
            
            _titleLab.text =[NSString stringWithFormat:@"%@室%d卫%@",housemodel.bedrooms,[housemodel.full_baths intValue]+[housemodel.partial_baths intValue],housetype];
        //        面积
            NSString * area =[NSString stringWithFormat:@"%@平方英尺",housemodel.floor_area];
            
        _flool_areaLab.text = area;
//        //      MLS->价格|平方英尺|类型
            _mlsLab.text = [NSString stringWithFormat:@"$ %.f万  丨  %@  丨  %@",[housemodel.price floatValue]/10000,area,housetype];
        //       地址
        _addr_city_stateLab.text = [NSString stringWithFormat:@"%@,%@,%@",housemodel.addr,housemodel.city,housemodel.state];
        //      顶部图片
        NSArray *imageUrlAry = [housemodel.images componentsSeparatedByString:@";"];
        
        for (int i = 0; i<imageUrlAry.count-1; i++) {
//            NSString * imageUrl =[NSString stringWithFormat:@"%@%@?imageView2/2/w/%.f",KAPIQINIU,imageUrlAry[i],kScreeWidth*2];
            NSString * imageUrl =[NSString stringWithFormat:@"%@%@?imageMogr2",KAPIQINIU,imageUrlAry[i]];
            //图片url
            [_urlary addObject:imageUrl];
        }
        //        是否收藏
        if ([housemodel.is_my_favor isEqualToString:@"1"]) {
            _is_my_favorBtn.selected = YES;
        }
#pragma warning-----------------------------------------------
//        self.carouselView.imageArray=_urlary;
        [self.collectionView reloadData];
#pragma ma
        [self.tableView reloadData];
        }
    } faile:^(NSError *error) {
//        NSLog(@"error:%@",error);
         [SVProgressHUD dismiss];
         [RCAlertView showMessage:error.userInfo[@"NSLocalizedDescription"]];
    }];
/////学校数据//////////////////////
    [RCGETRequest requestWithUrl:[NSString stringWithFormat:@"%@?mls=%@",KAPISchool_List_around,_mls] Complete:^(NSData *data) {
        //返回数据
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:NULL];
//        NSLog(@"学校数据--JSON: %@",dict);
        [schoolAry removeAllObjects];
        NSArray * ary =dict[@"schools"];
        for (int i = 0; i<ary.count; i++) {
            RCAroundSchool * schoolModel = [[RCAroundSchool alloc]initWithDictionary:ary[i] error:nil];
            
            [schoolAry addObject:schoolModel];
        }

        [self.tableView reloadData];
    } faile:^(NSError *error) {
//        NSLog(@"error:%@",error);
    }];
////城市数据//////////////////////
    
    NSArray *cityUrlAry = [_city componentsSeparatedByString:@" "];
    NSString * cityUrl = cityUrlAry[0];
        for (int i = 1; i<cityUrlAry.count; i++) {
            cityUrl =[NSString stringWithFormat:@"%@+%@",cityUrl,cityUrlAry[i]];
        }
//    NSLog(@"%@",[NSString stringWithFormat:@"%@?city=%@",KAPICity_get_data,cityUrl]);
    [RCGETRequest requestWithUrl:[NSString stringWithFormat:@"%@?city=%@",KAPICity_get_data,cityUrl] Complete:^(NSData *data) {
        //返回数据
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:NULL];
//        NSLog(@"城市详情--JSON: %@",dict);
        city_dataDict = [NSMutableDictionary dictionaryWithDictionary:dict[@"city_data"]];
        
        [self.tableView reloadData];
        
    } faile:^(NSError *error) {
//        NSLog(@"error:%@",error);
    }];
}
#pragma mark--------------------------------Appear--------------------------------
//隐藏导航栏
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
    
//    判断是不是从收藏过来的，若果是则select =  yes
    if ([_cdup isEqualToString:@"收藏房源"]) {
        _is_my_favorBtn.selected = YES;
    }
    [self creatData];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    rowQYJS = 0;
    rowSHHJ = 0;
}
//取消隐藏
- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:(BOOL)animated];
    self.navigationController.navigationBar.hidden=NO;
    [SVProgressHUD dismiss];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
   
    //        self.navigationController.navigationBar.hidden=NO;
}
- (void)dealloc
{
    _tableView = nil;
    _photoBrowserView = nil;
   
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
    
    NSLog(@"\n\t\n\t\n\t   houseinginfo释放了\n\t\n\t\n\t");
}
-(void) creatCollectionView{
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    UINib * nib=[UINib nibWithNibName:reuseIdentifier11 bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier11];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.collectionView.frame.size;
}
#pragma mark- collectionViewDatasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //    return self.arrayCerImages.count;
    return _urlary.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RCImagesCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier11 forIndexPath:indexPath];
    
    //数据
    //    NSDictionary *dic = self.arrayCerImages[indexPath.row];
    //    cell.nameLab.text = dic[@"fileUrl"];
    //    NSString * urlstring =[NSString stringWithFormat:@"***%@",dic[@"image"]];
    
    
         [cell.imageView sd_setImageWithURL:[NSURL URLWithString:_urlary[indexPath.row]] placeholderImage:[UIImage imageNamed:@"顶部过渡"]];
    NSLog(@"%ld",(long)indexPath.row);
    cell.indexLab.text = [NSString stringWithFormat:@"%ld/%lu",(long)indexPath.row+1,(unsigned long)_urlary.count];
    return cell;
}

#pragma mark- collectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
//    NSLog(@"%ld",(long)indexPath.row);
    //图片浏览器
    /*
     urlArray: url 数组
     CurrentIndex 默认显示第几张图片 （要小于数组长度）
     frame:大小
     */
    _photoBrowserView=[[PhotoBrowserView alloc]initWithFrame:CGRectMake(0, 0, kScreeWidth, kScreeHeight) WithArray:_urlary andCurrentIndex:(int)indexPath.row];
    [self.view addSubview:_photoBrowserView];
}
#pragma mark ----------scrollView-----------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offset = scrollView.contentOffset.y;
    NSLog(@"%f,%f,%f",offset,_navView.alpha,_collectionView.frame.size.height);
    if ([scrollView isEqual:_tableView]) {

        if (offset<_collectionView.frame.size.height) {
            _navView.alpha = 1/(_collectionView.frame.size.height - _navView.frame.size.height)*offset;
        }else {
            _navView.alpha = 1;
        }
        
    }
}

@end
