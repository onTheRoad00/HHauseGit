//
//  RCSRDZ3TableViewCell.h
//  私人订制Demo
//
//  Created by HHause on 16/6/27.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCSRDZ3TableViewCell : UITableViewCell
typedef void(^SPECIAL) (NSString *specialStr);
- (IBAction)specialBtn:(id)sender;
@property (copy,nonatomic) SPECIAL specialBlock;
@end
