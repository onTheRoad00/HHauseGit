//
//  RCSearchListViewController.m
//  HHause
//
//  Created by HHause on 16/5/26.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "RCSearchListViewController.h"
#import "RCHouseTableViewCell.h"
#import "RCHousinginformationViewController.h"
#import "RCHomesModel.h"
#import "RCLoginViewController.h"
//动画时间
#define kAnimationDuration 0.5
#define Identifier @"RCHouseTableViewCell"
@interface RCSearchListViewController ()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate>


@property (weak, nonatomic) IBOutlet UIButton *rightBarButton;
- (IBAction)rightBarButton:(id)sender;

- (IBAction)BackBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIView *leftBarView;


//排序View
@property (weak, nonatomic) IBOutlet UIView *SortingView;
@property (weak, nonatomic) IBOutlet UIButton *fromLowToHighBtn;
@property (weak, nonatomic) IBOutlet UIButton *fromHighToLowBtn;
@property (weak, nonatomic) IBOutlet UIButton *NewProductsBtn;
- (IBAction)AboutSortBtn:(id)sender;


//更多筛选条件外部
@property (weak, nonatomic) IBOutlet UIView *moreSearchVIew;
- (IBAction)searchBtn:(id)sender;
- (IBAction)_rightBarButton1:(id)sender;
- (IBAction)cancelBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *titleLab1;
//更多筛选条件内部
//需求类型
@property (weak, nonatomic) IBOutlet UIButton *InvestmentPropertyBtn;
@property (weak, nonatomic) IBOutlet UIButton *schoolDistrictBtn;
@property (weak, nonatomic) IBOutlet UIButton *luxuryRealEstateBtn;
- (IBAction)RequirementTypeBtn:(id)sender;
//面积
@property (weak, nonatomic) IBOutlet UIButton *area000Btn;

@property (weak, nonatomic) IBOutlet UIButton *area111Btn;

@property (weak, nonatomic) IBOutlet UIButton *area222Btn;
- (IBAction)houseType:(id)sender;

//内部格局
- (IBAction)bedroomBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *bedroomLab;

- (IBAction)bathroomBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *bathroomLab;

//更多
@property (weak, nonatomic) IBOutlet UIView *moreView;
@property (weak, nonatomic) IBOutlet UILabel *moreLab;
- (IBAction)searchConditionBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *searchConditionBtn;
@property (weak, nonatomic) IBOutlet UIImageView *moreArrow;


//view//区域
@property (weak, nonatomic) IBOutlet UIView *viewVIew;


@property (weak, nonatomic) IBOutlet UIView *areaView;
@property (weak, nonatomic) IBOutlet UILabel *areaLab;
- (IBAction)areaBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *areaBtn;
@property (weak, nonatomic) IBOutlet UIImageView *areaArrow;

//价格
@property (weak, nonatomic) IBOutlet UIView *priceView;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
- (IBAction)priceBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *priceBtn;
@property (weak, nonatomic) IBOutlet UIImageView *priceArrow;


//本是面积，后改称 类型，
@property (weak, nonatomic) IBOutlet UIView *floorageView;
@property (weak, nonatomic) IBOutlet UILabel *floorageLab;
- (IBAction)floorageBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *floorageBtn;
@property (weak, nonatomic) IBOutlet UIImageView *floorageArrow;

- (IBAction)typeSelectBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *duDongBtn;
@property (weak, nonatomic) IBOutlet UIButton *lianPaiBtn;
@property (weak, nonatomic) IBOutlet UIButton *gongYuBtn;



//showView
@property (weak, nonatomic) IBOutlet UIView *showView;
@property (weak, nonatomic) IBOutlet UIView *bgShowView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *areaTableView0;
@property (weak, nonatomic) IBOutlet UITableView *areaTableView1;
@property (weak, nonatomic) IBOutlet UITableView *otherTableView;
@property (weak, nonatomic) IBOutlet UIView *typeView;

//导航 navView
@property (weak, nonatomic) IBOutlet UIView *navView;


@property (nonatomic, assign) BOOL canceled;

@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@property (weak, nonatomic) IBOutlet UIImageView *bgdeImageView;

@property (nonatomic,weak)IBOutlet UILabel * lastlable;
@property (nonatomic,weak)IBOutlet UIImageView * lastimageView;
@end

@implementation RCSearchListViewController
{
    NSArray * _btnAry;
    NSArray * _area0Ary;
    NSMutableArray * _area1Ary;
    NSArray * _priceAry;
    

    NSString * _btnType;
    NSString * _lastbtnType;
    
    NSString * _attri;//记录更多里面的需求类型
    NSString * _area0;//记录更多里面面积下限
    NSString * _area1;//记录更多里面面积上限
    
    BOOL _isHidden;//是否展示
    NSMutableArray * _homesModelAry;
    
    NSDictionary * _nickname_city;
    NSDictionary * _attributesDict;
    
    NSUserDefaults * ud;
    
    MJRefreshFooterView * _footerView;
    MJRefreshHeaderView * _headerView;

    NSIndexPath * selectindexPath;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _viewVIew.layer.shadowColor=[UIColor grayColor].CGColor;
    _viewVIew.layer.shadowOffset=CGSizeMake(3,3);
    _viewVIew.layer.shadowOpacity=0.50;
    _viewVIew.layer.shadowRadius=4;
    
    [self allinit];
    [self tableViewInit];
    [self creatData];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)BackBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark------------------------初始化-----------------------


