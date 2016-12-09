//
//  ViewController.m
//  私人订制Demo
//
//  Created by HHause on 16/6/27.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "RCSQSRDZViewController.h"
#import "RCSRDZ0TableViewCell.h"
#import "RCSRDZ1TableViewCell.h"
#import "RCSRDZ2TableViewCell.h"
#import "RCSRDZ3TableViewCell.h"
#import "RCSRDZ4TableViewCell.h"

#define BGIDETIFIER0 @"RCSRDZ0TableViewCell"
#define BGIDETIFIER1 @"RCSRDZ1TableViewCell"
#define BGIDETIFIER2 @"RCSRDZ2TableViewCell"
#define BGIDETIFIER3 @"RCSRDZ3TableViewCell"
#define BGIDETIFIER4 @"RCSRDZ4TableViewCell"

#import "RCSManager.h"
#import "RCMineViewController.h"
#define SELTABLEROWHEIGHT 30
//动画时间
#define kAnimationDuration 0.3
@interface RCSQSRDZViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
- (IBAction)cancelBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *bgTableView;
- (IBAction)sendBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UIView *bossView;


@property (copy, nonatomic)  UITableView * selectTableView;
@property (weak, nonatomic) IBOutlet UIButton *shieldBtn;
- (IBAction)shieldBtn:(id)sender;


@property (copy, nonatomic)  NSString * _00startTime;
@property (copy, nonatomic)  NSString * _01finishTime;
@property (copy, nonatomic)  NSString * _10houseType;//城区
@property (copy, nonatomic)  NSString * _20city;
@property (copy, nonatomic)  NSString * _21chengqu;
@property (copy, nonatomic)  NSString * _30area;
@property (copy, nonatomic)  NSString * _31roomType;//户型
@property (copy, nonatomic)  NSString * _40budget;//预算
@property (copy, nonatomic)  NSString * _41loan;//贷款
@property (copy, nonatomic)  NSMutableArray * _50requirements;//特殊要求
@property (copy, nonatomic)  NSString * _60phone;
@property (copy, nonatomic)  NSString * _70email;
@end

