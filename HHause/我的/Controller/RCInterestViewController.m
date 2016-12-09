//
//  RCInterestViewController.m
//  HHause
//
//  Created by HHause on 16/5/10.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "RCInterestViewController.h"
#import "RCHouseTableViewCell.h"
#import "RCHousinginformationViewController.h"
#import "RCHomesModel.h"
#define Identifier @"RCHouseTableViewCell"
@interface RCInterestViewController ()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *navView;

@property (weak, nonatomic) IBOutlet UITableView *tableview;
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *bgDeImageview;
@property (weak, nonatomic) IBOutlet UILabel *mytitle;
@property (weak, nonatomic) IBOutlet UIButton *screeningBtn;
- (IBAction)screeningBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *screeningView;
- (IBAction)houseTypeBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *bigView;

@end

@implementation RCInterestViewController
{
    MJRefreshFooterView * _footerView;
    MJRefreshHeaderView * _headerView;
    NSInteger _page;//页
    NSMutableArray * _homesModelAry;
   
    NSUserDefaults * _ud;
    NSString * _urlstring;
     NSString * _attributes;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _tableview.dataSource=self;
    _tableview.delegate=self;
    _tableview.rowHeight = 320*kScreeWidth/375;
    _mytitle.text = self.title;
    _attributes = @"";
    //给黑底添加手势
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showViewClick)];
    [_bigView addGestureRecognizer:tapGestureRecognizer];
    
    //去掉留白
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    UINib * nib=[UINib nibWithNibName:Identifier bundle:nil];
    [_tableview registerNib:nib forCellReuseIdentifier:Identifier];
    
    _ud = [NSUserDefaults standardUserDefaults];
    _homesModelAry = [[NSMutableArray alloc]init];
    
//     NSLog(@"%@",[_ud valueForKey:KKEYAccess_token]);
    
    if ([self.title isEqualToString:@"收藏房源"]) {
        _screeningBtn.hidden = NO;
        if ([_attributes isEqualToString:@""]) {
          _urlstring= [NSString stringWithFormat:@"%@?require_total=true&pagesize=10&access_token=%@",KAPIFAVOR_list_homes,[_ud valueForKey:KKEYAccess_token]];
        }else{
            _urlstring= [NSString stringWithFormat:@"%@?require_total=true&pagesize=10&access_token=%@&attributes=%@",KAPIFAVOR_list_homes,[_ud valueForKey:KKEYAccess_token],_attributes];
        }
        
//        NSLog(@"收藏列表:%@",_urlstring);
    }else if ([self.title isEqualToString:@"最近浏览"]){
        _screeningBtn.hidden = YES;
        
        _urlstring= [NSString stringWithFormat:@"%@?require_total=true&pagesize=10&access_token=%@",KAPIHOME_list_visited,[_ud valueForKey:KKEYAccess_token]];
//        NSLog(@"最近浏览:%@",_urlstring);
    }
    else if ([self.title isEqualToString:@"推荐房源"]){
        _screeningBtn.hidden = YES;
        
        _urlstring= [NSString stringWithFormat:@"%@?require_total=true&pagesize=10&access_token=%@",KAPIFAVOR_list_homes,[_ud valueForKey:KKEYAccess_token]];
//        NSLog(@"收藏列表:%@",_urlstring);
    }

    [self creatRefreshControl];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) creatDataPage:(NSInteger)page{
    if (page==1) {
        [_homesModelAry removeAllObjects];
    }
    NSString * urlstr = [NSString stringWithFormat:@"%@&page=%ld",_urlstring,(long)page];
    [RCGETRequest requestWithUrl:urlstr Complete:^(NSData *data) {
        //返回数据
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:NULL];
        NSLog(@"收藏/历史/推荐-列表--JSON: %@",dict);
        NSArray *array = dict[@"homes"];
        //没有值
        if (array.count==0) {
            [RCAlertView showMessage:@"暂无数据"];
           _bgDeImageview.hidden = NO;
        }else
        {
            for (int i = 0; i<array.count; i++) {
//                NSLog(@"%@",array[i]);
                RCHomesModel * model  =[[RCHomesModel alloc]initWithDictionary:array[i] error:nil];
                
                [_homesModelAry addObject:model];
            }
            _bgDeImageview.hidden = YES;
        }
        if ([self.title isEqualToString:@"最近浏览"]) {
            if (_homesModelAry.count>0) {
                _bgDeImageview.hidden = YES;
            }
        }else{
        NSString * total = [NSString stringWithFormat:@"%@",dict[@"total"]];
        if ([total isEqualToString:@"0"]||[total isEqualToString:@"(null)"]) {
            _mytitle.text = [NSString stringWithFormat:@"%@(暂无数据)",self.title];
           
            _bgDeImageview.hidden = NO;
        }else{
            _mytitle.text = [NSString stringWithFormat:@"%@(%@套)",self.title,total];
            _bgDeImageview.hidden = YES;
        }
        }
        if (_homesModelAry.count == 0) {
             _bgDeImageview.hidden = NO;
        }
        
        //关闭刷新
        [_headerView endRefreshing];
        [_footerView endRefreshing];
        
         [SVProgressHUD dismiss];
        [self.tableview reloadData];
    } faile:^(NSError *error) {
        NSLog(@"error:%@",error);
         [SVProgressHUD dismiss];
         [RCAlertView showMessage:error.userInfo[@"NSLocalizedDescription"]];
        [self.tableview reloadData];
    }];
    
}
-(void)creatRefreshControl{
    //1.添加头部
    _headerView =[MJRefreshHeaderView header];
    
    //2.添加尾部控件的方法
    _footerView =[MJRefreshFooterView footer];
    
    //3.监听刷新控件
    //设置代理
    _headerView.delegate=self;
    _footerView.delegate =self;
}
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (refreshView==_headerView) {
        //下拉刷新
        _page = 1;
        [self creatDataPage:_page];
    }
    if(refreshView ==_footerView)
    {
        //上拉加载
        _page++;//请求下一页
        [self creatDataPage:_page];
    }
}


