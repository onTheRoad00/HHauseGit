//
//  RCSrearchViewController.m
//  HHause
//
//  Created by HHause on 16/5/13.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "RCSrearchViewController.h"
#import "RCSearchListViewController.h"
#import "RCTagView.h"
#import "RCSearchHistoryTableViewCell.h"
#import "RCTagManger.h"
#import "RCSearchCityORSchoolTableViewCell.h"
#import "RCCityNameTableViewCell.h"

static NSString *CellIdentifier = @"Cell";
static NSString *historyCellIdentifier =@"RCSearchHistoryTableViewCell";
static NSString *searchlistCellIdentifer =@"RCSearchCityORSchoolTableViewCell";
static NSString *cityNameCellIdentifer =@"RCCityNameTableViewCell";

@interface RCSrearchViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
- (IBAction)cancelBtn:(id)sender;
- (IBAction)cancel2Btn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cancel;
@property (weak, nonatomic) IBOutlet UIButton *cancel2;



- (IBAction)houseTypeBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UITableView *houseTypetableView;
@property (weak, nonatomic) IBOutlet UILabel *houseTypeLab;


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *seachListTableView;

///数组数据源
@property (nonatomic, strong) NSArray *dataSource;


@end

@implementation RCSrearchViewController
{
    NSMutableArray * _history;
    NSArray * _houseAry;
    NSUserDefaults * ud;
    float _searchListTableViewHight;
    NSMutableArray * _searchResultAry;
    RCTagView *RCView;
    
    NSDictionary * _cityAbbreviationDict;
    NSDictionary * _abbreviationCityDict;
    BOOL flag;//都市圈城市列表OR搜索城市列表
    NSMutableArray * _cityAry;
}
- (void)viewDidLoad {
    [super viewDidLoad];
 
    _history = [[NSMutableArray alloc]init];
    _searchResultAry = [[NSMutableArray alloc]init];
    _cityAry = [[NSMutableArray alloc]init];
    _houseAry = @[@"不限",@"旧金山",@"洛杉矶",@"西雅图",@"圣地亚哥"];
    _cityAbbreviationDict = @{@"SF":@"旧金山",@"LA":@"洛杉矶",@"SD":@"圣地亚哥",@"SEA":@"西雅图",@"BSN":@"波士顿"};
    _abbreviationCityDict = @{@"旧金山":@"SF",@"洛杉矶":@"LA",@"圣地亚哥":@"SD",@"西雅图":@"SEA",@"波士顿":@"BSN",@"城市":@"",@"不限":@""};
    [RCTagManger tag].vc = self;
    _houseTypeLab.text = _metro_area;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _houseTypetableView.dataSource =self;
    _houseTypetableView.delegate = self;
    _seachListTableView.delegate =self;
    _seachListTableView.dataSource = self;
    _seachListTableView.rowHeight = 47;
    _textField.delegate =self;
    //去掉留白
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    _searchListTableViewHight = _seachListTableView.frame.size.height;
    
    [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
//实现当键盘出现的时候计算键盘的高度大小。
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    _seachListTableView.frame = CGRectMake(_seachListTableView.frame.origin.x, _seachListTableView.frame.origin.y, kScreeWidth, _searchListTableViewHight-kbSize.height);
  
}
#pragma mark-----------关于导航栏--------------------
//隐藏导航栏
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    ud =[NSUserDefaults standardUserDefaults];
    self.navigationController.navigationBar.hidden=YES;

    
    [self creatData];
    [self creatUI];
    //使用NSNotificationCenter 鍵盤出現時
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:)name:UIKeyboardDidShowNotification object:nil];
}

//取消隐藏
- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:(BOOL)animated];
    self.navigationController.navigationBar.hidden=NO;
    
    [self animationWithDuration:0.5 viewAlpha:0 height:0];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