@implementation RCSQSRDZViewController
{
    NSArray * _titleAry;
    float _selTabY;
    float _beginOffset;
    NSMutableArray * _selAry;
    NSArray * _cityAry;
    NSArray * _chengquAry;
    NSArray * _areaAry;
    NSArray * _roomTypeAry;
    NSArray * _budgetAry;
    NSArray * _loanAry;

    NSInteger _TAG;//用来记录cell 上的lab
    RCSRDZ4TableViewCell * cell4;
    NSNotificationCenter * center;

    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [RCSManager sshare].vc=self;
    _titleAry = @[@"",@"",@[@"区域要求",@"选择城市",@"全部城区"],@[@"房源要求",@"面积",@"全部户型"],@[@"置业预算",@"理想预算",@"是否贷款"],@"",@"",@""];
    _selAry = [[NSMutableArray alloc]init];
    __50requirements  = [[NSMutableArray alloc]initWithArray:@[@"",@"",@"",@"",@""]];
    _cityAry  = @[@"选择城市",@"洛杉矶",@"旧金山",@"西雅图"];
    _chengquAry = @[@"全部城区",@"城区0",@"城区1",@"城区2",@"城区3",@"城区4",@"城区5",@"城区6"];
    _areaAry = @[@"面积",@"50-100",@"100-150",@"150-200",@"200以上"];
    _roomTypeAry = @[@"全部户型",@"户型1",@"户型2",@"户型3",@"户型4"];
    _budgetAry = @[@"预算(万美金)",@"50-100",@"100-150",@"150-200",@"200以上"];
    _loanAry = @[@"是否贷款",@"是",@"否"];
    
    
    _bgTableView.delegate = self;
    _bgTableView.dataSource = self;

    //去掉留白
    self.automaticallyAdjustsScrollViewInsets=NO;
    UINib * nib0=[UINib nibWithNibName:BGIDETIFIER0 bundle:nil];
    [_bgTableView registerNib:nib0 forCellReuseIdentifier:BGIDETIFIER0];
    UINib * nib1=[UINib nibWithNibName:BGIDETIFIER1 bundle:nil];
    [_bgTableView registerNib:nib1 forCellReuseIdentifier:BGIDETIFIER1];
    UINib * nib2=[UINib nibWithNibName:BGIDETIFIER2 bundle:nil];
    [_bgTableView registerNib:nib2 forCellReuseIdentifier:BGIDETIFIER2];
    UINib * nib3=[UINib nibWithNibName:BGIDETIFIER3 bundle:nil];
    [_bgTableView registerNib:nib3 forCellReuseIdentifier:BGIDETIFIER3];
    UINib * nib4=[UINib nibWithNibName:BGIDETIFIER4 bundle:nil];
    [_bgTableView registerNib:nib4 forCellReuseIdentifier:BGIDETIFIER4];
    
    //获取通知中心单例对象
    center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardWillChangeFrameNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)cancelBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (IBAction)sendBtn:(id)sender {
    _shieldBtn.hidden = YES;
    [self.view endEditing:YES];
//    NSLog(@"时间计划:start :%@ end :%@ \n 置业意向:%@\n 区域要求: 城市 %@  区域 %@\n 房源要求: 面积 %@  户型 %@\n 置业预算: 预算 %@  贷款 %@\n 特殊要求:%@\n 电话:%@\n   邮箱:%@\n",__00startTime,__01finishTime,__10houseType,__20city,__21chengqu,__30area,__31roomType,__40budget,__41loan,__50requirements,__60phone,__70email);

        self.presentingViewController.view.alpha = 0;
        [RCAlertView showMessage:@"申请成功，请等候我们的通知"];
        [self.presentingViewController.presentingViewController dismissViewControllerAnimated:NO completion:nil];
    
}
#pragma mark-----------------下拉菜单--------------------
- (void)creatPullDownMenuCGPoint:(CGPoint)CGpoint tag:(NSInteger )tag {
    [_selectTableView removeFromSuperview];
    _TAG = tag;
        if (tag == 20) {
            _selAry = [NSMutableArray arrayWithArray:_cityAry];
            
        }else if (tag == 21) {
            _selAry = [NSMutableArray arrayWithArray:_chengquAry];
        }else if(tag == 30)
        {
            _selAry = [NSMutableArray arrayWithArray:_areaAry];
        }else if(tag == 31)
        {
            _selAry = [NSMutableArray arrayWithArray:_roomTypeAry];
        }else if(tag == 40){
            _selAry = [NSMutableArray arrayWithArray:_budgetAry];
        }else if(tag == 41){
            _selAry = [NSMutableArray arrayWithArray:_loanAry];
        }
    
    _selectTableView  =[[UITableView alloc]initWithFrame:CGRectMake(CGpoint.x+5, CGpoint.y-64,100-20,SELTABLEROWHEIGHT*_selAry.count)];
    _selectTableView.layer.borderWidth = 0.5;
    _selectTableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    _selectTableView.delegate =self;
    _selectTableView.dataSource = self;
    _selectTableView.rowHeight = SELTABLEROWHEIGHT;
    [_selectTableView   setSeparatorColor:[UIColor clearColor]];
    
    _selTabY = _selectTableView.frame.origin.y;
//    NSLog(@"****%f",_selTabY);
    [self.bossView addSubview:_selectTableView];
    [self.bossView bringSubviewToFront:_sendBtn];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    float heightChange =_bgTableView.contentOffset.y-_beginOffset;
//    NSLog(@"offset---scroll:%f,%f,%f",_bgTableView.contentOffset.y,_beginOffset,heightChange);
//    NSLog(@"%f",_selTabY-heightChange);
//    if ([scrollView isEqual:_bgTableView]) {
//        [_selectTableView removeFromSuperview];
//    }
    _selectTableView.frame =CGRectMake(_selectTableView.frame.origin.x, _selTabY-heightChange, _selectTableView.frame.size.width, _selectTableView.frame.size.height);
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate

{
    if(!decelerate)
    {   //OK,真正停止了，do something
        _beginOffset = _bgTableView.contentOffset.y;
         _selTabY = _selectTableView.frame.origin.y;
        _shieldBtn.hidden = YES;
        [self.view endEditing:YES];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView

{
    //OK,真正停止了,do something
    _shieldBtn.hidden = YES;
    [self.view endEditing:YES];
    _beginOffset = _bgTableView.contentOffset.y;
    _selTabY = _selectTableView.frame.origin.y;
}
#pragma mark----------------------tableView-delegate------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:_bgTableView]) {
        return 8;
    }
    else{
        return _selAry.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) weakself = self;
    if (indexPath.row==5) {
        _bgTableView.rowHeight = 113;
    }else
    {
        _bgTableView.rowHeight = 60;
    }
    if ([tableView isEqual:_bgTableView]) {
        switch (indexPath.row) {
            case 0:{
               RCSRDZ0TableViewCell *cell0  =[tableView dequeueReusableCellWithIdentifier:BGIDETIFIER0 forIndexPath:indexPath];
//                __weak typeof(self) weakself = self;
                cell0.timeBlock = ^(NSString *type,NSString * time){
                    [weakself.selectTableView removeFromSuperview];
                    if ([type isEqualToString:@"start"]) {
                        weakself._00startTime = time;
                    }
                    else{
                        weakself._01finishTime = time;
                    }
                };

                return cell0;
                break;
            }
            case 1:{
                RCSRDZ1TableViewCell * cell1 = [tableView dequeueReusableCellWithIdentifier:BGIDETIFIER1 forIndexPath:indexPath];
//                __weak typeof(self) weakself = self;
                cell1.intentionBlock = ^(NSString *intentionStr){
                    weakself._10houseType = intentionStr;
                    [weakself.selectTableView removeFromSuperview];
                };
                return cell1;
                break;
            }
            case 2:case 3:case 4:{
                RCSRDZ2TableViewCell* cell2=[tableView dequeueReusableCellWithIdentifier:BGIDETIFIER2 forIndexPath:indexPath];
                cell2.titleLab.text =_titleAry[indexPath.row][0];
                cell2.firstLab.text =_titleAry[indexPath.row][1];
                cell2.secondLab.text =_titleAry[indexPath.row][2];
                cell2.firstLab.tag = indexPath.row*10;
                cell2.secondLab.tag = indexPath.row*10+1;
//                __weak typeof(self) weakself = self;
                cell2.firstBlock =^(CGPoint firstpoint,BOOL select){
                      [weakself creatPullDownMenuCGPoint:firstpoint tag:indexPath.row*10 ];

                };
                cell2.secondBlock =^(CGPoint secondpoint,BOOL select){
                        [weakself creatPullDownMenuCGPoint:secondpoint tag:indexPath.row*10+1 ];
                };
                return cell2;
                break;
            }
            case 5:{
                RCSRDZ3TableViewCell * cell3 = [tableView dequeueReusableCellWithIdentifier:BGIDETIFIER3 forIndexPath:indexPath];
                cell3.specialBlock =^(NSString *specialStr){
                    [weakself.selectTableView removeFromSuperview];
                    if ([specialStr isEqualToString:@"游泳池"]) {
                        if ([specialStr isEqualToString:weakself._50requirements[0]]) {
                           weakself._50requirements[0] = @"";
                        }
                        else
                            weakself._50requirements[0] = specialStr;
                    }else if([specialStr isEqualToString:@"海景"]){
                        
                        if ([specialStr isEqualToString:weakself._50requirements[1]]) {
                            weakself._50requirements[1] = @"";
                        }
                        else
                            weakself._50requirements[1] = specialStr;
                        
                    }else if([specialStr isEqualToString:@"山景"]){
                        
                        if ([specialStr isEqualToString:weakself._50requirements[2]]) {
                            weakself._50requirements[2] = @"";
                        }
                        else
                            weakself._50requirements[2] = specialStr;
                        
                    }else if([specialStr isEqualToString:@"高尔夫社区"]){
                        
                        if ([specialStr isEqualToString:weakself._50requirements[3]]) {
                           weakself._50requirements[3] = @"";
                        }
                        else
                            weakself._50requirements[3] = specialStr;
                        
                    }else if([specialStr isEqualToString:@"城景"]){
                        
                        if ([specialStr isEqualToString:weakself._50requirements[4]]) {
                            weakself._50requirements[4] = @"";
                        }
                        else
                            weakself._50requirements[4] = specialStr;
                        
                    }
                };
                return cell3;
                break;
            }
            case 6:{
                cell4 = [tableView dequeueReusableCellWithIdentifier:BGIDETIFIER4 forIndexPath:indexPath];
                cell4.titleImageView.image = [UIImage imageNamed:@"电话.jpg"];
                cell4.title.text = @"电话";
                
//                __weak typeof(self) weakself = self;
                cell4.beginBlock = ^(NSString *str){
                   [weakself.selectTableView removeFromSuperview];
                    weakself.shieldBtn.hidden = NO;
                };
                cell4.endBlock = ^(NSString *str){
                    weakself._60phone = str;
                     weakself.shieldBtn.hidden = YES;
                };
                return cell4;
                break;
            }
            case 7:{
                cell4 = [tableView dequeueReusableCellWithIdentifier:BGIDETIFIER4 forIndexPath:indexPath];
                
                cell4.titleImageView.image = [UIImage imageNamed:@"邮箱.jpg"];
                cell4.title.text = @"邮箱";
                
//                __weak typeof(self) weakself = self;
                cell4.beginBlock = ^(NSString *str){
                    weakself.shieldBtn.hidden = NO;
                    [weakself.selectTableView removeFromSuperview];
                };
                cell4.endBlock = ^(NSString *str){
                    weakself._70email = str;
                     weakself.shieldBtn.hidden = YES;
                };
                return cell4;
                break;
            }
            default:
                break;
        }
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        return cell;
    }
    else{
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.textLabel.text = _selAry[indexPath.row];
        cell.textLabel.textAlignment = 1;
        cell.textLabel.font =[UIFont boldSystemFontOfSize:13];
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
//        cell.textLabel.minimumScaleFactor = 4.0f;
        cell.textLabel.textColor =[UIColor grayColor];
        return cell;
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:_selectTableView]) {
        UILabel * lab = [self.view viewWithTag:_TAG];
        lab.text = _selAry[indexPath.row];

        [_selectTableView removeFromSuperview];
        if (indexPath.row!=0) {
            if (_TAG == 20) {
                
                __20city     =   _selAry[indexPath.row];
                
            }else if(_TAG == 21) {
                
                __21chengqu  =   _selAry[indexPath.row];
                
            }else if(_TAG == 30)
            {
                __30area     =   _selAry[indexPath.row];
                
            }else if(_TAG == 31)
            {
                __31roomType =   _selAry[indexPath.row];
                
            }else if(_TAG == 40){
                
                __40budget   =   _selAry[indexPath.row];
                
            }else if(_TAG == 41){
                
                __41loan     =   _selAry[indexPath.row];
            }
        }
    }
}
#pragma mark-----------------------------------------------------
//触摸空白
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    self.shieldBtn.hidden = YES;
    [_selectTableView removeFromSuperview];
}
#pragma mark - 界面随键盘移动
-(void)keyboardWillChangeFrameNotification:(NSNotification *)note{
    //取出键盘动画的时间(根据userInfo的key----UIKeyboardAnimationDurationUserInfoKey)
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    //取得键盘最后的frame)
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //计算控制器的view需要平移的距离
    CGFloat transformY = keyboardFrame.origin.y - self.view.frame.size.height;
    
    //执行动画
    [UIView animateWithDuration:duration animations:^{
        //平移
        _bossView.transform = CGAffineTransformMakeTranslation(0, transformY);

    }];
}
- (void)dealloc
{
    
//    NSLog(@"\n\t\n\t\n\t 申请私人定制 释放了\n\t\n\t\n\t");
}
- (IBAction)shieldBtn:(id)sender {
    _shieldBtn.hidden = YES;
    [self.view endEditing:YES];
}
@end
