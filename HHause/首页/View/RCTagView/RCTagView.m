//
//  RCTagView.m
//  RCLabel
//
//  Copyright © 2016年 RC. All rights reserved.
//

#import "RCTagView.h"

#import "RCSearchListViewController.h"//本程序
#import "RCTagManger.h"//本程序

#define HORIZONTAL_PADDING 7.0f
#define VERTICAL_PADDING   3.0f
#define LABEL_MARGIN       10.0f
#define BOTTOM_MARGIN      10.0f

///随机颜色
#define RandomColor  [UIColor colorWithRed:random()%255/255.0 green:random()%255/255.0 blue:random()%255/255.0 alpha:1];

@interface RCTagView ()
{
    CGRect _previousFrame;
    int _totalHeight;
    UIButton *_tag;
}

@end

@implementation RCTagView

//初始化方法
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _totalHeight = 0;
        self.frame = frame;
    }
    
    return self;
}


//设置 标签数组
- (void)setArrayTagWithLabelArray:(NSArray *)array {
    //设置frame
    _previousFrame = CGRectZero;
    [array enumerateObjectsUsingBlock:^(NSString*str, NSUInteger idx, BOOL *stop) {
    [self setupBtnWithNSString:str];
    }];
//    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [self setupBtnWithNSString:obj];
//        
//    }];
    ///设置整个View的背景
    if(_RCbackgroundColor){
        
        self.backgroundColor = _RCbackgroundColor;
        
    }else{
        self.backgroundColor=[UIColor whiteColor];
    }
   
}


//初始化按钮

- (void)setupBtnWithNSString:(NSString *)str {
    //初始化按钮
    _tag = [UIButton buttonWithType:UIButtonTypeCustom];
    _tag.frame = CGRectZero;
    if (_RCSignalTagColor) {
        _tag.backgroundColor = _RCSignalTagColor;
    }else {
        _tag.backgroundColor = RandomColor;
    }
    //设置内容水平居中
    _tag.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_tag setTitle:str forState:UIControlStateNormal];
    //设置字体的大小
    _tag.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    _tag.layer.cornerRadius = 1.0;
    _tag.layer.masksToBounds = YES;
    //设置字体的颜色
    UIColor * color = [UIColor blackColor];
    [_tag setTitleColor:color forState:UIControlStateNormal];
    //设置方法
    [_tag addTarget:self action:@selector(clickHandle:) forControlEvents:UIControlEventTouchUpInside];
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]};
    CGSize StrSize = [str sizeWithAttributes:attribute];
    StrSize.width += HORIZONTAL_PADDING * 2;
    StrSize.height += VERTICAL_PADDING *2;
    ///新的 SIZE
    CGRect  NewRect = CGRectZero;
    
    if (_previousFrame.origin.x + _previousFrame.size.width + StrSize.width + LABEL_MARGIN > self.bounds.size.width) {
        
        NewRect.origin = CGPointMake(10, _previousFrame.origin.y + StrSize.height + BOTTOM_MARGIN);
        _totalHeight += StrSize.height + BOTTOM_MARGIN;
    }else {
        NewRect.origin = CGPointMake(_previousFrame.origin.x + _previousFrame.size.width + LABEL_MARGIN, _previousFrame.origin.y);
    }
    NewRect.size = StrSize;
    [_tag setFrame:NewRect];
    _previousFrame = _tag.frame;
    [self setHight:self andHight:_totalHeight + StrSize.height + BOTTOM_MARGIN];
    [self addSubview:_tag];
    ///设置背景 颜色
 

}

#pragma mark-改变控件高度
- (void)setHight:(UIView *)view andHight:(CGFloat)hight
{
    CGRect tempFrame = view.frame;
    tempFrame.size.height = hight;
    view.frame = tempFrame;
}


#pragma mark==========按钮的处理方法

///按钮的处理方法
- (void)clickHandle:(UIButton *)sender{
    UIButton * btn =sender;
//    NSLog(@"%@",btn.titleLabel.text);
    RCSearchListViewController * searchResult =[[RCSearchListViewController alloc]init];
    NSArray * ary = _tagDict[btn.titleLabel.text];
    searchResult.mytitle = btn.titleLabel.text;
    searchResult.metro_area = ary[1];
    searchResult.city = ary[2];
    searchResult.hidesBottomBarWhenPushed = YES;
    [[RCTagManger tag].vc.navigationController pushViewController:searchResult animated:YES];
}


@end