//    [_searchResultAry removeAllObjects];
}
- (IBAction)cancelBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cancel2Btn:(id)sender {
    [self handTap];
}
-(void)afterDelay:(NSString *)theTextFieldtext{
    if ([theTextFieldtext isEqualToString:_textField.text] && theTextFieldtext.length>=1) {
//        NSLog(@"相同");
        NSString * metro = @"" ;
        if (!([_houseTypeLab.text isEqualToString:@"不限"]||[_houseTypeLab.text isEqualToString:@"城市"])) {
            for (NSString *key in [_cityAbbreviationDict allKeys])
            {
                if (  [_houseTypeLab.text isEqualToString:[_cityAbbreviationDict objectForKey:key] ] )
                {
    
                    metro = key;
                }
            }
        }
        NSString * urlsting = [NSString stringWithFormat:@"%@?keyword=%@&type=home&metro_area=%@",KAPISearch_suggest,theTextFieldtext,metro];
       
        NSString * utf8str = [urlsting stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

        [RCGETRequest requestWithUrl:utf8str Complete:^(NSData *data) {
            //返回数据
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:NULL];
//            NSLog(@"搜索url:%@\n\n搜索结果--JSON: %@\n\n",utf8str,dict);
            _searchResultAry =[NSMutableArray arrayWithArray:dict[@"suggest"]];
            flag = NO;
            [_seachListTableView reloadData];
            
        } faile:^(NSError *error) {
//            NSLog(@"搜索error%@",error);
        }];
    }else{
//        NSLog(@"不同");
    }
    
}
//都市圈--城市列表
-(void)creatCitylist{
    NSString * URLsearch_suggest =[NSString stringWithFormat:@"%@=",KAPIList_cities];
    if ([_metro_area isEqualToString:@"西雅图"]) {
        URLsearch_suggest = [NSString stringWithFormat:@"%@SEA",URLsearch_suggest];
    }else if ([_metro_area isEqualToString:@"旧金山"]){
        URLsearch_suggest = [NSString stringWithFormat:@"%@SF",URLsearch_suggest];
    }else if ([_metro_area isEqualToString:@"洛杉矶"]){
        URLsearch_suggest = [NSString stringWithFormat:@"%@LA",URLsearch_suggest];
    }else if ([_metro_area isEqualToString:@"圣地亚哥"]){
        URLsearch_suggest = [NSString stringWithFormat:@"%@SD",URLsearch_suggest];
    }
//    NSLog(@"\n\nurl\n\n%@",URLsearch_suggest);
    [RCGETRequest requestWithUrl:URLsearch_suggest Complete:^(NSData *data) {
        //返回数据
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:NULL];
//        NSLog(@"二级城市--JSON: %@",dict);
        
        _cityAry =[NSMutableArray arrayWithArray:dict[@"cities"]];
        flag = YES;
        
        [_seachListTableView reloadData];
    } faile:^(NSError *error) {
//        NSLog(@"搜索error%@",error);
    }];
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
    [self creatCitylist];
    _seachListTableView.hidden = NO;
    _cancel2.hidden = NO;
    _cancel.hidden = YES;
    [self animationWithDuration:0.5 viewAlpha:0 height:0];
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
//    NSLog(@"textFieldShouldEndEditing");
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
//    NSLog(@"textFieldDidEndEditing");
     _seachListTableView.hidden = YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (_history.count==0) {
        [_history addObject:@[@"",@"",@"清空搜索历史",@""]];
    }
    RCSearchListViewController * search = [[RCSearchListViewController alloc]init];
    
    if(_searchResultAry.count==1){
        NSArray * ary = _searchResultAry[0];
        search.mytitle = ary[3];
        search.keyword = ary[2];
        [_history insertObject:ary atIndex:0];
        
    }else{
        search.mytitle = textField.text;
        search.keyword = textField.text;
        [_history insertObject:@[@"",@"",textField.text,@""] atIndex:0];
       
    }
     [ud setObject:_history forKey:KKEYSearchHistoryAry];
    search.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:search animated:YES];
    
    [self handTap];

    return YES;
}
//触摸空白
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //隐藏键盘
    [self handTap];
}
#pragma mark -------------------------creatData+UI--------------
-(void)creatData{
//    metro_area=[ud valueForKey:KKEYSearch_suggest];
    NSString * URLsearch_suggest =[NSString stringWithFormat:@"%@?type=home",KAPISearch_suggest];
    if ([_metro_area isEqualToString:@"西雅图"]) {
        URLsearch_suggest = [NSString stringWithFormat:@"%@?type=home&metro_area=SEA",KAPISearch_suggest];
    }else if ([_metro_area isEqualToString:@"旧金山"]){
        URLsearch_suggest = [NSString stringWithFormat:@"%@?type=home&metro_area=SF",KAPISearch_suggest];
    }else if ([_metro_area isEqualToString:@"洛杉矶"]){
       URLsearch_suggest = [NSString stringWithFormat:@"%@?type=home&metro_area=LA",KAPISearch_suggest];
    }else if ([_metro_area isEqualToString:@"圣地亚哥"]){
        URLsearch_suggest = [NSString stringWithFormat:@"%@?type=home&metro_area=SD",KAPISearch_suggest];
    }
//    NSLog(@"\n\nurl\n\n%@",URLsearch_suggest);
    [RCGETRequest requestWithUrl:URLsearch_suggest Complete:^(NSData *data) {
        //返回数据
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:NULL];
//        NSLog(@"热点推荐--JSON: %@",dict);
        self.dataSource = dict[@"suggest"];
        [self creatHotAreaAndHistory];
     
    } faile:^(NSError *error) {
//        NSLog(@"搜索error%@",error);
    }];
    
    _history =[NSMutableArray arrayWithArray:[ud valueForKey:KKEYSearchHistoryAry]];
    [_tableView reloadData];

}
-(void)creatUI{
//    _houseTypetableView.layer.borderWidth = 1;
//    UIColor * color = KborderColor;
//    _houseTypetableView.layer.borderColor = color.CGColor;
    _houseTypetableView.layer.masksToBounds = NO;
//    _houseTypetableView.layer.cornerRadius = 4.0;
    
    _houseTypetableView.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    _houseTypetableView.layer.shadowOffset = CGSizeMake(0,3);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    _houseTypetableView.layer.shadowOpacity = 0.18;//阴影透明度，默认0
    _houseTypetableView.layer.shadowRadius = 3;//阴影半径，默认3
    
//    _searchView.layer.borderWidth = 1;  // 给图层添加一个有色边框
//    _searchView.layer.borderColor = color.CGColor;
    _searchView.layer.masksToBounds = YES;
    _searchView.layer.cornerRadius = 4.0;
    
    // 通过init初始化的控件大多都没有尺寸
    UIImageView *searchIcon = [[UIImageView alloc] init];
    searchIcon.image = [UIImage imageNamed:@"搜"];
    // contentMode：default is UIViewContentModeScaleToFill，要设置为UIViewContentModeCenter：使图片居中，防止图片填充整个imageView
    searchIcon.contentMode = UIViewContentModeCenter;
    searchIcon.frame = CGRectMake(_textField.frame.origin.x, _textField.frame.origin.y, _textField.frame.size.height, _textField.frame.size.height);
    
    _textField.leftView = searchIcon;
    _textField.leftViewMode = UITextFieldViewModeAlways;
}
-(void)creatHotAreaAndHistory{
    //热点+历史-------------------------------------------------------
    UILabel * hotlab = [[UILabel alloc]initWithFrame:CGRectMake(0,0,kScreeWidth, 50)];
    hotlab.text = @"   热点搜索";
    hotlab.font =  [UIFont fontWithName:@"Helvetica" size:20];
    hotlab.textColor = [UIColor lightGrayColor];
    hotlab.backgroundColor =[UIColor clearColor];
    
    RCView = [[RCTagView alloc] initWithFrame:CGRectMake(7,hotlab.frame.size.height, kScreeWidth-7, 0)];
    //    UIColor * bgcolor = KTextColor;
    RCView.RCSignalTagColor = K239GaryColor;
//    RCView.RCSignalTagColor = [UIColor groupTableViewBackgroundColor];
    RCView.RCbackgroundColor = [UIColor clearColor];
    
    
    NSMutableArray * muary =[[NSMutableArray alloc]init];
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    for (NSArray * ary in self.dataSource) {
        
        NSString * str = ary[ary.count-1];
        if ([str isEqualToString:@""]) {
            str = ary[ary.count-2];
        }
        [muary addObject:str];
        [dict setObject:ary forKey:str];
    }
    NSLog(@"%@---%@",muary,dict);
    RCView.tagDict = dict;
    [RCView setArrayTagWithLabelArray:muary];
//    NSLog(@"--------------------------%f",RCView.frame.size.height);
    
    
    UILabel * historylab = [[UILabel alloc]initWithFrame:CGRectMake(0,hotlab.frame.size.height+RCView.frame.size.height,kScreeWidth, hotlab.frame.size.height)];
    historylab.text = @"   历史搜索";
    historylab.font =  [UIFont fontWithName:@"Helvetica" size:20];
    historylab.backgroundColor =[UIColor clearColor];
    historylab.textColor = [UIColor lightGrayColor];
    
    UIView * view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreeWidth,hotlab.frame.size.height+RCView.frame.size.height+historylab.frame.size.height)];
    
    UIView * lineview =[[UIView alloc]initWithFrame:CGRectMake(18,hotlab.frame.size.height+RCView.frame.size.height,kScreeWidth-36,1)];
    lineview.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [view addSubview:hotlab];
    [view addSubview:RCView];
    [view addSubview:historylab];
    [view addSubview:lineview];
    _tableView.tableHeaderView=view;

    UITapGestureRecognizer *click = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handTap)];
    [view addGestureRecognizer:click];
}
-(void)handTap{
    //隐藏键盘
    _textField.text = nil;
    [_textField resignFirstResponder];
    _seachListTableView.hidden = YES;
    _cancel2.hidden = YES;
    _cancel.hidden = NO;
    [_searchResultAry removeAllObjects];
    [_cityAry removeAllObjects];
    [_seachListTableView reloadData];
}
#pragma mark----------tableview-----------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:_houseTypetableView]) {
        return _houseAry.count;
    }
    if ([tableView isEqual:_seachListTableView]) {
        if (flag) {
            return _cityAry.count;
        }
        return _searchResultAry.count;
    }
  
    return _history.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    //原为房屋类型，现改为都市圈
    if ([tableView isEqual:_houseTypetableView]) {
        UINib * nib=[UINib nibWithNibName:cityNameCellIdentifer bundle:nil];
        [_houseTypetableView registerNib:nib forCellReuseIdentifier:cityNameCellIdentifer ];
        RCCityNameTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cityNameCellIdentifer  forIndexPath:indexPath];
        cell.CityNameLab.text =_houseAry[indexPath.row];
    
        return cell;
    }