-(void)allinit{
    _isHidden = YES;
    
    _titleLab.text =_mytitle;
    _titleLab1.text = _titleLab.text;
    
    ud = [NSUserDefaults standardUserDefaults];
    self.title = @"房源列表";
    // 把返回文字的标题设置为空字符->下一级
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    _btnAry     = @[_fromLowToHighBtn,_fromHighToLowBtn,_NewProductsBtn];
    _area0Ary   = @[@"不限",@"洛杉矶",@"旧金山",@"圣地亚哥",@"西雅图"];
    _nickname_city = @{@"洛杉矶":@"LA",@"旧金山":@"SF",@"圣地亚哥":@"SD",@"西雅图":@"SEA"};
    _area1Ary   = [[NSMutableArray alloc]init];
    _priceAry   = @[@"不限",@"50万美元以下",@"50-100万美元",@"100-200万美元",@"200-500万美元",@"500万美元以上"];
    _attributesDict = @{@"":@"",@"1":@"投资房",@"2":@"学区房",@"4":@"豪宅"};
    
    _rightBarButton.selected= NO;
    _homesModelAry =[[NSMutableArray alloc]init];
    //给黑底添加手势
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showViewClick)];
    [_bgShowView addGestureRecognizer:tapGestureRecognizer];
    //参数初始化
    if (_attributes ==nil) {
        _attributes = @"";
        _cityname = _mytitle;
    }else{
        _cityname = @"";
    }
    if (_metro_area == nil) {
        _metro_area = @"";
    }
    if (_city == nil) {
        _city   =   @"";
    }
    _room       =   @"";
    _bath       =   @"";
    _area_from  =   @"";
    _area_to    =   @"";
    _area_unit  =   @"";
    _type       =   @"";
    _price_low  =   @"";
    _price_high =   @"";
    _currency   =   @"";
    _sort_field =   @"";
    _sort       =   @"";
   
    _page       =   1;
    _pagesize   =   @"10";
    _require_total = @"true";
}

#pragma mark--------------------------------Appear------------------------------


- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
     self.navigationController.navigationBar.hidden=YES;
   
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   
}
- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden=NO;
    [SVProgressHUD dismiss];
}



#pragma mark-----------------------------------请求数据----------------------


-(void)creatData{
    [SVProgressHUD show];
    if (_page==1) {
       [_homesModelAry removeAllObjects];
        _require_total = @"true";
    }
    NSString * urlstring;
    if (_keyword==nil ||[_keyword isEqualToString:@"null"]) {
//        请求参数
//        1,pagesize
//        2,page
//        3,require_total  是否要返回房源数量
//        4,metro_area  都市圈
//        5,city 城市（优先级>4）
//        6,type
//        7,attributes 房源属性
//        8,area_form 面积上限
//        9,area_form 面积下限
//        10,room卧室
//        11,bath浴室
//        12,排序字段 sort_field
//        13,排序类型 sort  asc=升序，desc = 降序
//        14,价格上限
//        15,价格下限
        urlstring = [NSString stringWithFormat:@"%@?pagesize=%@&page=%ld&require_total=%@&metro_area=%@&city=%@&type=%@&attributes=%@&area_from=%@&area_to=%@&room=%@&bath=%@&sort_field=%@&sort=%@&price_low=%@&price_high=%@&access_token=%@",KAPIHome_search,_pagesize,(long)_page,_require_total,_metro_area,_city,_type,_attributes,_area_from,_area_to,_room,_bath,_sort_field,_sort,_price_low,_price_high,[ud valueForKey:KKEYAccess_token]];
    }
    else{
//        请求参数
       
        
         urlstring = [NSString stringWithFormat:@"%@?pagesize=%@&page=%ld&keyword=%@&require_total=%@&keyword_type=city",KAPIHome_search,_pagesize,(long)_page,_keyword,_require_total];
        _keyword = nil;
    }
    
    urlstring= [urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSLog(@"%@",urlstring);
    [RCGETRequest requestWithUrl:urlstring Complete:^(NSData *data) {
        //返回数据
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:NULL];
        [SVProgressHUD dismiss];
//        NSLog(@"房源列表--JSON: %@",dict);
        if ([_require_total isEqualToString:@"true"]) {
           
            NSString * total = [NSString stringWithFormat:@"%@",dict[@"total"] ];
            if ([total isEqualToString:@"0"]||[total isEqualToString:@"(null)"]) {
                _titleLab.text = [NSString stringWithFormat:@"%@(暂无数据)",_mytitle];
                _titleLab1.text = _titleLab.text;
                _bgdeImageView.hidden = NO;
                
            }else{
                _titleLab.text = [NSString stringWithFormat:@"%@(%@套)",_mytitle,total];
                _bgdeImageView.hidden = YES;
            }
            _titleLab1.text = _titleLab.text;
//            9.20
//            _require_total = @"false";
        }

        NSArray * ary =dict[@"homes"];
        if (ary.count==0) {
//           显示无数据
            [RCAlertView showMessage:@"暂无数据"];
        }else{
        for (int i = 0; i<ary.count; i++) {
            RCHomesModel * model  =[[RCHomesModel alloc]initWithDictionary:ary[i] error:nil];
            
          
            [_homesModelAry addObject:model];
        }
        }
        
        //关闭刷新
        
        [_headerView endRefreshing];
        [_footerView endRefreshing];
        
        [self.tableView reloadData];
        
    } faile:^(NSError *error) {
//        NSLog(@"搜索error%@",error);
//        NSLog(@"%@",error.userInfo[@"NSLocalizedDescription"]);
        [SVProgressHUD dismiss];
        [RCAlertView showMessage:error.userInfo[@"NSLocalizedDescription"]];
    }];
}

