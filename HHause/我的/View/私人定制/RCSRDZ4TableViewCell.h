//
//  RCSRDZ4TableViewCell.h
//  私人订制Demo
//
//  Created by HHause on 16/6/27.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCSRDZ4TableViewCell : UITableViewCell
typedef void(^TEXT)(NSString *str);
@property (strong, nonatomic) IBOutlet UIImageView *titleImageView;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic,copy) TEXT beginBlock;
@property (nonatomic,copy) TEXT endBlock;
@end