//    搜索结果tableview
    else if([tableView isEqual:_seachListTableView]){
        
        UINib * nib=[UINib nibWithNibName:searchlistCellIdentifer bundle:nil];
        [_seachListTableView registerNib:nib forCellReuseIdentifier:searchlistCellIdentifer];
        
        RCSearchCityORSchoolTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:searchlistCellIdentifer forIndexPath:indexPath];
        if (flag) {
            cell.cityLab.text =[NSString stringWithFormat:@"%@,%@", _cityAry[indexPath.row][0], _cityAry[indexPath.row][1]];
            cell.cityegLab.text = _metro_area;
        }else{
            NSArray * ary =_searchResultAry[indexPath.row];
            cell.cityLab.text =[NSString stringWithFormat:@"%@,%@",ary[ary.count-2],ary[ary.count-1]];
            cell.cityegLab.text = _cityAbbreviationDict[ary[1]];
        }
        
        return cell;
    }
//    历史搜索
    else{
        if(indexPath.row == _history.count-1)
        {
            UINib * nib=[UINib nibWithNibName:historyCellIdentifier bundle:nil];
            [_tableView registerNib:nib forCellReuseIdentifier:historyCellIdentifier];
            RCSearchHistoryTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:historyCellIdentifier forIndexPath:indexPath];
            return cell;
        }
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
            cell.accessoryType = UITableViewCellAccessoryNone;
            NSArray * ary =_history[indexPath.row];
            cell.textLabel.text = [NSString stringWithFormat:@" %@,%@",ary[2],ary[ary.count-1]];