//根据城市得到二级城市
-(void)list_citys:(NSString *)city{
    
    [RCGETRequest requestWithUrl:[NSString stringWithFormat:@"%@=%@",KAPIList_cities,city] Complete:^(NSData *data) {
        //返回数据
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:NULL];
//        NSLog(@"二级城市--JSON: %@",dict);
        _area1Ary =[NSMutableArray arrayWithArray:dict[@"cities"]];
        [_areaTableView1 reloadData];
        
    } faile:^(NSError *error) {
//        NSLog(@"搜索error%@",error);
    }];
}

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (refreshView==_headerView) {
        //下拉刷新
        _page = 1;
        [self creatData];
       
    }
    if(refreshView ==_footerView)
    {
        //上拉加载
        
        _page++;//请求下一页
        [self creatData];
    }
}
#pragma  mark----------------------------筛选条件btn--------------------------------
#pragma mark--------------------------------更多搜索条件外部--------------------------------


//更多搜索条件
- (IBAction)searchConditionBtn:(id)sender {
    if ([_attributes isEqualToString:@"1"]) {
        _InvestmentPropertyBtn.selected = YES;
        _attri = @"1";
        
    }else if ([_attributes isEqualToString:@"2"]) {
        _schoolDistrictBtn.selected     = YES;
        _attri = @"2";
    }else if ([_attributes isEqualToString:@"4"]) {
        _luxuryRealEstateBtn.selected   = YES;
        _attri = @"4";
    }else
    {
        _attri = @"";
    }
    
    _areaTableView0.hidden  = YES;
    _areaTableView1.hidden = YES;
    _otherTableView.hidden  = YES;
    _typeView.hidden = YES;
    _moreSearchVIew.hidden = NO;
    
    
    _btnType=@"更多";
    [self showViewHidden:_moreArrow namelabel:_moreLab];
    
}
- (IBAction)areaBtn:(id)sender {
    //    _areaBtn.selected = !_areaBtn.selected;
    _areaTableView0.hidden  = NO;
    _areaTableView1.hidden = NO;
    _otherTableView.hidden  = YES;
    _typeView.hidden = YES;
    _moreSearchVIew.hidden = YES;
    
    _btnType = @"区域";
    [self showViewHidden:_areaArrow namelabel:_areaLab];
}
- (IBAction)priceBtn:(id)sender {
    _areaTableView0.hidden  = YES;
    _areaTableView1.hidden  = YES;
    _otherTableView.hidden  = NO;
    _typeView.hidden = YES;
    _moreSearchVIew.hidden = YES;
    
    _btnType = @"价格";
    [self showViewHidden:_priceArrow namelabel:_priceLab];
}
- (IBAction)floorageBtn:(id)sender {
    _areaTableView0.hidden  = YES;
    _areaTableView1.hidden  = YES;
    _otherTableView.hidden  = YES;
    _typeView.hidden = NO;
    _moreSearchVIew.hidden = YES;
    
    
    _btnType = @"类型";
    
    [self showViewHidden:_floorageArrow namelabel:_floorageLab];
}

-(void)showViewHidden:(UIImageView *)arrowImageView namelabel:(UILabel *)namelabel{
    if (_isHidden) {
//        //如果是隐藏的，就让它展示，当前区域点亮换图
        _isHidden=NO;
        [self animationWithDurationViewAlpha:1];
        
        arrowImageView.image = [UIImage imageNamed:@"箭头2"];
        namelabel.textColor = KTextColor;
    }
    else if([_btnType isEqualToString:_lastbtnType]){
        //如果是显示的，并且还是点击的当前区域，就让其隐藏
        _isHidden=YES;
        [self animationWithDurationViewAlpha:0];
        
        if ([namelabel.text isEqualToString:@"区域"]) {
             namelabel.textColor = [UIColor darkGrayColor];
            _areaTableView0.hidden = YES;
            _areaTableView1.hidden = YES;
        }else if ([namelabel.text isEqualToString:@"价格"]){
             namelabel.textColor = [UIColor darkGrayColor];
            _otherTableView.hidden = YES;
        }else if([namelabel.text isEqualToString:@"类型"]){
             namelabel.textColor = [UIColor darkGrayColor];
            _typeView.hidden = YES;
        }
        else if([namelabel.text isEqualToString:@"更多"]){
            namelabel.textColor = [UIColor darkGrayColor];
            _moreSearchVIew.hidden = YES;
        }
        arrowImageView.image = [UIImage imageNamed:@"箭头"];
    }
    else{
        //如果是显示的，但是换了点击区域，就让上一个恢复初始状态，并且让最新点亮换图
        if ([_lastlable.text isEqualToString:@"区域"]||[_lastlable.text isEqualToString:@"价格"]||[_lastlable.text isEqualToString:@"类型"]||[_lastlable.text isEqualToString:@"更多"]) {
            _lastlable.textColor = [UIColor darkGrayColor];
        }
        _lastimageView.image = [UIImage imageNamed:@"箭头"];
        arrowImageView.image = [UIImage imageNamed:@"箭头2"];
        namelabel.textColor = KTextColor;
    }
    _lastbtnType = _btnType;
    _lastimageView = arrowImageView;
    _lastlable = namelabel;
}

