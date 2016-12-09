//
//  RCTagView.h
//  RCLabel
//
//  Copyright © 2016年 RC. All rights reserved.
//
#import <UIKit/UIKit.h>

/**
 *  使用
 *  1.在使用的时候直接创建RCTagView控件，自定义控件的frame (origin,width)高度随着传入的数组的变量变化自适应
 *  2.保留了几个属性 方便使用者定义控件的的背景颜色RCbackgroundColor，RCSignalTagColor
 *  3.在定义好JCTagView控件后，一定要调用 “标签文本这个方法”
 *
 *  
 */

@interface RCTagView : UIView


///设置整个View的背景颜色
@property (nonatomic, retain) UIColor *RCbackgroundColor;


/**
 *  设置单一颜色
 */

@property (nonatomic) UIColor *RCSignalTagColor;


/**
 *  标签 文本赋值
 */

- (void)setArrayTagWithLabelArray:(NSArray *)array;

/**
 *  数组HHause 专用...以标签文本为Key的字典
 */
@property (nonatomic,copy) NSDictionary * tagDict;
@end