//            NSLog(@"_history_history_history_history_history%@",_history);
            cell.textLabel.font = [UIFont systemFontOfSize:16];
            cell.textLabel.textColor = [UIColor blackColor];
            cell.textLabel.adjustsFontSizeToFitWidth = YES;
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_houseTypetableView]) {
        _houseTypeLab.text=_houseAry[indexPath.row];
        _metro_area = _houseAry[indexPath.row];
        [self creatData];
       [self animationWithDuration:0.5 viewAlpha:0 height:0];
    }
    else{
        RCSearchListViewController * search = [[RCSearchListViewController alloc]init];
        
        if ([tableView isEqual:_seachListTableView]) {
            if (flag) {
                NSArray * ary = _cityAry[indexPath.row];
                if ([ary[ary.count-1] isEqualToString:@""]) {
                    search.mytitle =ary[0];
                }else{
                    search.mytitle =ary[ary.count-1];
                }
                search.city = ary[0];
//                NSLog(@"%@",_abbreviationCityDict[_houseTypeLab.text]);
                search.metro_area = _abbreviationCityDict[_houseTypeLab.text];
                if (_history.count==0) {
                    [_history addObject:@[@"",@"",@"清空搜索历史",@""]];
                }
                [_history insertObject:@[@"city",_abbreviationCityDict[_houseTypeLab.text],ary[0],ary[ary.count-1]] atIndex:0];
                [ud setObject:_history forKey:KKEYSearchHistoryAry];
            }else
            {
            NSArray * ary = _searchResultAry[indexPath.row];
                if ([ary[ary.count-1] isEqualToString:@""]) {
                    search.mytitle =ary[2];
                }else{
                    search.mytitle =ary[ary.count-1];
                }
            search.city = ary[2];
            search.metro_area = ary[1];
            if (_history.count==0) {
                [_history addObject:@[@"",@"",@"清空搜索历史",@""]];
            }
            [_history insertObject:ary atIndex:0];
            [ud setObject:_history forKey:KKEYSearchHistoryAry];
            }
            [self handTap];
        }
        else if([tableView isEqual:_tableView]){
            //tableView
            if(indexPath.row == _history.count-1)
            {
                [_history removeAllObjects];
                [ud setObject:_history forKey:KKEYSearchHistoryAry];
                [_tableView reloadData];
                return;
            }
            NSArray * ary = _history[indexPath.row];
            if ([ary[ary.count-1] isEqualToString:@""]) {
                search.mytitle =ary[2];
            }else{
                search.mytitle =ary[ary.count-1];
            }
            search.city = ary[2];
            search.metro_area = ary[1];
        }
        
        [self.navigationController pushViewController:search animated:YES];
       
    }
}

- (IBAction)houseTypeBtn:(id)sender {
    
    if (_houseTypetableView.alpha==0) {
        [self handTap];
        [self animationWithDuration:0.5 viewAlpha:1 height:34*_houseAry.count];
    }
    else
    {
       [self animationWithDuration:0.5 viewAlpha:0 height:0];
    }
}
// 动画
-(void)animationWithDuration:(NSTimeInterval)duration viewAlpha:(CGFloat)alpha height:(CGFloat)height{
    
    CGRect frame = _houseTypetableView.frame;
    frame.size.height=height;
    [UIView animateWithDuration:duration animations:^{
        _houseTypetableView.alpha = alpha;
        _houseTypetableView.frame = frame;
        
    }];
}
- (void)dealloc
{
    NSLog(@"\n\t\n\t\n\t search 释放了\n\t\n\t\n\t");
   
}
@end