-(void)showViewClick{
 
    _areaTableView0.hidden  = YES;
    _areaTableView1.hidden  = YES;
    _otherTableView.hidden  = YES;
    _typeView.hidden = YES;
    [self showViewHidden:_lastimageView namelabel:_lastlable];
    //    if ([_areaLab.text isEqualToString:@"区域"] || [_priceLab.text isEqualToString:@"价格"] || [_floorageLab.text isEqualToString:@"房型"] ) {
    //        _lastlable.textColor = [UIColor darkGrayColor];
    //    }
    //    _lastimageView.image = [UIImage imageNamed:@"箭头"];
    //   sortView
    
    if (_rightBarButton.selected) {
//        [UIView animateWithDuration:kAnimationDuration animations:^{
//            _rightBarButton.transform=CGAffineTransformRotate(_rightBarButton.transform, M_PI);
//        }];
        _rightBarButton.selected = NO;
        [self animationWithDurationViewAlpha:0];
        [self SortingViewAnimationsHidden:YES];
    }
    
}
- (IBAction)typeSelectBtn:(id)sender {
    UIButton * btn = sender;
    btn.selected = !btn.selected;
    
    if ([sender isEqual:_duDongBtn]&&btn.selected) {
        
        _floorageLab.text = @"独栋别墅";
        _lianPaiBtn.selected = NO;
        _gongYuBtn.selected = NO;
//                房源类型
        _type = @"H";
//                参数  page=1;
        _page = 1;
         [self creatData];
    }else if([sender isEqual:_lianPaiBtn]&&btn.selected){
        _floorageLab.text = @"联排别墅";
        _duDongBtn.selected = NO;
        _gongYuBtn.selected = NO;
//                房源类型
        _type = @"T";
//                参数  page=1;
        _page = 1;
        [self creatData];
    }else if ([sender isEqual:_gongYuBtn]&&btn.selected){
        _floorageLab.text = @"公寓";
        _duDongBtn.selected = NO;
        _lianPaiBtn.selected = NO;
//                房源类型
        _type = @"A";
//                参数  page=1;
        _page = 1;
         [self creatData];
    }else{
        _floorageLab.text = @"类型";
        _floorageLab.textColor = [UIColor darkGrayColor];
//                房源类型
        _type = @"";
//                参数  page=1;
        _page = 1;
         [self creatData];
    }
    _floorageArrow.image = [UIImage imageNamed:@"箭头"];
     _typeView.hidden = YES;
    
    
    _isHidden = YES;
    [self animationWithDurationViewAlpha:0];
   
}
#pragma mark--------------------------------筛选条件排序--------------------------------


- (IBAction)rightBarButton:(id)sender {
    _rightBarButton.selected = !_rightBarButton.selected;
    
    
    
    if (_rightBarButton.selected) {
        [self SortingViewAnimationsHidden:NO];
        _isHidden=NO;
        [self animationWithDurationViewAlpha:1];
        
        
        _areaTableView0.hidden  = YES;
        _areaTableView1.hidden  = YES;
        _otherTableView.hidden  = YES;
        _typeView.hidden = YES;
        _moreSearchVIew.hidden = YES;
        
        if ([_lastlable.text isEqualToString:@"区域"] || [_lastlable.text isEqualToString:@"价格"] || [_lastlable.text isEqualToString:@"类型"]|| [_lastlable.text isEqualToString:@"更多"]) {
            _lastlable.textColor = [UIColor darkGrayColor];
        }
        _lastimageView.image = [UIImage imageNamed:@"箭头"];
    }
    else
    {
        [self SortingViewAnimationsHidden:YES];
        _isHidden=YES;
         [self animationWithDurationViewAlpha:0];
        
    }

}
- (IBAction)AboutSortBtn:(id)sender {
    for (int i = 0;i<_btnAry.count;i++) {
        UIButton * btn = _btnAry[i];
        if ([btn isEqual:sender]) {
            btn.selected = YES;
            if (i==0) {
//价格升序
                _sort_field = @"price";
                _sort = @"asc";
            }else if(i==1)
            {
//价格降序
                _sort_field = @"price";
                _sort = @"desc";
            }else if(i==2){
//时间
                _sort_field = @"id";
                _sort = @"desc";
            }
//    参数
            _page = 1;
//    请求
            [self creatData];
        }else
        {
            btn.selected = NO;
        }
    }
    [self SortingViewAnimationsHidden:YES];
    _rightBarButton.selected = NO;
    _isHidden=YES;
     [self animationWithDurationViewAlpha:0];
//    
//    [UIView animateWithDuration:kAnimationDuration animations:^{
//        _rightBarButton.transform=CGAffineTransformRotate(_rightBarButton.transform, M_PI);
//    }];
}
 - (void)SortingViewAnimationsHidden:(BOOL)YON{
    float  originY;
    if (YON) {
        originY = -_SortingView.frame.size.height;
    }else
    {
        originY = _navView.frame.size.height;
    }
    //设置动画
    [UIView beginAnimations:nil context:nil];
    
    //定义动画时间
    [UIView setAnimationDuration:kAnimationDuration];
    //设置view的frame，往下平移
    [_SortingView setFrame:CGRectMake(_SortingView.frame.origin.x,originY, _SortingView.frame.size.width,_SortingView.frame.size.height)];
    [UIView commitAnimations];
//    NSLog(@"%f",-M_1_PI);
    if (!YON) {
        [UIView animateWithDuration:kAnimationDuration animations:^{
            _rightBarButton.transform=CGAffineTransformRotate(_rightBarButton.transform,179.99*M_PI/180);
           
        }];
    }else
    {
        [UIView animateWithDuration:kAnimationDuration animations:^{
            _rightBarButton.transform=CGAffineTransformRotate(_rightBarButton.transform, -179.99*M_PI/180.0);
            
        }];
    }
}



