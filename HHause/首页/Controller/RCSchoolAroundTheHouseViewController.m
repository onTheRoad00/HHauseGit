//
//  RCSchoolAroundTheHouseViewController.m
//  HHause
//
//  Created by HHause on 2016/10/18.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "RCSchoolAroundTheHouseViewController.h"
#import "RCXQXXTableViewCell.h"
#import "RCAroundSchool.h"

#define IdentifierXQXX @"RCXQXXTableViewCell"
@interface RCSchoolAroundTheHouseViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *mytitle;
- (IBAction)backBtn:(id)sender;

@end

@implementation RCSchoolAroundTheHouseViewController
{
    NSMutableArray * pSchoolAry;
    NSMutableArray * mSchoolAry;
    NSMutableArray * hSchoolAry;
    NSInteger num;
    NSArray * colorAry;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    pSchoolAry = [[NSMutableArray alloc]init];
    mSchoolAry = [[NSMutableArray alloc]init];
    hSchoolAry = [[NSMutableArray alloc]init];
    num =0;
    [self creatData];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    
 
    
    //去掉留白
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    UINib * nib=[UINib nibWithNibName:IdentifierXQXX bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:IdentifierXQXX];
    
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) creatData{
    /////小学 学校数据//////////////////////
    [RCGETRequest requestWithUrl:[NSString stringWithFormat:@"%@?mls=%@&level=P",KAPISchool_List_around,_mls] Complete:^(NSData *data) {
        //返回数据
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:NULL];
                NSLog(@"学校数据--JSON: %@",dict);
        
        NSArray * ary =dict[@"schools"];
        for (int i = 0; i<ary.count; i++) {
            RCAroundSchool * schoolModel = [[RCAroundSchool alloc]initWithDictionary:ary[i] error:nil];
            
            [pSchoolAry addObject:schoolModel];
        }
        num++;
        [self.tableView reloadData];
    } faile:^(NSError *error) {
        //        NSLog(@"error:%@",error);
    }];
    
    /////中学 学校数据//////////////////////
    [RCGETRequest requestWithUrl:[NSString stringWithFormat:@"%@?mls=%@&level=M",KAPISchool_List_around,_mls] Complete:^(NSData *data) {
        //返回数据
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:NULL];
                NSLog(@"学校数据--JSON: %@",dict);
        
        NSArray * ary =dict[@"schools"];
        for (int i = 0; i<ary.count; i++) {
            RCAroundSchool * schoolModel = [[RCAroundSchool alloc]initWithDictionary:ary[i] error:nil];
            
            [mSchoolAry addObject:schoolModel];
        }
        
        [self.tableView reloadData];
        num++;
    } faile:^(NSError *error) {
        //        NSLog(@"error:%@",error);
    }];
    
    /////高中 学校数据//////////////////////
    [RCGETRequest requestWithUrl:[NSString stringWithFormat:@"%@?mls=%@&level=H",KAPISchool_List_around,_mls] Complete:^(NSData *data) {
        //返回数据
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:NULL];
        //        NSLog(@"学校数据--JSON: %@",dict);
        
        NSArray * ary =dict[@"schools"];
        for (int i = 0; i<ary.count; i++) {
            RCAroundSchool * schoolModel = [[RCAroundSchool alloc]initWithDictionary:ary[i] error:nil];
            
            [hSchoolAry addObject:schoolModel];
        }
        
        [self.tableView reloadData];
        num++;
    } faile:^(NSError *error) {
        //        NSLog(@"error:%@",error);
    }];

}
#pragma mark----------tableview-----------------
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc] init] ;
    label.frame = CGRectMake(20, 0, CGRectGetWidth(tableView.frame)-20, 40);
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
   
    label.font = [UIFont boldSystemFontOfSize:20];
    if (section == 0) {
        label.text = @"小学";
    }else if(section == 1)
    {
        label.text = @"中学";
    }else{
        label.text = @"高中";
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), 40)];
    
    [view addSubview:label];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
        switch (section) {
            case 0:
                return pSchoolAry.count;
                break;
            case 1:
                return mSchoolAry.count;
                break;
            case 2:
                return hSchoolAry.count;
                break;
            default:
                break;
        }
    return 0;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UINib * nib=[UINib nibWithNibName:@"RCXQXXTableViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"RCXQXXTableViewCell"];
    RCXQXXTableViewCell * cell  =   [tableView dequeueReusableCellWithIdentifier:@"RCXQXXTableViewCell" forIndexPath:indexPath];
    RCAroundSchool * schoolMode;
    NSString * ed_level;
    NSString * isPublic = @"公立";
       switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row<pSchoolAry.count) {
                schoolMode =   pSchoolAry[indexPath.row];
            }
            
            ed_level = @"小学";
        }
            break;
        case 1:
        {
            if (indexPath.row<mSchoolAry.count) {
                schoolMode =   mSchoolAry[indexPath.row];
            }
            
            ed_level = @"中学";
        }
            break;
        case 2:
        {
            if (indexPath.row<hSchoolAry.count) {
                schoolMode =   hSchoolAry[indexPath.row];
            }
            ed_level = @"高中";
        }
            break;
        default:
            break;
    }
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
    
    if([schoolMode.isPublic isEqualToString:@"0"] ){
        isPublic = @"私立";
    }
    cell.schoolTypeLab.text =[NSString stringWithFormat:@"%@ %@",isPublic,ed_level];
    if ([schoolMode.isPrimary isEqualToString:@"1"]) {
        cell.schoolTypeLab.text =[NSString stringWithFormat:@"%@ %@  分配",isPublic,ed_level];
    }
    //                距离
    cell.distanceLab.text =[NSString stringWithFormat:@"%.2fkm",[schoolMode.distance floatValue]*1.609344];

    
    return  cell;
}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}

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
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden=NO;
}
- (void)dealloc
{
    NSLog(@"schoolAroundthehouseController 释放");
}


- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
