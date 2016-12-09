//
//  RCHouseTableViewCell.h
//  HHause
//
//  Created by HHause on 16/5/4.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^FAV)(BOOL selected);
@interface RCHouseTableViewCell : UITableViewCell
@property (nonatomic,copy)FAV favBlock;
@property (weak, nonatomic) IBOutlet UIButton *IsMyFavorBtn;
- (IBAction)IsMyFavorBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *houseImage;
@property (weak, nonatomic) IBOutlet UILabel *houseNameLab;
@property (weak, nonatomic) IBOutlet UILabel *favLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *flool_areaLab;
@property (weak, nonatomic) IBOutlet UILabel *built_yearLab;
@property (weak, nonatomic) IBOutlet UIView *bgView;


@end