////筛选view缩回动画
//- (void)moreSearchViewAnimations{
//    
//    //设置动画
//    [UIView beginAnimations:nil context:nil];
//    
//    //定义动画时间
//    [UIView setAnimationDuration:kAnimationDuration];
//    [UIView setAnimationDelegate:self];
//
//    
//    _isHidden=YES;
//     [self animationWithDurationViewAlpha:0];
//    
//    self.moreSearchVIew.transform=CGAffineTransformMakeTranslation(0,0);
//    [UIView commitAnimations];
//    
//}
// 动画 showView
-(void)animationWithDurationViewAlpha:(CGFloat)alpha{
    
    [UIView animateWithDuration:kAnimationDuration animations:^{
        _showView.alpha = alpha;
        
    }];
}
#pragma mark--------------------------------更多搜索条件内部----------------------------------
//重置
- (IBAction)_rightBarButton1:(id)sender {
    [self setnull];
}
//取消
- (IBAction)cancelBtn:(id)sender {
//    [self moreSearchViewAnimations];
}
-(void)setnull{
    //所有条件初始化
    _schoolDistrictBtn.selected     = NO;
    _luxuryRealEstateBtn.selected   = NO;
    _InvestmentPropertyBtn.selected = NO;
    
    _area111Btn.selected            = NO;
    _area000Btn.selected            = NO;
    _area222Btn.selected            = NO;
    
    _bathroomLab.text = @"浴室";
    _bathroomLab.textColor =[UIColor darkGrayColor];
    _bedroomLab.text =@"卧室";
    _bedroomLab.textColor =[UIColor darkGrayColor];
    //  保留值置空
    _attri = @"";
    _area0 = @"";
    _area1 = @"";

}
//搜索
- (IBAction)searchBtn:(id)sender {
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
//    NSLog(@"%@",NSStringFromCGRect(_moreSearchVIew.frame));
//    [self moreSearchViewAnimations];
    
//参数
    _attributes = _attri;
    _area_from = _area0;
    _area_to = _area1;
    if ([_bathroomLab.text isEqualToString:@"浴室"]) {
        _bath = @"";
    }else{
        _bath = [_bathroomLab.text substringToIndex:1];
    }
//    NSLog(@"bath:    %@",_bath);
    if ([_bedroomLab.text isEqualToString:@"卧室"]) {
        _room = @"";
    }else{
        _room = [_bedroomLab.text substringToIndex:1];
    }
//    NSLog(@"room:    %@",_room);
    
//       title
    if ([_areaLab.text isEqualToString:@"区域"]) {
        _mytitle =[NSString stringWithFormat:@"%@%@",_cityname,_attributesDict[_attributes]];
    }else
    {
         _mytitle =[NSString stringWithFormat:@"%@%@",_areaLab.text,_attributesDict[_attributes]];
    }
//    参数
    _page = 1;
//    请求
    [self creatData];
    
//    处理隐藏。。。。
    _moreArrow.image = [UIImage imageNamed:@"箭头"];
    _moreLab .textColor = [UIColor darkGrayColor];
    _moreSearchVIew.hidden = YES;
    _isHidden = YES;
    
    [self animationWithDurationViewAlpha:0];
}
//需求类型
- (IBAction)RequirementTypeBtn:(id)sender {
    UIButton * btn =sender;
    btn.selected = !btn.selected;
    if (!btn.selected) {
//        NSLog(@"取消选中的房源属性");
        _attri = @"";
    }
    else{
    if ([btn isEqual:_InvestmentPropertyBtn]) {
        _schoolDistrictBtn.selected     = NO;
        _luxuryRealEstateBtn.selected   = NO;
//            NSLog(@"现在选中的是：投资房");
            _attri = @"1";
        
    }else if([btn isEqual:_schoolDistrictBtn]){
        _InvestmentPropertyBtn.selected = NO;
        _luxuryRealEstateBtn.selected   = NO;
//            NSLog(@"现在选中的是：学区房");
            _attri = @"2";
        
    }else
    {
        _InvestmentPropertyBtn.selected = NO;
        _schoolDistrictBtn.selected     = NO;
//            NSLog(@"现在选中的是：豪宅");
            _attri = @"4";
    }
    }
}
//房屋类型->面积
- (IBAction)houseType:(id)sender {
    UIButton * btn =sender;
    btn.selected = !btn.selected;
    if (!btn.selected) {
//        NSLog(@"取消选中的房源属性");
        _area1 = @"";
        _area0 =@"";
    }
    else
    {
    if ([btn isEqual:_area000Btn]) {
        _area111Btn.selected     = NO;
        _area222Btn.selected   = NO;
//        NSLog(@"现在选中的是：150以下");
        _area1 = [NSString stringWithFormat:@"%.f",150*10.7639104];
        _area0 = [NSString stringWithFormat:@"%.f",1*10.7639104];
        
    }else if([btn isEqual:_area111Btn]){
        _area000Btn.selected = NO;
        _area222Btn.selected   = NO;
//        NSLog(@"现在选中的是：150-300");
        _area0 = [NSString stringWithFormat:@"%.f",150*10.7639104];
        _area1 = [NSString stringWithFormat:@"%.f",300*10.7639104];
    }else
    {
        _area000Btn.selected = NO;
        _area111Btn.selected     = NO;
//        NSLog(@"现在选中的是：300以上");
        _area0 = [NSString stringWithFormat:@"%.f",300*10.7639104];
        _area1 = @"";
    }
    }
}
//卧室增加/减少
- (IBAction)bedroomBtn:(id)sender {
    UIButton * btn = sender;
    NSString * str = [_bedroomLab.text substringToIndex:1];
    if ([str isEqualToString:@"卧室"]) {
        str = @"0";
    }else{
        _bedroomLab.textColor =[UIColor colorWithRed:0 green:122/255.0 blue:255/255.0 alpha:1];
    }
    int bedroomNum = [str intValue];
    if ([btn.titleLabel.text isEqualToString:@"-"]) {
        if (bedroomNum>1) {
            bedroomNum--;
        }
        else
        {
            _bedroomLab.text = @"卧室";
            _bedroomLab.textColor =[UIColor darkGrayColor];
            return;
        }
    }
    else
    {
        if (bedroomNum<9) {
            bedroomNum++;
        }
        else
        {
            _bedroomLab.text = @"卧室";
            _bedroomLab.textColor =[UIColor darkGrayColor];
            return;
        }
    }
    NSString * text =[NSString stringWithFormat:@"%d间卧室",bedroomNum];
    _bedroomLab.text = text;
    
}
//浴室增加/减少
- (IBAction)bathroomBtn:(id)sender {
    UIButton * btn = sender;
    NSString * str = [_bathroomLab.text substringToIndex:1];
    if ([str isEqualToString:@"浴室"]) {
        str = @"0";
    }else{
        _bathroomLab.textColor =[UIColor colorWithRed:0 green:122/255.0 blue:255/255.0 alpha:1];
    }
    int bathroomNum = [str intValue];
    if ([btn.titleLabel.text isEqualToString:@"-"]) {
        if (bathroomNum>1) {
            bathroomNum--;
        }
        else
        {
            _bathroomLab.text = @"浴室";
            _bathroomLab.textColor =[UIColor darkGrayColor];
            return;
        }
    }
    else
    {
        if (bathroomNum<9) {
            bathroomNum++;
        }
        else
        {
            _bathroomLab.text = @"浴室";
            _bathroomLab.textColor =[UIColor darkGrayColor];
            return;
        }
    }
        _bathroomLab.text = [NSString stringWithFormat:@"%d间浴室",bathroomNum];
}
#pragma mark--------------------------------tableView-------------------------------
#pragma ----------tableview-----------------
- (void)tableViewInit{
    _areaTableView0.delegate    = self;
    _areaTableView0.dataSource  = self;
    
    _areaTableView1.delegate    = self;
    _areaTableView1.dataSource  = self;
    
    _otherTableView.delegate    = self;
    _otherTableView.dataSource  = self;
    
    _tableView.delegate         = self;
    _tableView.dataSource       = self;
    _tableView.rowHeight        = 320*kScreeWidth/375;
//    _tableView.rowHeight = UITableViewAutomaticDimension;
//    _tableView.estimatedRowHeight = 500;
    //1.添加头部
    _headerView =[MJRefreshHeaderView header];
    
    //2.添加尾部控件的方法
    _footerView =[MJRefreshFooterView footer];
    
    //3.监听刷新控件
    //设置代理
    _headerView.delegate=self;
    _footerView.delegate =self;
    _headerView.scrollView=_tableView;
    _footerView.scrollView=_tableView;
    
    //去掉留白
    self.automaticallyAdjustsScrollViewInsets=NO;
    UINib * nib=[UINib nibWithNibName:Identifier bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:Identifier];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:_areaTableView0]) {
        return _area0Ary.count;
    }
    else if([tableView isEqual:_areaTableView1]){
        return _area1Ary.count;
    }
    else if([tableView isEqual:_otherTableView]){
          return _priceAry.count;
    }
    
    return _homesModelAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{   UITableViewCell *cell;
    if ([tableView isEqual:_areaTableView0]) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"_areaTableView0"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"_areaTableView0"];
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.text=_area0Ary[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.textLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        return cell;
    }
    else if([tableView isEqual:_areaTableView1]){
        cell = [tableView dequeueReusableCellWithIdentifier:@"_areaTableView1"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"_areaTableView1"];
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        cell.textLabel.text=[NSString stringWithFormat:@"%@,%@", _area1Ary[indexPath.row][0], _area1Ary[indexPath.row][1]];
        
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.textLabel.minimumScaleFactor = 0.1;
        cell.textLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        return cell;
    }
    else if([tableView isEqual:_otherTableView]){
      
            cell = [tableView dequeueReusableCellWithIdentifier:@"_priceAry"];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"_priceAry"];
            }
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.text=_priceAry[indexPath.row];
            cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.textLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        return cell;
    }
    
