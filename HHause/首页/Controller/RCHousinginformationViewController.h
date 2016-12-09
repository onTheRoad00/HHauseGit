//
//  RCHousinginformationViewController.h
//  HHause
//
//  Created by HHause on 16/5/4.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^FAV1)(BOOL selected1);
@interface RCHousinginformationViewController : UIViewController
 @property (nonatomic,copy)FAV1 favBlock1;




@property (nonatomic,copy) NSString * houseId;
@property (nonatomic,copy) NSString * mls;
@property (nonatomic,copy) NSString * city;
@property (nonatomic,copy) NSString * price;
@property (nonatomic,copy) NSString * cdup;

@end
