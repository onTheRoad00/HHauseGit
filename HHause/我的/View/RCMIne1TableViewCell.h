//
//  RCMIne1TableViewCell.h
//  HHause
//
//  Created by HHause on 16/6/22.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^COLL)(NSString *type);

@interface RCMIne1TableViewCell : UITableViewCell

@property (nonatomic,copy) COLL COLLBlock;

@property (weak, nonatomic) IBOutlet UILabel *cellTitleLab;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic ,strong) NSArray * arrayCerImages;

//- (void)setArrayCerImages:(NSArray *)arrayCerImages;
@end
