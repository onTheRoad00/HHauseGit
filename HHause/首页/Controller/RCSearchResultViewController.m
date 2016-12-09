//
//  RCSearchResultViewController.m
//  HHause
//
//  Created by HHause on 16/5/13.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "RCSearchResultViewController.h"
#import "RCHouseTableViewCell.h"
#import "RCHousinginformationViewController.h"
#import "RCHousePurchasingTableViewCell.h"

#define Identifier @"RCHouseTableViewCell"

@interface RCSearchResultViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *infoTableVIew;
- (IBAction)schoolDistrictBtn:(id)sender;
- (IBAction)InvestmentPropertyBtn:(id)sender;
- (IBAction)luxuryRealEstateBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *schoolDistrictBtn;
@property (weak, nonatomic) IBOutlet UIButton *InvestmentPropertyBtn;
@property (weak, nonatomic) IBOutlet UIButton *luxuryRealEstateBtn;



- (IBAction)showBtn:(id)sender;
//区域
@property (weak, nonatomic) IBOutlet UILabel *areaLab;
@property (weak, nonatomic) IBOutlet UIImageView *areaImg;
//- (IBAction)areaBtn:(id)sender;

//价格
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UIImageView *priceImg;
//- (IBAction)priceBtn:(id)sender;

//房型
@property (weak, nonatomic) IBOutlet UILabel *hoseTypeLab;
@property (weak, nonatomic) IBOutlet UIImageView *houseTypeImg;
//- (IBAction)houseTypeBtn:(id)sender;

//其他
@property (weak, nonatomic) IBOutlet UILabel *otherLab;
@property (weak, nonatomic) IBOutlet UIImageView *otherImg;
//- (IBAction)otherBtn:(id)sender;


@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *showView;
@property (weak, nonatomic) IBOutlet UITableView *showTableView;

@end