//-----------RCHouseTableViewCell-----------------------------------
    RCHouseTableViewCell * housecell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
    RCHomesModel * homesmodel;
    if(indexPath.row<_homesModelAry.count)
    {
        homesmodel = _homesModelAry[indexPath.row];
    }
    
//收藏、建筑面积、建于年、价格、图片、名字
//收藏
//    housecell.favLab.text =[NSString stringWithFormat:@"%@人收藏",homesmodel.favors];
//建筑面积
//    if ([homesmodel.space_area isEqualToString:@"0"]||homesmodel.space_area==nil) {
//        housecell.flool_areaLab.text = [NSString stringWithFormat:@"建筑%.f㎡",[homesmodel.floor_area intValue]/10.7639104];
//    }else{
//        housecell.flool_areaLab.text = [NSString stringWithFormat:@"建筑%.f㎡,占地%.f㎡",[homesmodel.floor_area intValue]/10.7639104,[homesmodel.space_area intValue]/10.7639104];
//    }
    housecell.flool_areaLab.text = [NSString stringWithFormat:@"%@室 丨 %d卫 丨 %.f㎡",homesmodel.bedrooms,[homesmodel.full_baths intValue]+[homesmodel.partial_baths intValue],[homesmodel.floor_area intValue]/10.7639104];
    