#pragma mark----------tableview-----------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _homesModelAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RCHouseTableViewCell *  housecell=[tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
    RCHomesModel * homesmodel;
    if(indexPath.row<_homesModelAry.count)
    {
        homesmodel = _homesModelAry[indexPath.row];
    }
    
    //收藏、建筑面积、建于年、价格、图片、名字
    //浏览
//    housecell.favLab.text =[NSString stringWithFormat:@"%@人浏览",homesmodel.views];
//    //建筑面积
//    if ([homesmodel.space_area isEqualToString:@"0"]||homesmodel.space_area==nil) {
//        housecell.flool_areaLab.text = [NSString stringWithFormat:@"建筑%.f㎡",[homesmodel.floor_area intValue]/10.7639104];
//    }else{
//        housecell.flool_areaLab.text = [NSString stringWithFormat:@"建筑%.f㎡,占地%.f㎡",[homesmodel.floor_area intValue]/10.7639104,[homesmodel.space_area intValue]/10.7639104];
//    }
   housecell.flool_areaLab.text = [NSString stringWithFormat:@"%@室 丨 %d卫 丨 %.f㎡",homesmodel.bedrooms,[homesmodel.full_baths intValue]+[homesmodel.partial_baths intValue],[homesmodel.floor_area intValue]/10.7639104];
    //建筑年
    housecell.built_yearLab.text = [NSString stringWithFormat:@"建于%@年",homesmodel.built_year];
    //价格
//    NSString * rate = [_ud valueForKey:KKEYExchange];
//    //    NSLog(@"%d,%.4f,%.f",[homesmodel.price intValue],[rate floatValue],(int)[homesmodel.price intValue]*[rate floatValue]/10000);
//    housecell.priceLab.text = [NSString stringWithFormat:@"%.f",(int)[homesmodel.price intValue]*[rate floatValue]/10000];
    
//    housecell.priceLab.text = [NSString stringWithFormat:@"$%d万",(int)[homesmodel.price intValue]/10000];
    
    housecell.priceLab.text = [NSString stringWithFormat:@"$ %@",[RCUtils ChangeNumberFormat:homesmodel.price]];
    //    一个返回富文本的方法，用来让lable 显示字体大小不一样
//    [housecell.priceLab setAttributedText:[self changeLabelWithText:housecell.priceLab.text]];
    
    //图片七牛
    //    NSString * imageUrl = [NSString stringWithFormat:@"%@%@?imageView2/2/w/%d",KAPIQINIU,homesmodel.preview,(int)housecell.houseImage.frame.size.width];
    NSString * imageUrl = [NSString stringWithFormat:@"%@%@?format/jpg/imageMogr2/thumbnail/%.fx/strip/quality/50",KAPIQINIU,homesmodel.preview,kScreeWidth];
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
        housetype = @"房子";
    }
    housecell.houseNameLab.text = housetype;
    
    
    //判断  是否是收藏
    if ([self.title isEqualToString:@"收藏房源"]) {
        housecell.IsMyFavorBtn.selected = YES;
    }else {
        housecell.IsMyFavorBtn.hidden = YES;
    }

//    if ([homesmodel.is_my_favor isEqualToString:@"0"]||homesmodel.is_my_favor ==nil) {
//        housecell.IsMyFavorBtn.selected = NO;
//    }else{
//        housecell.IsMyFavorBtn.selected = YES;
//    }
    
    
    __weak typeof(housecell) weakCell = housecell;
    housecell.favBlock=^(BOOL selected) {
        /*函数回调 当block执行时就会回到这里*/
        
#pragma mark----------------收藏----------------
       
        //    3、判断selected----->yes: 移除，---no:收藏
        //    3、  请求
        //    4、   改变selected
        
            //    3、判断selected----->yes: 移除，---no:收藏
            
            NSString * collectstate;
            if (weakCell.IsMyFavorBtn.selected) {
                //            已收藏，移除
                collectstate =  [NSString stringWithFormat:@"%@?home_id=%@&access_token=%@",KAPIFAVOER_romeve_home,homesmodel.id,[_ud valueForKey:KKEYAccess_token]];
            }else{
                //            未收藏，收藏
                collectstate =  [NSString stringWithFormat:@"%@?home_id=%@&access_token=%@",KAPIFAVOR_add_home,homesmodel.id,[_ud valueForKey:KKEYAccess_token]];
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
                        [RCAlertView showMessage:@"取消收藏"];
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
                //刷新
                [_homesModelAry removeObjectAtIndex:indexPath.row];
                [self.tableview reloadData];
                
            } faile:^(NSError *error) {
                //            NSLog(@"error:%@",error);
            }];
        
