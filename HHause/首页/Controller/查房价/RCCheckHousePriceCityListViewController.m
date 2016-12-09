//
//  RCCheckHousePriceCityListViewController.m
//  HHause
//
//  Created by HHause on 2016/11/8.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "RCCheckHousePriceCityListViewController.h"
#import "RCCheckHousePriceViewController.h"
#import "RCCityModel.h"
#import "RCCityModel0.h"
@interface RCCheckHousePriceCityListViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
- (IBAction)backBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *bigCitytableView;
@property (weak, nonatomic) IBOutlet UIView *navView;
@property (weak, nonatomic) IBOutlet UIView *searchView;
- (IBAction)searchBtn:(id)sender;
- (IBAction)cancelBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *searchView2;
@property (weak, nonatomic) IBOutlet UIView *blackBGView;
@property (weak, nonatomic) IBOutlet UITableView *searchListTableView;
@property (weak, nonatomic) IBOutlet UITextField *searchTestfield;


@end

@implementation RCCheckHousePriceCityListViewController
{
    NSArray * _cityAry;
    NSMutableArray * _smallAry;
    float _searchListTableViewHight;
    NSMutableArray * _citylistsMutaAry;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _titleLab.text = @"城市列表";
    _cityAry =@[@[@"全部",@"ALL"],@[@"旧金山",@"SF"],@[@"西雅图",@"SEA"],@[@"洛杉矶",@"LA"],@[@"奥斯汀",@"AUS"],@[@"圣地亚哥",@"SD"]];
    if (_index == 4) {
        _index = 5;
    }
    _smallAry = [[NSMutableArray alloc]init];
    _citylistsMutaAry = [[NSMutableArray alloc]init];
    
    _bigCitytableView.delegate = self;
    _bigCitytableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _searchListTableView.delegate = self;
    _searchListTableView.dataSource = self;
    _searchListTableViewHight = _searchListTableView.frame.size.height;
    
    //使用NSNotificationCenter 鍵盤出現時
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:)name:UIKeyboardDidShowNotification object:nil];
    
    _searchTestfield.delegate = self;
     [_searchTestfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    
     [self creatCitydata];

   
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
-(void)creatCitydata{

    
    NSString * smallCityUrl = KAPICity_lists;
    
    [RCGETRequest requestWithUrl:smallCityUrl Complete:^(NSData *data) {
        //返回数据
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:NULL];
        NSLog(@"城市列表--JSON: %@",dict);
            NSArray * ary = dict[@"cities"];
            NSMutableArray * citysModelAry =[[NSMutableArray alloc]init];
            for (int i = 0; i<ary.count; i++) {
                RCCityModel * model  =[[RCCityModel alloc]initWithDictionary:ary[i] error:nil];
                
                [citysModelAry addObject:model];
            }
            UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
            NSInteger sectionTitlesCount = [[collation sectionTitles] count];
            NSMutableArray *newSectionsArray = [[NSMutableArray alloc] initWithCapacity:sectionTitlesCount];
            
             for (NSInteger index = 0; index < sectionTitlesCount; index++) {
                    NSMutableArray *array = [[NSMutableArray alloc] init];
                [newSectionsArray addObject:array];
                }
             for (RCCityModel * model in citysModelAry) {
                
                     NSInteger sectionNumber = [collation sectionForObject:model collationStringSelector:@selector(name)];
         
                NSMutableArray *sectionNames = newSectionsArray[sectionNumber];
                  [sectionNames addObject:model];
               }
            
             //对每个section中的数组按照name属性排序
             for (NSInteger index = 0; index < sectionTitlesCount; index++) {
                     NSMutableArray *personArrayForSection = newSectionsArray[index];
                     NSArray *sortedPersonArrayForSection = [collation sortedArrayFromArray:personArrayForSection collationStringSelector:@selector(name)];
                     newSectionsArray[index] = sortedPersonArrayForSection;
                 }
//            RCCityModel * model = newSectionsAdrray[0][0];
//                _cityAry =@[@[@"全部",@"ALL"],@[@"洛杉矶",@"LA"],@[@"旧金山",@"SF"],@[@"西雅图",@"SEA"],@[@"奥斯汀",@"AUS"],@[@"圣地亚哥",@"SD"]];
            //洛杉矶  LA
            //旧金山 SF
            //西雅图 SEA
            //奥斯汀 AUS
            //圣地亚哥 SD
            NSMutableArray * LA_mutableAry = [[NSMutableArray alloc]init];
            NSMutableArray * SF_mutableAry = [[NSMutableArray alloc]init];
            NSMutableArray * SEA_mutableAry = [[NSMutableArray alloc]init];
            NSMutableArray * AUS_mutableAry = [[NSMutableArray alloc]init];
            NSMutableArray * SD_mutableAry = [[NSMutableArray alloc]init];
            NSMutableArray * ALL_mutableAry = [[NSMutableArray alloc]init];
           
            [_citylistsMutaAry removeAllObjects];
            for (NSArray * ary in newSectionsArray) {
                for (RCCityModel * model in ary) {
                    
                    if ([model.metro_area isEqualToString:@"LA"]) {
                       [LA_mutableAry addObject:model];
                    }else if ([model.metro_area isEqualToString:@"SF"]) {
                        [SF_mutableAry addObject:model];
                    }else if ([model.metro_area isEqualToString:@"SEA"]) {
                        [SEA_mutableAry addObject:model];
                    }else if ([model.metro_area isEqualToString:@"AUS"]) {
                        [AUS_mutableAry addObject:model];
                    }else if ([model.metro_area isEqualToString:@"SD"]) {
                        [SD_mutableAry addObject:model];
                    }
                    
                    [ALL_mutableAry addObject:model];
                }
            }
            [_citylistsMutaAry addObject:ALL_mutableAry];
            [_citylistsMutaAry addObject:SF_mutableAry];
            [_citylistsMutaAry addObject:SEA_mutableAry];
            [_citylistsMutaAry addObject:LA_mutableAry];
            [_citylistsMutaAry addObject:AUS_mutableAry];
            [_citylistsMutaAry addObject:SD_mutableAry];
        
        
        [_smallAry addObjectsFromArray:_citylistsMutaAry[_index]];
        NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:_index inSection:0];
        
        [self.bigCitytableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        
        [self.tableView reloadData];
    } faile:^(NSError *error) {
        NSLog(@"城市列表error%@",error);
    }];
    
}
#pragma ----------tableview-----------------
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 204*kScreeHeight/667;
//
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([tableView isEqual:_bigCitytableView]){
        return _cityAry.count;
    }else if ([tableView isEqual:_tableView]){

        return _smallAry.count;
    }else if ([tableView isEqual:_searchListTableView]){
        return 8;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellIdentifier"];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    if([tableView isEqual:_bigCitytableView]){
        //大城市圈
        cell.textLabel.text =_cityAry[indexPath.row][0];
        cell.textLabel.textColor = K153GaryColor;
        cell.textLabel.highlightedTextColor = K51GaryColor;
        
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = K249GaryColor;
    }else if ([tableView isEqual:_tableView]){
        //小城市
        RCCityModel * model  =[[RCCityModel alloc]init];
        model = _smallAry[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@,%@",model.name,model.name_cn];

        cell.textLabel.textColor = K3GaryColor;
        cell.backgroundColor = K249GaryColor;
    
    }else if ([tableView isEqual:_searchListTableView]){
        //搜索列表
        cell.textLabel.text = @"洛杉矶,ABC";
        cell.textLabel.textColor = K3GaryColor;
    
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    if([tableView isEqual:_bigCitytableView]){

        [_smallAry setArray:_citylistsMutaAry[indexPath.row]];
        
        [self.tableView reloadData];
        
    }else if ([tableView isEqual:_tableView]){
        //小城市
        RCCheckHousePriceViewController * checkHousePrice = [[RCCheckHousePriceViewController alloc]init];
        checkHousePrice.flag =@"城市列表";
        
            RCCityModel * model  =[[RCCityModel alloc]init];
            model = _smallAry[indexPath.row];
            NSDictionary * dict  = @{@"id":model.id,@"lat":model.lat,@"lng":model.lng,@"market_region":model.market_region,@"metro_area":model.metro_area,@"name":model.name,@"name_cn":model.name_cn,@"state":model.state};
            checkHousePrice.cityDict =dict;
            
        
        [self.navigationController pushViewController:checkHousePrice animated:YES];
    }else if ([tableView isEqual:_searchListTableView]){
        //搜索列表
        RCCheckHousePriceViewController * checkHousePrice = [[RCCheckHousePriceViewController alloc]init];
        checkHousePrice.flag =@"城市列表";
        checkHousePrice.cityDict =@{@"name_cn":@"搜索"};
        [self.navigationController pushViewController:checkHousePrice animated:YES];
    }
    
}

#pragma mark-------动画-------------
//筛选框动画
- (void)SortingViewAnimationsHidden:(BOOL)YON{
    float  navViewOriginY;
    
    if (YON) {
        
        navViewOriginY = -_navView.frame.size.height-_searchView.frame.size.height;
        
        //设置动画
        [UIView beginAnimations:nil context:nil];
        
        //定义动画时间
        [UIView setAnimationDuration:0.3];
        //设置view的frame，往上平移
        [_navView setFrame:CGRectMake(_navView.frame.origin.x,navViewOriginY, _navView.frame.size.width,_navView.frame.size.height)];
        [_searchView setFrame:CGRectMake(_searchView.frame.origin.x,_navView.frame.size.height+navViewOriginY, _searchView.frame.size.width,_searchView.frame.size.height)];
        
        [_searchView2 setFrame:CGRectMake(_searchView2.frame.origin.x,0, _searchView2.frame.size.width,_searchView2.frame.size.height)];
        
        
       
        _blackBGView.alpha = 0.5;
        _searchView2.alpha = 1;
        _searchListTableView.hidden = NO;
        [_searchTestfield becomeFirstResponder];
        [UIView commitAnimations];
        
                [UIView animateWithDuration:0.2 animations:^{
                   
                    _navView.alpha = 0;
                    _searchView.alpha = 0;
                    
                }];
    }else
    {
        [_searchTestfield resignFirstResponder];
        //设置动画
        [UIView beginAnimations:nil context:nil];
        
        //定义动画时间
        [UIView setAnimationDuration:0.3];
        //设置view的frame，往下平移
        [_navView setFrame:CGRectMake(_navView.frame.origin.x,0, _navView.frame.size.width,_navView.frame.size.height)];
        [_searchView setFrame:CGRectMake(_searchView.frame.origin.x,_navView.frame.size.height, _searchView.frame.size.width,_searchView.frame.size.height)];
        
         [_searchView2 setFrame:CGRectMake(_searchView2.frame.origin.x,_navView.frame.size.height+_searchView.frame.size.height, _searchView2.frame.size.width,_searchView2.frame.size.height)];
        
        _navView.alpha = 1;
        _searchView.alpha = 1;
        _searchListTableView.hidden = YES;
//
        [UIView commitAnimations];
        
        [UIView animateWithDuration:0.2 animations:^{
            _searchView2.alpha = 0;
            _blackBGView.alpha = 0;
            
        }];
    }
    
    
//    if (!YON) {
//        [UIView animateWithDuration:0.5 animations:^{
//            _screeningBtn.transform=CGAffineTransformRotate(_screeningBtn.transform,179.99*M_PI/180);
//            
//        }];
//    }else
//    {
//        [UIView animateWithDuration:0.5 animations:^{
//            _screeningBtn.transform=CGAffineTransformRotate(_screeningBtn.transform, -179.99*M_PI/180.0);
//            
//        }];
//    }
}

- (IBAction)searchBtn:(id)sender {
    
    [self SortingViewAnimationsHidden:YES];
}

- (IBAction)cancelBtn:(id)sender {
    [self SortingViewAnimationsHidden:NO];
}

//实现当键盘出现的时候计算键盘的高度大小。
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    _searchListTableView.frame = CGRectMake(_searchListTableView.frame.origin.x, _searchListTableView.frame.origin.y, kScreeWidth, _searchListTableViewHight-kbSize.height);
    
}
#pragma-----------关于textField--------------------
-(void)textFieldDidChange:(UITextField *)theTextField{
    //    NSLog( @"text changed: %@   %f", theTextField.text,_seachListTableView.frame.size.height);
    [self performSelector:@selector(afterDelay:) withObject:theTextField.text afterDelay:0.5f];
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
  
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
        return YES;
}
-(void)afterDelay:(NSString *)theTextFieldtext{
    
    
        
//        NSString * utf8str = [urlsting stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
        [RCGETRequest requestWithUrl:@"" Complete:^(NSData *data) {
            
            //返回数据
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:NULL];
//            _searchResultAry =[NSMutableArray arrayWithArray:dict[@"suggest"]];
            
            [_searchListTableView reloadData];
            
        } faile:^(NSError *error) {
            //            NSLog(@"搜索error%@",error);
        }];
}

@end