//建筑年
    housecell.built_yearLab.text = [NSString stringWithFormat:@"建于%@年",homesmodel.built_year];
//价格-美元
//    NSString * rate = [ud valueForKey:KKEYExchange];
//    NSLog(@"%d,%.4f,%.f",[homesmodel.price intValue],[rate floatValue],(int)[homesmodel.price intValue]*[rate floatValue]/10000);
   
    housecell.priceLab.text = [NSString stringWithFormat:@"$ %@",[RCUtils ChangeNumberFormat:homesmodel.price]];
////    一个返回富文本的方法，用来让lable 显示字体大小不一样
//    [housecell.priceLab setAttributedText:[self changeLabelWithText:housecell.priceLab.text]];
    
//图片七牛
//    NSString * imageUrl = [NSString stringWithFormat:@"%@%@?imageView2/2/w/%d",KAPIQINIU,homesmodel.preview,(int)housecell.houseImage.frame.size.width];
//    @"%@%@?imageMogr2/thumbnail/%.f/strip/quality/60"
    NSString * imageUrl = [NSString stringWithFormat:@"%@%@?imageMogr2/thumbnail/%.f",KAPIQINIU,homesmodel.preview,kScreeWidth*1.5];
//    NSLog(@"\n\t\t imageUrl:%@",imageUrl);
    [housecell.houseImage sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"房源列表过渡"]];
//名字
    NSString * housetype;
    if ([homesmodel.type isEqualToString:@"A"]) {
        housetype = @"公寓";
    }else if ([homesmodel.type isEqualToString:@"H"]){
        housetype = @"独栋别墅";
    }else if ([homesmodel.type isEqualToString:@"T"]){
        housetype = @"联排别墅";
    }else{
        housetype = @"";
    }
    housecell.houseNameLab.text = housetype;
   
    
