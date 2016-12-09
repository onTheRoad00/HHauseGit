//
//  RCRaidersViewController.m
//  HHause
//
//  Created by HHause on 16/5/4.
//  Copyright © 2016年 HHause. All rights reserved.
// 攻略

#import "RCRaidersViewController.h"
#import "RCArtcleListTableViewCell.h"
#import "RCArticleViewController.h"
#import "ReadManager.h"
#import "XRCarouselView.h"
#import "RCArtcleJsonModel.h"
#define RaidersIdentifier @"RCArtcleListTableViewCell"

#define categoryString @"?category=10"
@interface RCRaidersViewController ()<UITableViewDataSource,UITableViewDelegate,XRCarouselViewDelegate,MJRefreshBaseViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation RCRaidersViewController
{
    NSInteger _page;//页
    MJRefreshFooterView * _footerView;
    MJRefreshHeaderView * _headerView;
    NSMutableArray * _dataAry;
    NSString * _suggested;//是否推荐
    NSMutableArray * _describeArray;//热点数组
    NSMutableArray * _imageArray;//热点配图数组
    NSMutableArray * _articleIDArray;//热点文章数组
    XRCarouselView *_carouselView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _dataAry =[[NSMutableArray alloc]init];
    _describeArray = [[NSMutableArray alloc]init];
    _imageArray = [[NSMutableArray alloc]init];
    _articleIDArray = [[NSMutableArray alloc]init];
    
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.rowHeight=122*kScreeHeight/667;

    _carouselView = [[XRCarouselView alloc]initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 235*kScreeWidth/375)];
    [self imageReplace];
    [_tableView setTableHeaderView:_carouselView];
    
    //去掉留白
//    self.automaticallyAdjustsScrollViewInsets=NO;
    
    UINib * nib=[UINib nibWithNibName:RaidersIdentifier bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:RaidersIdentifier];
    
    
    [self creatRefreshControl];
//    [self creatHotPoint];
     [SVProgressHUD show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void) creatHotPoint{
    
      NSString * urlstring = [NSString stringWithFormat:@"%@%@&pagesize=3&page=1&suggested=true",KAPIWikiLists,categoryString];
//    NSLog(@"%@",urlstring);
    [RCGETRequest requestWithUrl:urlstring Complete:^(NSData *data) {
        //返回数据
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:NULL];
//        NSLog(@"攻略 推荐--JSON: %@",dict);
        
        [_describeArray removeAllObjects];
        [_imageArray removeAllObjects];
        [_articleIDArray removeAllObjects];
        
        NSArray *array = dict[@"articles"];
        //没有值
        if (array.count==0) {
            [RCAlertView showMessage:@"暂无数据"];
        }else
        {
            for (int i=0; i<array.count; i++) {
                RCArtcleJsonModel *_model  =[[RCArtcleJsonModel alloc]initWithDictionary:array[i] error:nil];
                
                [_describeArray addObject:_model.title];
                [_imageArray addObject:[NSString stringWithFormat:@"%@%@?imageView/2/w/%.f",KAPIQINIU,_model.preview,kScreeWidth]];
                [_articleIDArray addObject: _model.id];
            }
        }
        [self imageReplace];
    } faile:^(NSError *error) {
//        NSLog(@"error:%@",error);
    }];

}
- (void) creatDataPage:(NSInteger)page{
    if (page==1) {
        [_dataAry removeAllObjects];
    }

    NSString * urlstring = [NSString stringWithFormat:@"%@%@&pagesize=20&page=%ld",KAPIWikiLists,categoryString,(long)page];
//    NSLog(@"%@",urlstring);
    [RCGETRequest requestWithUrl:urlstring Complete:^(NSData *data) {
        //返回数据
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:NULL];
//        NSLog(@"文章列表 攻略--JSON: %@",dict);
        NSArray *array = dict[@"articles"];
        //没有值
        if (array.count==0) {
            [RCAlertView showMessage:@"暂无数据"];
        }else
        {
            for (int i=0; i<array.count; i++) {
                RCArtcleJsonModel *_model  =[[RCArtcleJsonModel alloc]initWithDictionary:array[i] error:nil];
                [_dataAry addObject:_model];
            }
        }
        
        //关闭刷新
        [_headerView endRefreshing];
        [_footerView endRefreshing];
        
         [SVProgressHUD dismiss];
        [self.tableView reloadData];
    } faile:^(NSError *error) {
//        NSLog(@"error:%@",error);
         [SVProgressHUD dismiss];
         [RCAlertView showMessage:error.userInfo[@"NSLocalizedDescription"]];
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

#pragma ----------tableview-----------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RCArtcleListTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:RaidersIdentifier forIndexPath:indexPath];
    RCArtcleJsonModel * model;
    if (_dataAry.count>0) {
        model =_dataAry[indexPath.row];
        cell.articleTitle.text  =   model.title;
        cell.timeLab.text       =   model.publish_time;
        cell.pvLab.text         =   model.views;
        //        七牛
        
        NSString * imageUrl = [NSString stringWithFormat:@"%@%@?imageMogr2/thumbnail/%.d",KAPIQINIU,model.preview,(int)cell.titleImage.frame.size.width*2];
//        NSLog(@"\n\t\t imageUrl:%@",imageUrl);
//        NSLog(@"%f",cell.titleImage.frame.size.width);
        [cell.titleImage sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"文章列表过渡"]];
        
        
    }

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RCArticleViewController * article = [[RCArticleViewController alloc]init];
    article.mytitle = @"置业攻略";
    RCArtcleJsonModel * model =_dataAry[indexPath.row];
    article.urlstring = [NSString stringWithFormat:@"http://www.hhause.com/wiki/%@",model.id];
    article.summary = model.summary;
    article.arttitle = model.title;
    article.imageUrl = [NSString stringWithFormat:@"%@%@?imageView/2/w/100",KAPIQINIU,model.preview];
    [[ReadManager share].vc presentViewController:article animated:YES completion:^{
        
    }];
}

