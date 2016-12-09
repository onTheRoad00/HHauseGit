//
//  RCIndexBtnTableViewCell.h
//  HHause
//
//  Created by HHause on 16/5/22.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^BTN)(NSString *type);
@interface RCIndexBtnTableViewCell : UITableViewCell
@property (nonatomic,copy) BTN btnBlock;
- (IBAction)SchoolEstate:(id)sender;



@end
