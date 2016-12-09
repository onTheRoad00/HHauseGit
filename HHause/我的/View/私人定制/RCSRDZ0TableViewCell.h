//
//  RCSRDZ0TableViewCell.h
//  私人订制Demo
//
//  Created by HHause on 16/7/1.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCSRDZ0TableViewCell : UITableViewCell
typedef void(^TIME)(NSString *,NSString *);
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UIButton *endBtn;
@property (nonatomic,copy) TIME timeBlock;
- (IBAction)startBtn:(id)sender;
- (IBAction)endBtn:(id)sender;


@end
