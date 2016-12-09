//
//  PhotoBrowserView.m
//  SPH0
//
//

#import "PhotoBrowserView.h"

#import "PhotoBrowserScrollView.h"

//#import "RCNavHidManger.h"
@interface PhotoBrowserView ()<UIScrollViewDelegate>

//导航条
@property (nonatomic,strong) UIView *backNavigationView;

@property (nonatomic,strong) NSArray *urlArray;

@property (nonatomic,assign) int currentIndex;


//计数板
@property (nonatomic,strong) UILabel *numberLabel;


@end



@implementation PhotoBrowserView

- (instancetype)initWithFrame:(CGRect)frame WithArray:(NSArray *)array andCurrentIndex:(int)index
{
    self = [super initWithFrame:frame];
    if (self) {
        if(array.count!=0&&array!=nil)
        {
            _urlArray = array;
            if(_currentIndex>array.count){
                _currentIndex = 0;
            }
            else
            {
                _currentIndex=index;
            }
            self.userInteractionEnabled = YES;
            [self createNavigationView];
            
            [self createScrollView];
            
            [self bringSubviewToFront:_backNavigationView];
            
            self.backgroundColor = [UIColor clearColor];
        }
    }
    return self;
}


/**
 * 创建导航条View
 */

-(void)createNavigationView
{
    
    //背景View
    _backNavigationView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreeWidth, 64)];
    _backNavigationView.backgroundColor=[UIColor blackColor];
    [self addSubview:_backNavigationView];
    
    //backButton
    UIButton *backButton=[[UIButton alloc]initWithFrame:CGRectMake(10, 30, 59, 23)];
    [backButton setImage:[UIImage imageNamed:@"返回-.png"] forState:UIControlStateNormal];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_backNavigationView addSubview:backButton];
    
    //label
        _numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, 64, 54)];
    _numberLabel.textColor=[UIColor whiteColor];
        _numberLabel.center = CGPointMake(_backNavigationView.center.x, _backNavigationView.center.y+5);
        _numberLabel.text=[NSString stringWithFormat:@"%d/%ld",_currentIndex+1,(unsigned long)_urlArray.count];
        _numberLabel.textAlignment=NSTextAlignmentCenter;
        [_backNavigationView addSubview:_numberLabel];
    
    
}

-(void)createScrollView
{
    PhotoBrowserScrollView *allScreeenSV=[[PhotoBrowserScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreeWidth, kScreeHeight)];
    allScreeenSV.currenIndex = _currentIndex;

    allScreeenSV.arrayUrl = _urlArray;
    allScreeenSV.tag  = 100;
    allScreeenSV.delegate  = self;
    __weak PhotoBrowserView *BlockSelf =self;
    allScreeenSV.imageClickBlock  = ^{
            if(BlockSelf.backNavigationView.hidden==YES){
                BlockSelf.backNavigationView.hidden=NO;
            }
            else
            {
                BlockSelf.backNavigationView.hidden=YES;
            }
    };
    
    allScreeenSV.zoomChange = ^(CGFloat zoom){
        
        if(zoom<1){
        self.backNavigationView.hidden  =YES;
        }else{
            self.backNavigationView.hidden  =NO;

        }
//        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:zoom/3];

    };

    [self addSubview:allScreeenSV];
}

-(void)backButtonClick:(UIButton *)button
{
    //导航栏显示
//    [[RCNavHidManger hid].vc.navigationController.navigationController setNavigationBarHidden:NO animated:NO];
    [self removeFromSuperview];
//    [RCNavHidManger hid].vc.navigationController.navigationBarHidden=YES;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    if(scrollView.tag == 100){
        int index = scrollView.contentOffset.x/scrollView.frame.size.width;
            _numberLabel.text = [NSString stringWithFormat:@"%d/%ld",(index+1),(unsigned long)_urlArray.count];
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    for (UIView *tempView in scrollView.subviews) {
        if([tempView isKindOfClass:[UIScrollView class]]){
            UIScrollView *sv= (UIScrollView *)tempView;
//            sv.zoomScale = 1.0;
            [sv setZoomScale:1.0 animated:YES];
        }
    }
}
@end
