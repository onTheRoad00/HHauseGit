//
//  RCIndex1TableViewCell.h
//  HHause
//
//  Created by HHause on 16/5/23.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^COLL)(NSString *type,NSString * city_cn);
typedef void(^CO)(NSString *houseid,NSString *mls,NSString * city);
@interface RCIndex1TableViewCell : UITableViewCell
@property (nonatomic,copy) COLL COLLBlock;
@property (nonatomic,copy) CO COBlock;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic ,strong) NSArray * arrayCerImages;

@property (nonatomic,copy) NSString * type;
- (void)setArrayCerImages:(NSArray *)arrayCerImages;

@property (weak, nonatomic) IBOutlet UILabel *titleLab;


@end
