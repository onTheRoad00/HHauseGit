//
//  RCFYJSTableViewCell.h
//  HHause
//
//  Created by SeeYou on 16/5/15.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^BTN)(BOOL selected);
typedef void(^METRIC)(BOOL METRICSelected);

@interface RCFYJSTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *houseDescription;
@property (nonatomic,copy) BTN btnBlock;
@property (nonatomic,copy) METRIC metic_ConversionBlock;

//自定义block方法
- (void)handlerButtonAction:(BTN)block;



@property (weak, nonatomic) IBOutlet UIButton *metric_ConversionsBtn;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *est_rentLab;
@property (weak, nonatomic) IBOutlet UILabel *space_areaLab;
@property (weak, nonatomic) IBOutlet UILabel *floor_number;
@property (weak, nonatomic) IBOutlet UILabel *built_yearLab;
@property (weak, nonatomic) IBOutlet UILabel *price_sqftLab;
@property (weak, nonatomic) IBOutlet UILabel *bedroomsLab;
@property (weak, nonatomic) IBOutlet UILabel *bathsLab;
@property (weak, nonatomic) IBOutlet UILabel *hoa_feeLab;
@property (weak, nonatomic) IBOutlet UILabel *tax_rate;
@property (weak, nonatomic) IBOutlet UILabel *parking_placeLab;
@property (weak, nonatomic) IBOutlet UILabel *rateLab;

- (IBAction)readmoreBtn:(id)sender;
- (IBAction)metric_ConversionsBtn:(id)sender;

@end
