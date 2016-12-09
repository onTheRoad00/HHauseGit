//
//  RCHousePriceDataViewController.m
//  HHause
//
//  Created by HHause on 2016/11/11.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "RCHousePriceDataViewController.h"
#import "DVBarChartView.h"
#import "DVLineChartView.h"
#import "RCUtils.h"
#define xAxisTitleArrayCount 12
@interface RCHousePriceDataViewController ()<DVBarChartViewDelegate,DVLineChartViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
- (IBAction)backBtn:(id)sender;
//头部View
@property (weak, nonatomic) IBOutlet UILabel *cityCNLab;
@property (weak, nonatomic) IBOutlet UILabel *cityUNLab;
@property (weak, nonatomic) IBOutlet UILabel *dataLab;
@property (weak, nonatomic) IBOutlet UILabel *QoQLab;
@property (weak, nonatomic) IBOutlet UILabel *YoYLab;

//中部View
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
- (IBAction)segmentedControl:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *segmentedControlLab;

@property (weak, nonatomic) IBOutlet DVBarChartView *barChartView;
@property (weak, nonatomic) IBOutlet DVLineChartView *lineChartView;
@property (weak, nonatomic) IBOutlet UILabel *unitLab;




//尾部View
@property (weak, nonatomic) IBOutlet UIView *bottomView0;
@property (weak, nonatomic) IBOutlet UIView *bottomView1;
/////////////////View1

- (IBAction)houseTypeBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *MidLab;
@property (weak, nonatomic) IBOutlet UILabel *RightLab;

//         全部
@property (weak, nonatomic) IBOutlet UIView *houseType0;
@property (weak, nonatomic) IBOutlet UILabel *houseType0LeftLab;
@property (weak, nonatomic) IBOutlet UILabel *houseType0MIdLab;
@property (weak, nonatomic) IBOutlet UILabel *houseType0RIghtLab;
@property (weak, nonatomic) IBOutlet UIButton *houseType0Btn;
//         公寓
@property (weak, nonatomic) IBOutlet UIView *houseType1;
@property (weak, nonatomic) IBOutlet UILabel *houseType1LeftLab;
@property (weak, nonatomic) IBOutlet UILabel *houseType1MIdLab;
@property (weak, nonatomic) IBOutlet UILabel *houseType1RIghtLab;
@property (weak, nonatomic) IBOutlet UIButton *houseType1Btn;
//         联排别墅
@property (weak, nonatomic) IBOutlet UIView *houseType2;
@property (weak, nonatomic) IBOutlet UILabel *houseType2LeftLab;
@property (weak, nonatomic) IBOutlet UILabel *houseType2MIdLab;
@property (weak, nonatomic) IBOutlet UILabel *houseType2RIghtLab;
@property (weak, nonatomic) IBOutlet UIButton *houseType2Btn;
//         独栋别墅
@property (weak, nonatomic) IBOutlet UIView *houseType3;
@property (weak, nonatomic) IBOutlet UILabel *houseType3LeftLab;
@property (weak, nonatomic) IBOutlet UILabel *houseType3MIdLab;
@property (weak, nonatomic) IBOutlet UILabel *houseType3RIghtLab;
@property (weak, nonatomic) IBOutlet UIButton *houseType3Btn;
///////////view2
//全部
- (IBAction)bottomView1Btn:(id)sender;


@property (weak, nonatomic) IBOutlet UIView *bottomView1TypeA;
@property (weak, nonatomic) IBOutlet UILabel *bottomView1LeftLab_A;

@property (weak, nonatomic) IBOutlet UILabel *bottomView1RightLab_A;
@property (weak, nonatomic) IBOutlet UIButton *bottomView1Btn_A;

//公寓
@property (weak, nonatomic) IBOutlet UIView *bottomView1TypeC;
@property (weak, nonatomic) IBOutlet UILabel *bottomView1LeftLab_C;
@property (weak, nonatomic) IBOutlet UILabel *bottomView1RightLab_C;
@property (weak, nonatomic) IBOutlet UIButton *bottomView1Btn_C;

//联排
@property (weak, nonatomic) IBOutlet UIView *bottomView1TypeT;
@property (weak, nonatomic) IBOutlet UILabel *bottomView1RightLab_T;
@property (weak, nonatomic) IBOutlet UIButton *bottomView1Btn_T;
@property (weak, nonatomic) IBOutlet UILabel *bottomView1LeftLab_T;

//独栋
@property (weak, nonatomic) IBOutlet UIView *bottomView1TypeH;
@property (weak, nonatomic) IBOutlet UILabel *bottomView1RightLab_H;
@property (weak, nonatomic) IBOutlet UIButton *bottomView1Btn_H;
@property (weak, nonatomic) IBOutlet UILabel *bottomView1LeftLab_H;


@end