#pragma mark-------------收藏-------------------
    };


    return  housecell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RCHomesModel * homesmodel;
    if(indexPath.row<_homesModelAry.count)
    {
        homesmodel = _homesModelAry[indexPath.row];
    }
    
    RCHousinginformationViewController * houseInfo =[[RCHousinginformationViewController alloc]init];
    houseInfo.houseId       = homesmodel.id;
    houseInfo.mls           = homesmodel.mls;
    houseInfo.city          = homesmodel.city;
    //            houseInfo.city = @"Chula+Vista";
        
    houseInfo.cdup = self.title;
    
    [self.navigationController pushViewController:houseInfo animated:YES];

}

#pragma mark--------------------------------Appear--------------------------------
//隐藏导航栏
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     self.navigationController.navigationBar.hidden=YES;
    _page =1;
    
    _headerView.scrollView=_tableview;
    _footerView.scrollView=_tableview;
    [SVProgressHUD show];
    [self creatDataPage:_page];
    
}
//取消隐藏
- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
     self.navigationController.navigationBar.hidden=NO;
    [SVProgressHUD dismiss];
}
- (void)dealloc
{
    [_headerView free];
    [_footerView free];
}
- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
//收藏--筛选
- (IBAction)screeningBtn:(id)sender {
    _screeningBtn.selected = !_screeningBtn.selected;
    if (_screeningBtn.selected) {
         [self SortingViewAnimationsHidden:NO];
        [self animationWithDurationViewAlpha:1];
    }else{
         [self SortingViewAnimationsHidden:YES];
        
        [self animationWithDurationViewAlpha:0];
    }
}
//房型筛选
- (IBAction)houseTypeBtn:(id)sender {
     _screeningBtn.selected = !_screeningBtn.selected;
    [self SortingViewAnimationsHidden:YES];
    [self animationWithDurationViewAlpha:0];
    _page = 1;
    UIButton * btn = sender;
    if ([btn.titleLabel.text isEqualToString:@"学区房"]) {
        
        self.title = @"收藏房源 - 学区房";
        _attributes = @"2";
        
    }else if([btn.titleLabel.text isEqualToString:@"投资房"]){
        
        self.title = @"收藏房源 - 投资房";
    _attributes = @"1";
        
    }else if ([btn.titleLabel.text isEqualToString:@"豪宅"]){
        
        self.title = @"收藏房源 - 豪宅";
   _attributes = @"4";
        
    }else{
        self.title = @"收藏房源";
      _attributes = @"";
    }
    if ([_attributes isEqualToString:@""]) {
        _urlstring= [NSString stringWithFormat:@"%@?require_total=true&pagesize=10&access_token=%@",KAPIFAVOR_list_homes,[_ud valueForKey:KKEYAccess_token]];
    }else{
        _urlstring= [NSString stringWithFormat:@"%@?require_total=true&pagesize=10&access_token=%@&attributes=%@",KAPIFAVOR_list_homes,[_ud valueForKey:KKEYAccess_token],_attributes];
    }
    [self creatDataPage:_page];
}
//筛选框动画
- (void)SortingViewAnimationsHidden:(BOOL)YON{
    float  originY;
    if (YON) {
        originY = -_screeningView.frame.size.height;
    }else
    {
        originY = _navView.frame.size.height;
    }
    //设置动画
    [UIView beginAnimations:nil context:nil];
    
    //定义动画时间
    [UIView setAnimationDuration:0.5];
    //设置view的frame，往下平移
    [_screeningView setFrame:CGRectMake(_screeningView.frame.origin.x,originY, _screeningView.frame.size.width,_screeningView.frame.size.height)];
    [UIView commitAnimations];
    //    NSLog(@"%f",-M_1_PI);
    if (!YON) {
        [UIView animateWithDuration:0.5 animations:^{
            _screeningBtn.transform=CGAffineTransformRotate(_screeningBtn.transform,179.99*M_PI/180);
            
        }];
    }else
    {
        [UIView animateWithDuration:0.5 animations:^{
            _screeningBtn.transform=CGAffineTransformRotate(_screeningBtn.transform, -179.99*M_PI/180.0);
            
        }];
    }
}
// 动画 showView
-(void)animationWithDurationViewAlpha:(CGFloat)alpha{
    
    [UIView animateWithDuration:0.5 animations:^{
        _bigView.alpha = alpha;
        
    }];
}
//showView click
-(void)showViewClick{
     
        _screeningBtn.selected = NO;
       
        [self SortingViewAnimationsHidden:YES];
   
    [self animationWithDurationViewAlpha:0];
}
@end