#pragma mark--------------------------------Appear--------------------------------
//隐藏导航栏
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _page =1;
    [self creatDataPage:_page];
    _headerView.scrollView=_tableView;
    _footerView.scrollView=_tableView;
    
     [self creatHotPoint];
}
//取消隐藏
- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
   [_carouselView stopTimer];
    [SVProgressHUD dismiss];
}
#pragma mark--------------------------------热点-----------------
- (void) imageReplace{
    
    //    _urlarr = @[@"",@"",@"",@""];
    //    _describeArray =@[@"第一条热点",@"第二条热点",@"第三条热点",@"第四条热点"];
    NSArray * a =[NSArray arrayWithArray: _imageArray];
    _carouselView.imageArray=a;
    _carouselView.describeArray = _describeArray;
    //用代理处理图片点击
    _carouselView.delegate = self;
    
    //    //设置分页控件指示器的颜色
    //    [_carouselView setPageColor:[UIColor blueColor] andCurrentPageColor:[UIColor redColor]];
    
    //    //设置分页控件的图片,不设置则为系统默认
    //    [_carouselView setPageImage:[UIImage imageNamed:@"other"] andCurrentPageImage:[UIImage imageNamed:@"current"]];
    //
    //    //设置分页控件的位置，默认为PositionBottomCenter
    //    _carouselView.pagePosition = PositionBottomRight;
    
    
    
    //    //开启定时器
    _carouselView.isTime=YES;
    //    //设置图片切换的方式
    _carouselView.changeMode = ChangeModeDefault;
    
    //设置每张图片的停留时间
    _carouselView.time = 2;
    
}
#pragma  XRCarouselViewDelegate
- (void)carouselView:(XRCarouselView *)carouselView didClickImage:(NSInteger)index {
//    NSLog(@"点击了第%ld张图片,文章ID:%@", (long)index,_articleIDArray[index]);
    
    RCArticleViewController * article = [[RCArticleViewController alloc]init];
    article.mytitle = @"置业攻略";
    if (_articleIDArray.count > 0) {
    article.urlstring = [NSString stringWithFormat:@"http://www.hhause.com/wiki/%@",_articleIDArray[index]];
    article.summary = _describeArray[index];
    article.arttitle = _describeArray[index];
    article.imageUrl = _imageArray[index];
    
    [[ReadManager share].vc presentViewController:article animated:YES completion:^{
        
    }];
    }
}
- (void)dealloc
{
    NSLog(@"\n\t\n\t\n\t  raiders 释放了  \n\t\n\t\n\t");
    [_headerView free];
    [_footerView free];
}

@end