@implementation RCHousePriceDataViewController
{
    float _lableSizeWidth;
    
    NSMutableArray * _A_12_dataAry; // 柱状图12个月数据
    NSMutableArray * _C_12_dataAry;
    NSMutableArray * _H_12_dataAry;
    NSMutableArray * _T_12_dataAry;
    
    NSArray * _A_smallary;          // 12个月 全部数据
    NSArray * _C_smallary;
    NSArray * _H_smallary;
    NSArray * _T_smallary;
    NSMutableArray * _XAxisAry;     //  柱状图x轴数据
    NSMutableArray * _bartltleAry;  //  柱状图上面数据
    NSMutableArray * _XAxisLineAry; //  折线图x轴数据
    NSInteger _index;               //  柱状图第几个
    NSInteger _yAxisMaxValue;       //  柱状图y轴最大值
    NSInteger _yAxisMaxLineValue;   //  折线图y轴最大值
    NSMutableArray * _A_linedataAry;//  折线图 数据
    NSMutableArray * _C_linedataAry;
    NSMutableArray * _H_linedataAry;
    NSMutableArray * _T_linedataAry;
    
    NSMutableArray * _A_YoYdataAry; //  单位均价 同比数据
    NSMutableArray * _C_YoYdataAry;
    NSMutableArray * _H_YoYdataAry;
    NSMutableArray * _T_YoYdataAry;
    
    NSMutableArray * _A_MoMdataAry; //  单位均价 环比数据
    NSMutableArray * _C_MoMdataAry;
    NSMutableArray * _H_MoMdataAry;
    NSMutableArray * _T_MoMdataAry;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    _A_12_dataAry   =   [[NSMutableArray alloc]init];
    _C_12_dataAry   =   [[NSMutableArray alloc]init];
    _H_12_dataAry   =   [[NSMutableArray alloc]init];
    _T_12_dataAry   =   [[NSMutableArray alloc]init];
    
    _A_linedataAry  =   [[NSMutableArray alloc]init];
    _C_linedataAry  =   [[NSMutableArray alloc]init];
    _H_linedataAry  =   [[NSMutableArray alloc]init];
    _T_linedataAry  =   [[NSMutableArray alloc]init];
    
    _XAxisAry       =   [[NSMutableArray alloc]init];
    _bartltleAry    =   [[NSMutableArray alloc]init];
    _XAxisLineAry   =   [[NSMutableArray alloc]init];
    
    _A_YoYdataAry     =   [[NSMutableArray alloc]init];
    _C_YoYdataAry     =   [[NSMutableArray alloc]init];
    _T_YoYdataAry     =   [[NSMutableArray alloc]init];
    _H_YoYdataAry     =   [[NSMutableArray alloc]init];
    
    _A_MoMdataAry     =   [[NSMutableArray alloc]init];
    _C_MoMdataAry     =   [[NSMutableArray alloc]init];
    _T_MoMdataAry     =   [[NSMutableArray alloc]init];
    _H_MoMdataAry     =   [[NSMutableArray alloc]init];
    
    _yAxisMaxValue  = 0;
    _houseType0Btn.selected = YES;
    
    
    _titleLab.text = _MidLab.text = _market_dataAry[0];
    _cityCNLab.text = _name_cn;
    _cityUNLab.text = _name;
     _dataLab.text = [self dataLabtext:_market_dataAry[1]];
    NSString * qaq = [self rateUpOrDown:_market_dataAry[2]];
    _QoQLab.text = [NSString stringWithFormat:@"环比%@",qaq];
    NSString * yoy = [self rateUpOrDown:_market_dataAry[3]];
    _YoYLab.text = [NSString stringWithFormat:@"环比%@     同比%@",qaq,yoy];
    NSLog(@"_YoYLab.text%@",_YoYLab.text);
    //近一年
    _houseType0.backgroundColor = KTextColor ;
    _houseType0LeftLab.textColor = _houseType0MIdLab.textColor = _houseType0RIghtLab.textColor = [UIColor whiteColor];
    //往年
    _bottomView1TypeA.backgroundColor = KTextColor ;
    _bottomView1LeftLab_A.textColor = _bottomView1RightLab_A.textColor = [UIColor whiteColor];
    
//    if ([_titleLab.text isEqualToString:@"单位均价"]) {
//        _QoQLab.hidden = YES;
//        _YoYLab.hidden = YES;
//        _RightLab.hidden = YES;
//        _houseType0RIghtLab.hidden = YES;
//        _houseType1RIghtLab.hidden = YES;
//        _houseType2RIghtLab.hidden = YES;
//        _houseType3RIghtLab.hidden = YES;
//    }
    if ([_titleLab.text isEqualToString:@"市场存量"]||[_titleLab.text isEqualToString:@"留存时间"]) {
        _segmentedControl.hidden = YES;
        _segmentedControlLab.hidden = NO;
        
    }
    [self creatDataType:@"A"];
    [self creatBarChartView];
    [self creatLineChartView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(NSString * )dataLabtext:(NSString *)dataLabtext{
    NSString * str;
    NSString * untilstr =  [RCUtils ChangeNumberFormat:dataLabtext];
    if ([_titleLab.text isEqualToString:@"中位价格"]) {
        str =[NSString stringWithFormat:@"$%@,000",untilstr];
        _unitLab.text = @"($:k)";
    }else if ([_titleLab.text isEqualToString:@"单位均价"]){
        str = [NSString stringWithFormat:@"$%@/ft²",untilstr];
        _unitLab.text = @"($/ft²)";
    }else if ([_titleLab.text isEqualToString:@"市场存量"]){
        str = [NSString stringWithFormat:@"%@套",untilstr];
        _unitLab.text = @"(套)";
    }else if ([_titleLab.text isEqualToString:@"留存时间"]){
        str = [NSString stringWithFormat:@"%@天",untilstr];
        _unitLab.text = @"(天)";
    }
    return str;
}
-(NSString * )rateUpOrDown:(NSString *)rate{
    float rate_float = [rate floatValue];
    NSString * str;
    if (rate_float>0) {
        str =[NSString stringWithFormat:@"+%@%%↑",rate];
    }else if(rate_float<0){
        str =[NSString stringWithFormat:@"%@%%↓",rate];
    }else{
        str =[NSString stringWithFormat:@"%@%%",rate];
    }
    return str;
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

- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
//最近1年
- (IBAction)houseTypeBtnClick:(id)sender {
    UIButton * btn = sender;
    if ([btn isEqual:_houseType0Btn]) {
        //全部
        _houseType0.backgroundColor = KTextColor ;
        _houseType0LeftLab.textColor = _houseType0MIdLab.textColor = _houseType0RIghtLab.textColor = [UIColor whiteColor];
        
        _houseType1.backgroundColor = _houseType2.backgroundColor =_houseType3.backgroundColor = [UIColor whiteColor];
        
        _houseType1LeftLab.textColor = K102GaryColor;
        _houseType1MIdLab.textColor = _houseType1RIghtLab.textColor = K51GaryColor;
        _houseType2LeftLab.textColor = K102GaryColor;
        _houseType2MIdLab.textColor = _houseType2RIghtLab.textColor = K51GaryColor;
        _houseType3LeftLab.textColor = K102GaryColor;
        _houseType3MIdLab.textColor = _houseType3RIghtLab.textColor = K51GaryColor;
        
//        _dataLab.text = _houseType0MIdLab.text;
        _houseType0Btn.selected = YES;
        _houseType1Btn.selected = NO;
        _houseType2Btn.selected = NO;
        _houseType3Btn.selected = NO;
        
        [self creatBarChartdata_XAxisTitleArray:_XAxisAry xValues:_A_12_dataAry barToplableArray:_bartltleAry];

    }else if ([btn isEqual:_houseType1Btn]) {
        //公寓
        _houseType1.backgroundColor = KTextColor ;
        _houseType1LeftLab.textColor = _houseType1MIdLab.textColor = _houseType1RIghtLab.textColor = [UIColor whiteColor];
        
        _houseType0.backgroundColor = _houseType2.backgroundColor =_houseType3.backgroundColor = [UIColor whiteColor];
        
        _houseType0LeftLab.textColor = K102GaryColor;
        _houseType0MIdLab.textColor = _houseType0RIghtLab.textColor = K51GaryColor;
        _houseType2LeftLab.textColor = K102GaryColor;
        _houseType2MIdLab.textColor = _houseType2RIghtLab.textColor = K51GaryColor;
        _houseType3LeftLab.textColor = K102GaryColor;
        _houseType3MIdLab.textColor = _houseType3RIghtLab.textColor = K51GaryColor;
        
        
//        _dataLab.text = _houseType1MIdLab.text;
        _houseType0Btn.selected = NO;
        _houseType1Btn.selected = YES;
        _houseType2Btn.selected = NO;
        _houseType3Btn.selected = NO;

         [self creatBarChartdata_XAxisTitleArray:_XAxisAry xValues:_C_12_dataAry barToplableArray:_bartltleAry];
        
    }else if ([btn isEqual:_houseType2Btn]) {
        //联排别墅
        _houseType2.backgroundColor = KTextColor ;
        _houseType2LeftLab.textColor = _houseType2MIdLab.textColor = _houseType2RIghtLab.textColor = [UIColor whiteColor];
        
        _houseType0.backgroundColor = _houseType1.backgroundColor =_houseType3.backgroundColor = [UIColor whiteColor];
        
        _houseType0LeftLab.textColor = K102GaryColor;
        _houseType0MIdLab.textColor = _houseType0RIghtLab.textColor = K51GaryColor;
        _houseType1LeftLab.textColor = K102GaryColor;
        _houseType1MIdLab.textColor = _houseType1RIghtLab.textColor = K51GaryColor;
        _houseType3LeftLab.textColor = K102GaryColor;
        _houseType3MIdLab.textColor = _houseType3RIghtLab.textColor = K51GaryColor;
        
        _houseType0Btn.selected = NO;
        _houseType1Btn.selected = NO;
        _houseType2Btn.selected = YES;
        _houseType3Btn.selected = NO;
        
         [self creatBarChartdata_XAxisTitleArray:_XAxisAry xValues:_T_12_dataAry barToplableArray:_bartltleAry];
        
    }else if ([btn isEqual:_houseType3Btn]) {
        //独栋别墅
        _houseType3.backgroundColor = KTextColor ;
        _houseType3LeftLab.textColor = _houseType3MIdLab.textColor = _houseType3RIghtLab.textColor = [UIColor whiteColor];
        
        _houseType0.backgroundColor = _houseType1.backgroundColor =_houseType2.backgroundColor = [UIColor whiteColor];
        
        _houseType0LeftLab.textColor = K102GaryColor;
        _houseType0MIdLab.textColor = _houseType0RIghtLab.textColor = K51GaryColor;
        _houseType1LeftLab.textColor = K102GaryColor;
        _houseType1MIdLab.textColor = _houseType1RIghtLab.textColor = K51GaryColor;
        _houseType2LeftLab.textColor = K102GaryColor;
        _houseType2MIdLab.textColor = _houseType2RIghtLab.textColor = K51GaryColor;
        
        _houseType0Btn.selected = NO;
        _houseType1Btn.selected = NO;
        _houseType2Btn.selected = NO;
        _houseType3Btn.selected = YES;
        
        [self creatBarChartdata_XAxisTitleArray:_XAxisAry xValues:_H_12_dataAry barToplableArray:_bartltleAry];
    }
    [self QoQLab_YoYLab:_index];
}
//往年
- (IBAction)bottomView1Btn:(id)sender {
    UIButton * btn = sender;
    if ([btn isEqual:_bottomView1Btn_A]) {
//        //全部
        _bottomView1TypeA.backgroundColor = KTextColor ;
        _bottomView1LeftLab_A.textColor = _bottomView1RightLab_A.textColor = [UIColor whiteColor];

        _bottomView1TypeC.backgroundColor = _bottomView1TypeT.backgroundColor =_bottomView1TypeH.backgroundColor = [UIColor whiteColor];

        _bottomView1LeftLab_C.textColor =  _bottomView1LeftLab_H.textColor =  _bottomView1LeftLab_T.textColor = K102GaryColor;
        
        _bottomView1RightLab_C.textColor = _bottomView1RightLab_H.textColor = _bottomView1RightLab_T.textColor =  K51GaryColor;
        
        _bottomView1Btn_A.selected = YES;
        _bottomView1Btn_C.selected = NO;
        _bottomView1Btn_T.selected = NO;
        _bottomView1Btn_H.selected = NO;
         [self creatLineChartdata_XAxisTitleArray:_XAxisLineAry pointArray:_A_linedataAry];
       
        
    }else if ([btn isEqual:_bottomView1Btn_C]) {
        //公寓
        _bottomView1TypeC.backgroundColor = KTextColor ;
        _bottomView1LeftLab_C.textColor = _bottomView1RightLab_C.textColor = [UIColor whiteColor];
        
        _bottomView1TypeA.backgroundColor = _bottomView1TypeT.backgroundColor =_bottomView1TypeH.backgroundColor = [UIColor whiteColor];
        
        _bottomView1LeftLab_A.textColor =  _bottomView1LeftLab_H.textColor =  _bottomView1LeftLab_T.textColor = K102GaryColor;
        
        _bottomView1RightLab_A.textColor = _bottomView1RightLab_H.textColor = _bottomView1RightLab_T.textColor =  K51GaryColor;
        
        _bottomView1Btn_C.selected = YES;
        _bottomView1Btn_A.selected = NO;
        _bottomView1Btn_T.selected = NO;
        _bottomView1Btn_H.selected = NO;
        [self creatLineChartdata_XAxisTitleArray:_XAxisLineAry pointArray:_C_linedataAry];//
    }else if ([btn isEqual:_bottomView1Btn_T]) {
        //联排别墅
        _bottomView1TypeT.backgroundColor = KTextColor ;
        _bottomView1LeftLab_T.textColor = _bottomView1RightLab_T.textColor = [UIColor whiteColor];
        
        _bottomView1TypeC.backgroundColor = _bottomView1TypeA.backgroundColor =_bottomView1TypeH.backgroundColor = [UIColor whiteColor];
        
        _bottomView1LeftLab_C.textColor =  _bottomView1LeftLab_H.textColor =  _bottomView1LeftLab_A.textColor = K102GaryColor;
        
        _bottomView1RightLab_C.textColor = _bottomView1RightLab_H.textColor = _bottomView1RightLab_A.textColor =  K51GaryColor;
        
        _bottomView1Btn_T.selected = YES;
        _bottomView1Btn_C.selected = NO;
        _bottomView1Btn_A.selected = NO;
        _bottomView1Btn_H.selected = NO;
        [self creatLineChartdata_XAxisTitleArray:_XAxisLineAry pointArray:_T_linedataAry];
        
    }else if ([btn isEqual:_bottomView1Btn_H]) {
        //独栋别墅
        _bottomView1TypeH.backgroundColor = KTextColor ;
        _bottomView1LeftLab_H.textColor = _bottomView1RightLab_H.textColor = [UIColor whiteColor];
        
        _bottomView1TypeC.backgroundColor = _bottomView1TypeT.backgroundColor =_bottomView1TypeA.backgroundColor = [UIColor whiteColor];
        
        _bottomView1LeftLab_C.textColor =  _bottomView1LeftLab_A.textColor =  _bottomView1LeftLab_T.textColor = K102GaryColor;
        
        _bottomView1RightLab_C.textColor = _bottomView1RightLab_A.textColor = _bottomView1RightLab_T.textColor =  K51GaryColor;
        
        _bottomView1Btn_H.selected = YES;
        _bottomView1Btn_C.selected = NO;
        _bottomView1Btn_T.selected = NO;
        _bottomView1Btn_A.selected = NO;
        [self creatLineChartdata_XAxisTitleArray:_XAxisLineAry pointArray:_H_linedataAry];
    }

}
- (IBAction)segmentedControl:(id)sender {
    UISegmentedControl * seg = sender;
    NSInteger index = seg.selectedSegmentIndex;
    switch (index) {
        case 0:
        {
            //头部
            _dataLab.hidden = NO;
            _QoQLab.hidden = NO;
            _YoYLab.hidden = NO;
            //中部
            _barChartView.hidden  = NO;
            _lineChartView.hidden = YES;
            //底部
            _bottomView0.hidden = NO;
            _bottomView1.hidden = YES;
            
        }
            break;
        case 1:
        {
            //头部
            _dataLab.hidden = YES;
            _QoQLab.hidden = YES;
            _YoYLab.hidden = YES;
            //中部
            _barChartView.hidden  = YES;
            _lineChartView.hidden = NO;
            //底部
            if ([_titleLab.text isEqualToString:@"中位价格"]||[_titleLab.text isEqualToString:@"单位均价"]) {
                _bottomView1.hidden = NO;
            }else{
                _bottomView1.hidden = YES;
            }
            _bottomView0.hidden = YES;
        }
            break;
        default:
            break;
    }
}
#pragma mark------------------barchart          linechart----------------
-(void)creatBarChartView{
    
    _barChartView.yAxisViewWidth = 40;
    _barChartView.numberOfYAxisElements = 5;
    
    _barChartView.delegate = self;
    
    
    _barChartView.barGap = 5;
    _barChartView.barWidth = (kScreeWidth-_barChartView.yAxisViewWidth-(xAxisTitleArrayCount+1)*_barChartView.barGap)/xAxisTitleArrayCount;
    _lableSizeWidth = _barChartView.barWidth;
    
    _barChartView.index = 11;
    _barChartView.textFont = [UIFont systemFontOfSize:8];
    
//    [self creatBarChartdata_XAxisTitleArray:@[@"11月", @"12月",@"2016",@"2月",@"3月",@"4月",@"5月", @"06", @"07",@"8月",@"09",@"10月"] xValues:@[@220, @550, @700,@340,@350,@400,@220,@300, @550, @700,@340,@350] barToplableArray:@[@"15年11月", @"15年12月",@"16年01月",@"16年02月",@"16年03月",@"16年04月",@"16年05月", @"16年06月", @"16年07月",@"16年08月",@"16年09月",@"16年10月"]];
    
}
-(void)creatBarChartdata_XAxisTitleArray:(NSArray *)xAxisTitleArray xValues:(NSArray *)xValues barToplableArray:(NSArray *)barToplableArray{
    _barChartView.yAxisMaxValue = _yAxisMaxValue;
    _barChartView.xAxisTitleArray = xAxisTitleArray;
    _barChartView.xValues = xValues;
    _barChartView.barToplableArray =[NSMutableArray arrayWithArray:barToplableArray];
    [_barChartView draw];
}
-(void)creatLineChartView{
    
    _lineChartView.lablesizeWidth = _lableSizeWidth;
    _lineChartView.showPointLabel = NO;
    _lineChartView.textFont = [UIFont systemFontOfSize:8];
    _lineChartView.xtextFont = [UIFont systemFontOfSize:10];
    _lineChartView.yAxisViewWidth = 40;
    
    _lineChartView.numberOfYAxisElements = 5;
    
    _lineChartView.delegate = self;
    _lineChartView.pointUserInteractionEnabled = YES;
    
    
    
    _lineChartView.pointGap = 30;
    
    _lineChartView.showSeparate = YES;
    _lineChartView.separateColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    _lineChartView.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    _lineChartView.axisColor = K153GaryColor;
    
//    [self creatLineChartdata_XAxisTitleArray:@[@"2012", @"4.2", @"4.3", @"4.4", @"4.5", @"4.6", @"4.7", @"4.8", @"4.9", @"4.10", @"4.11", @"4.12", @"4.13", @"4.14", @"4.15", @"4.16", @"4.17", @"4.18", @"4.19", @"4.20", @"4.21", @"4.22", @"4.23", @"4.24", @"4.25", @"4.26", @"4.27", @"4.28", @"4.29",@"4.2", @"4.3", @"4.4", @"4.5", @"4.6", @"4.7", @"4.8", @"4.9", @"4.10", @"4.11", @"4.12", @"4.13", @"4.14", @"4.15", @"4.16", @"4.17",@"2016"] pointArray:@[@300, @550, @700, @200, @370, @890, @760, @430, @210, @300, @300, @550, @700, @200, @370, @890, @760, @430, @210, @300, @300, @550, @700, @200, @370, @890, @760, @430, @210, @300,@300, @550, @700, @200, @370, @890, @760, @430, @210, @300, @300, @550, @700, @200, @370, @890]];
}
-(void)creatLineChartdata_XAxisTitleArray:(NSArray *)xAxisTitleArray pointArray:(NSArray *)pointArray {
    _lineChartView.yAxisMaxValue = _yAxisMaxLineValue;
    _lineChartView.xAxisTitleArray = xAxisTitleArray;
    DVPlot *plot = [[DVPlot alloc] init];
    plot.pointArray = pointArray;
    
    plot.lineColor = [UIColor colorWithRed:66/255.0 green:112/255.0 blue:191/255.0 alpha:1];
    plot.pointColor = [UIColor colorWithRed:66/255.0 green:112/255.0 blue:191/255.0 alpha:1];
    plot.pointSelectedColor = [UIColor colorWithRed:66/255.0 green:112/255.0 blue:191/255.0 alpha:1];
    plot.chartViewFill = NO;
    plot.withPoint = YES;
    [_lineChartView addPlot:plot];
    [_lineChartView draw];
}
#pragma mark -------------------------------------------------
- (void)lineChartView:(DVLineChartView *)lineChartView DidClickPointAtIndex:(NSInteger)index {
    
    NSLog(@"%ld", index);
    
}
- (void)barChartView:(DVBarChartView *)barChartView didSelectedBarAtIndex:(NSInteger)index {
    
    NSLog(@"%ld->%@", index,_bartltleAry[index]);
    _index =index;
    //大数据
    //同比环比
    [self QoQLab_YoYLab:index];
    [self QoQLab_YoYLabDown:index];
}
//顶部 数据 同比环比变化
-(void)QoQLab_YoYLab:(NSInteger)index{
    
    if (_houseType0Btn.selected) {
        
        _dataLab.text = [self dataLabtext:_A_smallary[index][_market_dataAry[4]]];
        NSString * qaq = [self rateUpOrDown:_A_smallary[index][_market_dataAry[5]]];
        _QoQLab.text = [NSString stringWithFormat:@"环比%@",qaq];
        NSString * yoy = [self rateUpOrDown:_A_smallary[index][_market_dataAry[6]]];
        _YoYLab.text = [NSString stringWithFormat:@"环比%@     同比%@",qaq,yoy];
        
        if ([_titleLab.text isEqualToString:@"单位均价"]&&_A_YoYdataAry.count==12){
            _YoYLab.text = [NSString stringWithFormat:@"环比%@     同比%@",[self rateUpOrDown:_A_MoMdataAry[index]],[self rateUpOrDown:_A_YoYdataAry[index]]];
        }
    }else if (_houseType1Btn.selected) {
        
        _dataLab.text = [self dataLabtext:_C_smallary[index][_market_dataAry[4]]];
        NSString * qaq = [self rateUpOrDown:_C_smallary[index][_market_dataAry[5]]];
        _QoQLab.text = [NSString stringWithFormat:@"环比%@",qaq];
        NSString * yoy = [self rateUpOrDown:_C_smallary[index][_market_dataAry[6]]];
        _YoYLab.text = [NSString stringWithFormat:@"环比%@     同比%@",qaq,yoy];
        
        if ([_titleLab.text isEqualToString:@"单位均价"]&&_C_YoYdataAry.count==12){
            
            _YoYLab.text = [NSString stringWithFormat:@"环比%@     同比%@",[self rateUpOrDown:_C_MoMdataAry[index]],[self rateUpOrDown:_C_YoYdataAry[index]]];
        }
        
    }else if (_houseType2Btn.selected) {
        
        _dataLab.text = [self dataLabtext:_T_smallary[index][_market_dataAry[4]]];
        NSString * qaq = [self rateUpOrDown:_T_smallary[index][_market_dataAry[5]]];
        _QoQLab.text = [NSString stringWithFormat:@"环比%@",qaq];
        NSString * yoy = [self rateUpOrDown:_T_smallary[index][_market_dataAry[6]]];
        _YoYLab.text = [NSString stringWithFormat:@"环比%@     同比%@",qaq,yoy];
        
        if ([_titleLab.text isEqualToString:@"单位均价"]&&_T_YoYdataAry.count==12){
            _YoYLab.text = [NSString stringWithFormat:@"环比%@     同比%@",[self rateUpOrDown:_T_MoMdataAry[index]],[self rateUpOrDown:_T_YoYdataAry[index]]];
        }
    }else if (_houseType3Btn.selected) {
        
        _dataLab.text = [self dataLabtext:_H_smallary[index][_market_dataAry[4]]];
        NSString * qaq = [self rateUpOrDown:_H_smallary[index][_market_dataAry[5]]];
        _QoQLab.text = [NSString stringWithFormat:@"环比%@",qaq];
        NSString * yoy = [self rateUpOrDown:_H_smallary[index][_market_dataAry[6]]];
        _YoYLab.text = [NSString stringWithFormat:@"环比%@     同比%@",qaq,yoy];
        
        if ([_titleLab.text isEqualToString:@"单位均价"]&&_T_YoYdataAry.count==12){
            _YoYLab.text = [NSString stringWithFormat:@"环比%@     同比%@",[self rateUpOrDown:_H_MoMdataAry[index]],[self rateUpOrDown:_H_YoYdataAry[index]]];
        }
    }
}
//底部 数据 同比变化
-(void)QoQLab_YoYLabDown:(NSInteger)index{
    //index月
    _houseType0MIdLab.text = [self dataLabtext:_A_smallary[index][_market_dataAry[4]]];
    _houseType1MIdLab.text = [self dataLabtext:_C_smallary[index][_market_dataAry[4]]];
    _houseType2MIdLab.text = [self dataLabtext:_T_smallary[index][_market_dataAry[4]]];
    _houseType3MIdLab.text = [self dataLabtext:_H_smallary[index][_market_dataAry[4]]];
    
    if (![_titleLab.text isEqualToString:@"单位均价"]) {
//        NSLog(@"%@",_A_smallary[index]);
        NSString * qaq0 = [self rateUpOrDown:_A_smallary[index][_market_dataAry[6]]];
        _houseType0RIghtLab.text = [NSString stringWithFormat:@"%@",qaq0];
        NSString * qaq1 = [self rateUpOrDown:_C_smallary[index][_market_dataAry[6]]];
        _houseType1RIghtLab.text = [NSString stringWithFormat:@"%@",qaq1];
        NSString * qaq2 = [self rateUpOrDown:_T_smallary[index][_market_dataAry[6]]];
        _houseType2RIghtLab.text = [NSString stringWithFormat:@"%@",qaq2];
        NSString * qaq3 = [self rateUpOrDown:_H_smallary[index][_market_dataAry[6]]];
        _houseType3RIghtLab.text = [NSString stringWithFormat:@"%@",qaq3];
    }else{
       
        if (_A_YoYdataAry.count==12) {
            NSString * qaq0 = [self rateUpOrDown:_A_YoYdataAry[index]];
            _houseType0RIghtLab.text = [NSString stringWithFormat:@"%@",qaq0];
            NSString * qaq1 = [self rateUpOrDown:_C_YoYdataAry[index]];
            _houseType1RIghtLab.text = [NSString stringWithFormat:@"%@",qaq1];
            NSString * qaq2 = [self rateUpOrDown:_T_YoYdataAry[index]];
            _houseType2RIghtLab.text = [NSString stringWithFormat:@"%@",qaq2];
            NSString * qaq3 = [self rateUpOrDown:_H_YoYdataAry[index]];
            _houseType3RIghtLab.text = [NSString stringWithFormat:@"%@",qaq3];
        }
        
    }
}
#pragma mark ---------------------creatData----------------------------
-(void)creatDataType:(NSString *)type{
    
    NSString * get_ALLUrl = [NSString stringWithFormat:@"%@?region=%@",KAPIMarket_data_get_all,_market_region];
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
        
        NSMutableArray * A_mutableAry = [[NSMutableArray alloc]init];
        NSMutableArray * C_mutableAry = [[NSMutableArray alloc]init];
        NSMutableArray * H_mutableAry = [[NSMutableArray alloc]init];
        NSMutableArray * T_mutableAry= [[NSMutableArray alloc]init];
        
        
        for (NSDictionary * dict in ary) {
            
            if ([dict[@"Type"] isEqualToString:@"A"]) {
                [A_mutableAry addObject:dict];
            }else if ([dict[@"Type"] isEqualToString:@"C"]) {
                [C_mutableAry addObject:dict];
            }else if ([dict[@"Type"] isEqualToString:@"H"]) {
                [H_mutableAry addObject:dict];
            }else if ([dict[@"Type"] isEqualToString:@"T"]) {
                [T_mutableAry addObject:dict];
            }
        }
        
        _A_smallary = [A_mutableAry subarrayWithRange:NSMakeRange(A_mutableAry.count-12, 12)];
        _C_smallary = [C_mutableAry subarrayWithRange:NSMakeRange(C_mutableAry.count-12, 12)];
        _H_smallary = [H_mutableAry subarrayWithRange:NSMakeRange(H_mutableAry.count-12, 12)];
        _T_smallary = [T_mutableAry subarrayWithRange:NSMakeRange(T_mutableAry.count-12, 12)];
        
#pragma mark-------------单位均价 同比计算--------------------------
        if ([_titleLab.text isEqualToString:@"单位均价"]) {
            NSArray * _A_lastYearary = [A_mutableAry subarrayWithRange:NSMakeRange(A_mutableAry.count-24, 12)];
            NSArray * _C_lastYearary = [C_mutableAry subarrayWithRange:NSMakeRange(C_mutableAry.count-24, 12)];
            NSArray * _H_lastYearary = [H_mutableAry subarrayWithRange:NSMakeRange(H_mutableAry.count-24, 12)];
            NSArray * _T_lastYearary = [T_mutableAry subarrayWithRange:NSMakeRange(T_mutableAry.count-24, 12)];
            
            for (int i = 0; i<12; i++) {
//同比
                NSDictionary * _A_dict16    = _A_smallary[i];
                NSDictionary * _A_dict15    = _A_lastYearary[i];
                float  _A_floatValue16      = [_A_dict16[_market_dataAry[4]] floatValue];
                float  _A_floatValue15      = [_A_dict15[_market_dataAry[4]] floatValue];
                float  _A_floatValue        = (_A_floatValue16-_A_floatValue15)/_A_floatValue15*100 ;
                [_A_YoYdataAry addObject:[NSString stringWithFormat:@"%.1f",_A_floatValue]];
                
                NSDictionary * _C_dict16    = _C_smallary[i];
                NSDictionary * _C_dict15    = _C_lastYearary[i];
                float  _C_floatValue16      = [_C_dict16[_market_dataAry[4]] floatValue];
                float  _C_floatValue15      = [_C_dict15[_market_dataAry[4]] floatValue];
                float  _C_floatValue        = (_C_floatValue16-_C_floatValue15)/_C_floatValue15*100 ;
                [_C_YoYdataAry addObject:[NSString stringWithFormat:@"%.1f",_C_floatValue]];
                
                NSDictionary * _H_dict16    = _H_smallary[i];
                NSDictionary * _H_dict15    = _H_lastYearary[i];
                float  _H_floatValue16      = [_H_dict16[_market_dataAry[4]] floatValue];
                float  _H_floatValue15      = [_H_dict15[_market_dataAry[4]] floatValue];
                float  _H_floatValue        = (_H_floatValue16-_A_floatValue15)/_H_floatValue15*100 ;
                [_H_YoYdataAry addObject:[NSString stringWithFormat:@"%.1f",_H_floatValue]];
                
                NSDictionary * _T_dict16    = _T_smallary[i];
                NSDictionary * _T_dict15    = _T_lastYearary[i];
                float  _T_floatValue16      = [_T_dict16[_market_dataAry[4]] floatValue];
                float  _T_floatValue15      = [_T_dict15[_market_dataAry[4]] floatValue];
                float  _T_floatValue        = (_T_floatValue16-_T_floatValue15)/_T_floatValue15*100 ;
                [_T_YoYdataAry addObject:[NSString stringWithFormat:@"%.1f",_T_floatValue]];
//环比
                NSDictionary *_A_MoMdict;
                NSDictionary *_A_MoMLastdict;
                NSDictionary *_C_MoMdict;
                NSDictionary *_C_MoMLastdict;
                NSDictionary *_T_MoMdict;
                NSDictionary *_T_MoMLastdict;
                NSDictionary *_H_MoMdict;
                NSDictionary *_H_MoMLastdict;
                if(i == 0){
                    _A_MoMdict      =   _A_smallary[i];
                    _A_MoMLastdict  =   _A_lastYearary[11];
                    
                    _C_MoMdict      =   _C_smallary[i];
                    _C_MoMLastdict  =   _C_lastYearary[11];
                    
                    _T_MoMdict      =   _T_smallary[i];
                    _T_MoMLastdict  =   _T_lastYearary[11];
                    
                    _H_MoMdict      =   _H_smallary[i];
                    _H_MoMLastdict  =   _H_lastYearary[11];
                    
                }else{
                    _A_MoMdict      =   _A_smallary[i];
                    _A_MoMLastdict  =   _A_smallary[i-1];
                    
                    _C_MoMdict      =   _C_smallary[i];
                    _C_MoMLastdict  =   _C_smallary[i-1];
                    
                    _T_MoMdict      =   _T_smallary[i];
                    _T_MoMLastdict  =   _T_smallary[i-1];
                    
                    _H_MoMdict      =   _H_smallary[i];
                    _H_MoMLastdict  =   _H_smallary[i-1];
                }
                float  _A_MoMValue  =   [_A_MoMdict[_market_dataAry[4]] floatValue];
                float _A_MoMLastValue = [_A_MoMLastdict[_market_dataAry[4]] floatValue];
                [_A_MoMdataAry addObject:[NSString stringWithFormat:@"%.1f",(_A_MoMValue-_A_MoMLastValue)/_A_MoMLastValue*100]];
                NSLog(@"%@",_A_MoMdataAry);
                
                float  _C_MoMValue  =   [_C_MoMdict[_market_dataAry[4]] floatValue];
                float _C_MoMLastValue = [_C_MoMLastdict[_market_dataAry[4]] floatValue];
                [_C_MoMdataAry addObject:[NSString stringWithFormat:@"%.1f",(_C_MoMValue-_C_MoMLastValue)/_C_MoMLastValue*100]];
                
                float  _T_MoMValue  =   [_T_MoMdict[_market_dataAry[4]] floatValue];
                float _T_MoMLastValue = [_T_MoMLastdict[_market_dataAry[4]] floatValue];
                [_T_MoMdataAry addObject:[NSString stringWithFormat:@"%.1f",(_T_MoMValue-_T_MoMLastValue)/_T_MoMLastValue*100]];
                
                float  _H_MoMValue  =   [_H_MoMdict[_market_dataAry[4]] floatValue];
                float _H_MoMLastValue = [_H_MoMLastdict[_market_dataAry[4]] floatValue];
                [_H_MoMdataAry addObject:[NSString stringWithFormat:@"%.1f",(_H_MoMValue-_H_MoMLastValue)/_H_MoMLastValue*100]];
                
            }
            
        }

#pragma mark---------柱状图---------中位价+单位均价+市场存量+留存时间---------
//        NSLog(@"%@********%@*******%@********%@",A_mutableAry,C_mutableAry,H_mutableAry,T_mutableAry);
        
        
        

        
      //A
        for (NSDictionary * dict in _A_smallary) {
            NSInteger  integerValue = [dict[_market_dataAry[4]] integerValue];
            [_A_12_dataAry addObject:[NSNumber numberWithInteger:integerValue]];
             if(integerValue>_yAxisMaxValue)
             {
                 _yAxisMaxValue = integerValue;
             }
            
            NSString * year = [dict[@"Period_End"] substringWithRange:NSMakeRange(0,4)];
            NSString * month = [dict[@"Period_End"] substringWithRange:NSMakeRange(5, 2)];
            NSString * bartitle = [NSString stringWithFormat:@"%@年%@月",year,month];
            [_bartltleAry addObject:bartitle];
            if([month isEqualToString:@"01"])
            {
                [_XAxisAry addObject:[NSString stringWithFormat:@"%@",[year substringWithRange:NSMakeRange(0,4)]]];
            }else{
                [_XAxisAry addObject:[NSString stringWithFormat:@"%@月",month]];
            }
        }
       
//        C
        
        for (NSDictionary * dict in _C_smallary) {
            NSInteger  integerValue = [dict[_market_dataAry[4]] integerValue];
            [_C_12_dataAry addObject:[NSNumber numberWithInteger:integerValue]];
            if(integerValue>_yAxisMaxValue)
            {
                _yAxisMaxValue = integerValue;
            }
            
        }
//      H
        
        for (NSDictionary * dict in _H_smallary) {
            NSInteger  integerValue = [dict[_market_dataAry[4]] integerValue];
            [_H_12_dataAry addObject:[NSNumber numberWithInteger:integerValue]];
            if(integerValue>_yAxisMaxValue)
            {
                _yAxisMaxValue = integerValue;
            }
            
        }
//      T
        
        for (NSDictionary * dict in _T_smallary) {
            NSInteger  integerValue = [dict[_market_dataAry[4]] integerValue];
            [_T_12_dataAry addObject:[NSNumber numberWithInteger: integerValue]];
            if(integerValue>_yAxisMaxValue)
            {
                _yAxisMaxValue = integerValue;
            }
            
        }

        _yAxisMaxValue = (_yAxisMaxValue/50+1)*50;
        
        [self creatBarChartdata_XAxisTitleArray:_XAxisAry xValues:_A_12_dataAry barToplableArray:_bartltleAry];
        
 #pragma mark---------折线图-------中位价+单位均价-----------
        if (!([_titleLab.text isEqualToString:@"市场存量"]||[_titleLab.text isEqualToString:@"留存时间"])) {
//A
        for (int i  = 0; i<A_mutableAry.count; i++) {
            NSDictionary * dict = A_mutableAry[i];

            NSInteger  integerValue = [dict[_market_dataAry[4]] integerValue];
            
            [_A_linedataAry addObject:[NSNumber numberWithInteger:integerValue]];
            
            if(integerValue>_yAxisMaxLineValue)
            {
                _yAxisMaxLineValue = integerValue;
            }
            
            NSString * year = [dict[@"Period_End"] substringWithRange:NSMakeRange(0,4)];
            NSString * month = [dict[@"Period_End"] substringWithRange:NSMakeRange(5, 2)];
           
            if([month isEqualToString:@"01"]||i==0||i==A_mutableAry.count-1)
            {
                [_XAxisLineAry addObject:[NSString stringWithFormat:@"%@",[year substringWithRange:NSMakeRange(0,4)]]];
            }else{
                [_XAxisLineAry addObject:[NSString stringWithFormat:@"%@月",month]];
            }
        }
       
//C
        for (int i  = 0; i<C_mutableAry.count; i++) {
                NSDictionary * dict = C_mutableAry[i];
                
                NSInteger  integerValue = [dict[_market_dataAry[4]] integerValue];
                
                [_C_linedataAry addObject:[NSNumber numberWithInteger:integerValue]];
            if(integerValue>_yAxisMaxLineValue)
            {
                _yAxisMaxLineValue = integerValue;
            }
        }
//H
            for (int i  = 0; i<H_mutableAry.count; i++) {
                NSDictionary * dict = H_mutableAry[i];
                
                NSInteger  integerValue = [dict[_market_dataAry[4]] integerValue];
                
                [_H_linedataAry addObject:[NSNumber numberWithInteger:integerValue]];
                if(integerValue>_yAxisMaxLineValue)
                {
                    _yAxisMaxLineValue = integerValue;
                }
            }
//T
            for (int i  = 0; i<T_mutableAry.count; i++) {
                NSDictionary * dict = T_mutableAry[i];
                
                NSInteger  integerValue = [dict[_market_dataAry[4]] integerValue];
                
                [_T_linedataAry addObject:[NSNumber numberWithInteger:integerValue]];
                if(integerValue>_yAxisMaxLineValue)
                {
                    _yAxisMaxLineValue = integerValue;
                }
            }
             _yAxisMaxLineValue = (_yAxisMaxLineValue/50+1)*50;
        [self creatLineChartdata_XAxisTitleArray:_XAxisLineAry pointArray:_A_linedataAry];
//        NSLog(@"%ld*******%@**********%@",(long)_yAxisMaxLineValue,_A_linedataAry,_XAxisLineAry);
        }
        //当月
        [self QoQLab_YoYLabDown:11];
    } faile:^(NSError *error) {
        NSLog(@"房价图表数据error%@",error);
    }];

}

@end