@implementation RCSearchResultViewController
{
    BOOL _isHidden;//是否展示条件筛选
    NSInteger _lastBtnTag;//上一个btntag
    NSString * _showType;//显示的类型
    NSArray * _areaAry;
    NSArray * _otherAry;
    NSArray * _pricrAry;
    NSArray * _houseTypeAry;
    NSMutableArray * _tableAry;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _tableAry =[[NSMutableArray alloc]init];
    
    if ([_houseType isEqualToString:@"Los Angeles"]) {
        self.title = @"洛杉矶";
    }
    else if ([_houseType isEqualToString:@"San Francisco"]) {
        self.title = @"旧金山";
    }
    else if ([_houseType isEqualToString:@"Seattle"]) {
        self.title = @"西雅图";
    }
    else if ([_houseType isEqualToString:@"school district housing"]) {
        self.title= @"学区房";
        _schoolDistrictBtn.backgroundColor = [UIColor orangeColor];
    }
    else if ([_houseType isEqualToString:@"Investment Property"]) {
        //投资房
        self.title= @"投资房";
        _InvestmentPropertyBtn.backgroundColor = [UIColor orangeColor];
    }
    else if ([_houseType isEqualToString:@"luxury real estate"]) {
        //豪宅
        self.title= @"豪宅";
        _luxuryRealEstateBtn.backgroundColor =[UIColor orangeColor];
    }
    //去掉留白
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self tableViewFunction];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _lastBtnTag=99;
    _isHidden=YES;
    _areaLab.text=@"区域";
    _priceLab.text=@"价格";
    _hoseTypeLab.text=@"房型";
    _otherLab.text=@"其他";
    
    [[NSUserDefaults standardUserDefaults]setValue:@"不限" forKey:@"区域"];
    [[NSUserDefaults standardUserDefaults]setValue:@"不限"  forKey:@"价格"];
    [[NSUserDefaults standardUserDefaults]setValue:@"不限"  forKey:@"房型"];
    [[NSUserDefaults standardUserDefaults]setValue:@"不限"  forKey:@"其他"];
    [self creatDataUrl:@"http://api.hhause.com/1/home/query"];
}
#pragma mark --------------------------CreatData-----------------------------
-(void)creatDataUrl :(NSString *)urlStr
{
    [RCGETRequest requestWithUrl:urlStr Complete:^(NSData *data) {
        //返回数据
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:NULL];
//        NSLog(@"JSON: %@",dict);
        NSArray * a = dict[@"homes"];
        NSDictionary * d = a[0];
        NSLog(@"%@",d);
        NSLog(@"%@",[d[@"city"] class]);
        
    } faile:^(NSError *error) {
        
    }];

}
#pragma mark --------------------------tableview----------------------------
-(void)tableViewFunction{
    //infotableVIew
    _infoTableVIew.dataSource=self;
    _infoTableVIew.delegate=self;
    _infoTableVIew.rowHeight=249;
    
    UINib * nib=[UINib nibWithNibName:Identifier bundle:nil];
    [_infoTableVIew registerNib:nib forCellReuseIdentifier:Identifier];
    
    //showtableView
    _areaAry = @[@"不限",@"洛杉矶",@"旧金山",@"西雅图"];
    _otherAry =@[@"不限",@"100平米以下",@"100~200平米",@"200~300平米",@"300~400平米",@"400~500平米",@"500平米以上"];
    _pricrAry =@[@"不限",@"200万",@"200~500万",@"500~1000万",@"1000~1500万",@"1500万~3000万",@"3000万以上"] ;
    _houseTypeAry = @[@"不限",@"独栋别墅",@"联排别墅",@"公寓"];
    
    _showTableView.dataSource=self;
    _showTableView.delegate=self;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:_infoTableVIew]) {
        return 30;
    }
    if ([tableView isEqual:_showTableView]) {
        return _tableAry.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_infoTableVIew]) {
        RCHouseTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
        return cell;
    }
    
    //showtableView
    UITableViewCell * cell =[[UITableViewCell alloc]init];
    cell.textLabel.text=_tableAry[indexPath.row];
    
    //比较，一样打钩
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:_showType] isEqualToString:[_tableAry objectAtIndex:indexPath.row]])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_infoTableVIew]) {
        RCHousinginformationViewController * housinginformation =[[RCHousinginformationViewController alloc]init];
        [self.navigationController pushViewController:housinginformation animated:YES];
    }
    
    //showtableView
    if ([tableView isEqual:_showTableView]) {
        NSString * str =_tableAry[indexPath.row];
        [[NSUserDefaults standardUserDefaults]setValue:str forKey:_showType];
        if([_showType isEqualToString:@"区域"])
        {
            
            _areaImg.image = [UIImage imageNamed:@"tab_btn_nor.png"];
            if ([str isEqualToString:@"不限"]) {
                _areaLab.textColor = [UIColor darkGrayColor];
                _areaLab.text=_showType;
            }
            else
            {
                _areaLab.text=str;
                _areaLab.textColor =[UIColor colorWithRed:0 green:141 blue:20 alpha:1];
            }
        }
        else if([_showType isEqualToString:@"价格"])
        {
            _priceImg.image = [UIImage imageNamed:@"tab_btn_nor.png"];
            if ([str isEqualToString:@"不限"]) {
                _priceLab.textColor = [UIColor darkGrayColor];
                _priceLab.text=_showType;
            }
            else
            {
                _priceLab.textColor =[UIColor colorWithRed:0 green:141 blue:20 alpha:1];
                _priceLab.text=str;
            }
        }
        else if([_showType isEqualToString:@"房型"])
        {
            _houseTypeImg.image = [UIImage imageNamed:@"tab_btn_nor.png"];
            if ([str isEqualToString:@"不限"]) {
                _hoseTypeLab.textColor = [UIColor darkGrayColor];
                _hoseTypeLab.text=_showType;
            }
            else
            {
                _hoseTypeLab.textColor =[UIColor colorWithRed:0 green:141 blue:20 alpha:1];
                _hoseTypeLab.text=str;
            }
        }
        else if([_showType isEqualToString:@"其他"])
        {
            _otherImg.image = [UIImage imageNamed:@"tab_btn_nor.png"];
            if ([str isEqualToString:@"不限"]) {
                _otherLab.textColor = [UIColor darkGrayColor];
                _otherLab.text=_showType;
            }
            else
            {
                _otherLab.textColor =[UIColor colorWithRed:0 green:141 blue:20 alpha:1];
                _otherLab.text=str;
            }
        }
        _isHidden=YES;
        _bgView.hidden=_isHidden;
    }
    
}
//给cell添加动画
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置Cell的动画效果为3D效果
    //设置x和y的初始值为0.1；
    cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    //x和y的最终值为1
    [UIView animateWithDuration:1 animations:^{
        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
}

#pragma mark-----------btn----------------
- (IBAction)schoolDistrictBtn:(id)sender {
    _schoolDistrictBtn.backgroundColor = [UIColor orangeColor];
    _InvestmentPropertyBtn.backgroundColor = [UIColor yellowColor];
    _luxuryRealEstateBtn.backgroundColor =[UIColor yellowColor];
}

- (IBAction)InvestmentPropertyBtn:(id)sender {
    //投资
    _schoolDistrictBtn.backgroundColor = [UIColor yellowColor];
    _InvestmentPropertyBtn.backgroundColor = [UIColor orangeColor];
    _luxuryRealEstateBtn.backgroundColor =[UIColor yellowColor];
}

- (IBAction)luxuryRealEstateBtn:(id)sender {
    //豪宅
    _schoolDistrictBtn.backgroundColor = [UIColor yellowColor];
    _InvestmentPropertyBtn.backgroundColor = [UIColor yellowColor];
    _luxuryRealEstateBtn.backgroundColor =[UIColor orangeColor];
}

- (IBAction)showBtn:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (_lastBtnTag==99) {
        _lastBtnTag=btn.tag;
    }
    NSLog(@"btntag:%ld,lasttag:%ld",(long)btn.tag,(long)_lastBtnTag);
    UILabel *last_label = (UILabel *)[self.view viewWithTag:_lastBtnTag+1];
    UIImageView *last_imageView =(UIImageView *)[self.view viewWithTag:_lastBtnTag+2];
    
    UILabel *find_label = (UILabel *)[self.view viewWithTag:btn.tag+1];
    UIImageView *find_imageView =(UIImageView *)[self.view viewWithTag:btn.tag+2];
    
    switch (btn.tag/100-1)
    {
        case 0:
            _tableAry = [NSMutableArray arrayWithArray:_areaAry];
            _showType = @"区域";
            break;
        case 1:
            _tableAry = [NSMutableArray arrayWithArray:_pricrAry];
            _showType = @"价格";
            break;
        case 2:
            _tableAry = [NSMutableArray arrayWithArray:_houseTypeAry];
            _showType = @"房型";
            break;
        case 3:
            _tableAry = [NSMutableArray arrayWithArray:_otherAry];
            _showType = @"其他";
            break;
        default:
            break;
    }
    [_showTableView reloadData];
    
    if (_isHidden) {
        _isHidden=NO;
        //如果是隐藏的，就让它展示，当前区域点亮换图
        _bgView.hidden=_isHidden;
        find_imageView.image = [UIImage imageNamed:@"tab_btn_down.png"];
        find_label.textColor = [UIColor colorWithRed:0 green:141 blue:20 alpha:1];
    }
    else if(btn.tag == _lastBtnTag){
        //如果是显示的，并且还是点击的当前区域，就让其隐藏
        _isHidden=YES;
        _bgView.hidden=_isHidden;
        if ([find_label.text isEqualToString:@"区域"] || [find_label.text isEqualToString:@"价格"] || [find_label.text isEqualToString:@"房型"] || [find_label.text isEqualToString:@"其他"]) {
            find_label.textColor = [UIColor darkGrayColor];
        }
        find_imageView.image = [UIImage imageNamed:@"tab_btn_nor.png"];
    }
    else{
        //如果是显示的，但是换了点击区域，就让上一个恢复初始状态，并且让最新点亮换图
        if ([last_label.text isEqualToString:@"区域"] || [last_label.text isEqualToString:@"价格"] || [last_label.text isEqualToString:@"房型"] || [last_label.text isEqualToString:@"其他"]) {
            last_label.textColor = [UIColor darkGrayColor];
        }
        
        last_imageView.image = [UIImage imageNamed:@"tab_btn_nor.png"];
        
        find_label.textColor = [UIColor colorWithRed:0 green:141 blue:20 alpha:1];
        find_imageView.image = [UIImage imageNamed:@"tab_btn_down.png"];
    }
    _lastBtnTag = btn.tag;
}

@end