//    NSLog(@"%@",homesmodel.is_my_favor);
    //判断  是否是收藏
    if ([homesmodel.is_my_favor isEqualToString:@"0"]||homesmodel.is_my_favor ==nil) {
        housecell.IsMyFavorBtn.selected = NO;
    }else{
        housecell.IsMyFavorBtn.selected = YES;
    }
   
  
    __weak typeof(housecell) weakCell = housecell;
    housecell.favBlock=^(BOOL selected) {
        /*函数回调 当block执行时就会回到这里*/
//        NSLog(@"点一下收藏");
#pragma mark----------------收藏----------------
        //    1、判断是否登陆
        //    2、未登录-登陆
        //    3、判断selected----->yes: 移除，---no:收藏
        //    3、  请求
        //    4、   改变selected
        
        //    1、判断是否登陆
        if ([[ud valueForKey:KKEYLogin_successORdefeat]isEqualToString:KKEYLogin_success]) {
            //        已登录登陆
            //    3、判断selected----->yes: 移除，---no:收藏
            
            NSString * collectstate;
            if (weakCell.IsMyFavorBtn.selected) {
                //            已收藏，移除
                collectstate =  [NSString stringWithFormat:@"%@?home_id=%@&access_token=%@",KAPIFAVOER_romeve_home,homesmodel.id,[ud valueForKey:KKEYAccess_token]];
            }else{
                //            未收藏，收藏
                collectstate =  [NSString stringWithFormat:@"%@?home_id=%@&access_token=%@",KAPIFAVOR_add_home,homesmodel.id,[ud valueForKey:KKEYAccess_token]];
            }
            [RCGETRequest requestWithUrl:collectstate Complete:^(NSData *data) {
                //返回数据
                NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:NULL];
                //            NSLog(@"收藏或移除收藏：\n\n%@\n\n",dict);
                if (dict[@"success"]) {
                    if (weakCell.IsMyFavorBtn.selected) {
                        //                    NSLog(@"移除收藏--JSON: %@",dict);
                       weakCell.IsMyFavorBtn.selected =NO;
                       
                        homesmodel.is_my_favor = @"0";
                    }else
                    {
                        //                    NSLog(@"添加为收藏房源--JSON: %@",dict);
                        weakCell.IsMyFavorBtn.selected =YES;
                        homesmodel.is_my_favor = @"1";
                    }
                    
                }
                else{
                    [RCAlertView showMessage:@"操作失败"];
                }
                //刷新cell
                [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
                
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
        

#pragma mark-------------收藏-------------------
    };

    return housecell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_areaTableView0]) {
        _areaTableView1.hidden  = NO;
//            city参数
        _city = @"";

        if (indexPath.row == 0) {
            _areaTableView1.hidden  = YES;
            _isHidden = YES;
             [self animationWithDurationViewAlpha:0];
            
            _areaTableView0.hidden  = YES;
            _areaLab.text = @"区域";
            _areaLab.textColor = [UIColor darkGrayColor];
            _areaArrow.image = [UIImage imageNamed:@"箭头"];
            [_area1Ary removeAllObjects];
            [_areaTableView1 reloadData];
//            都市圈参数
            _metro_area =@"";
            
             _mytitle =[NSString stringWithFormat:@"%@",_attributesDict[_attributes]];
        }

        else
        {
            [self list_citys:_nickname_city[_area0Ary[indexPath.row]]];
//            都市圈参数
            _metro_area =_nickname_city[_area0Ary[indexPath.row]];

//            title
            _mytitle =[NSString stringWithFormat:@"%@%@",_area0Ary[indexPath.row],_attributesDict[_attributes]];
            
            _areaLab.text = _area0Ary[indexPath.row];
        }
//        参数  page=1;
        _page = 1;
        [self creatData];
    }
    else if([tableView isEqual:_areaTableView1]){
        //如果没有中文名，则显示英文名
            if ([_area1Ary[indexPath.row][1]isEqualToString:@""]) {
                _areaLab.text=_area1Ary[indexPath.row][0];
            }else
            {
                _areaLab.text=_area1Ary[indexPath.row][1];
            }
        _isHidden = YES;
         [self animationWithDurationViewAlpha:0];
        
        _areaTableView0.hidden  = YES;
        _areaTableView1.hidden = YES;
         _areaArrow.image = [UIImage imageNamed:@"箭头"];
        
//       title
        _mytitle =[NSString stringWithFormat:@"%@%@",_areaLab.text,_attributesDict[_attributes]];
//      city参数
        _city = _area1Ary[indexPath.row][0];
//      参数  page=1;
        _page = 1;
        [self creatData];
        
    }
    else if([tableView isEqual:_otherTableView]){
//         NSString * rate = [ud valueForKey:KKEYExchange];
            if(indexPath.row != 0){
                _priceLab.text = _priceAry[indexPath.row];
            }
        switch (indexPath.row) {
//                [rate floatValue]
           case 0:{
                _priceLab.text = @"价格";
                _priceLab.textColor = [UIColor darkGrayColor];
               _price_high = @"";
               _price_low = @"";
                    }
                        break;
            case 1:{
                _price_low = @"0";
                _price_high = [NSString stringWithFormat:@"%d",(int)50];
            }
                break;
            case 2:{
                _price_low = [NSString stringWithFormat:@"%d",(int)50];
                _price_high = [NSString stringWithFormat:@"%d",(int)100];
            }
                break;
            case 3:{
                _price_low =[NSString stringWithFormat:@"%d",(int)100];
                _price_high = [NSString stringWithFormat:@"%d",(int)200];
            }break;
            case 4:{
                _price_low = [NSString stringWithFormat:@"%d",(int)200];
                _price_high = [NSString stringWithFormat:@"%d",(int)500];
                }
                break;
            case 5:{
                _price_low = [NSString stringWithFormat:@"%d",(int)500];
                _price_high = @"price_range_max";
                
            }
                break;
            
            default:
                break;
                }
//      参数  page=1;
        _page = 1;
        [self creatData];
        _isHidden = YES;
         [self animationWithDurationViewAlpha:0];
        
        _otherTableView.hidden  = YES;
        _priceArrow.image = [UIImage imageNamed:@"箭头"];
    }
    else{
       
        if(indexPath.row<_homesModelAry.count)
        {
            RCHomesModel * homesmodel = _homesModelAry[indexPath.row];
            
            RCHousinginformationViewController * houseInfo =[[RCHousinginformationViewController alloc]init];
            
        
            
            
            houseInfo.favBlock1 = ^(BOOL selected1){
                if (selected1) {
                    homesmodel.is_my_favor = @"1";
                }else{
                     homesmodel.is_my_favor = @"0";
                }
                
                
                [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
            };
            
            
            
            houseInfo.houseId       = homesmodel.id;
            houseInfo.mls           = homesmodel.mls;
            houseInfo.city          = homesmodel.city;
//            //名字
//            NSString * housetype;
//            if ([homesmodel.type isEqualToString:@"A"]) {
//                housetype = @"公寓";
//            }else if ([homesmodel.type isEqualToString:@"H"]){
//                housetype = @"独栋别墅";
//            }else if ([homesmodel.type isEqualToString:@"T"]){
//                housetype = @"联排别墅";
//            }else{
//                housetype = @"房子";
//            }
////
//            /**
//             *房源属性。
//             0 = 不具备以下任何属性。注意：不等于不限属性
//             1 = 投资房
//             2 = 学区房
//             4 = 豪宅
//             3 = 投资房 + 学区房
//             5 = 投资房 + 豪宅
//             6 = 学区房 + 豪宅
//             7 = 投资房 + 学区房 + 豪宅
//             */
//            NSString * house_attributes;
//            switch ([homesmodel.attributes intValue]) {
//                    
//                case 0:
//                    house_attributes = @"";
//                    break;
//                case 1:
//                    house_attributes = @"投资房";
//                     break;
//                case 2:
//                    house_attributes = @"学区房";
//                     break;
//                case 3:
//                    house_attributes = @"豪宅";
//                     break;
//                case 4:
//                    house_attributes = @"投资房+学区房";
//                     break;
//                case 5:
//                    house_attributes = @"投资房+豪宅";
//                     break;
//                case 6:
//                    house_attributes = @"学区房+豪宅";
//                     break;
//                case 7:
//                    house_attributes = @"投资房+学区房+豪宅";
//                     break;
//                default:
//                    break;
//            }
//
//            
//            NSString * rate = [ud valueForKey:KKEYExchange];
//            
           
            [self.navigationController pushViewController:houseInfo animated:YES];
        }
    }
}

//创建一个返回富文本的方法，用来让lable 显示字体大小不一样

-(NSMutableAttributedString*) changeLabelWithText:(NSString*)needText
{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:needText];
    UIFont *font = [UIFont systemFontOfSize:12];
    [attrString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0,1)];
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(needText.length-1,1)];
    
    return attrString;
}
- (void)dealloc
{
    NSLog(@"\n\t\n\t\n\t searchList 释放了\n\t\n\t\n\t");
    [_headerView free];
    [_footerView free];
}

@end
