//
//  RCIndex2TableViewCell.h
//  HHause
//
//  Created by HHause on 16/5/23.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^COL)(NSString *houseid,NSString *mls,NSString * city,NSString * shareTitle,NSString *shareSummary);
@interface RCIndex2TableViewCell : UITableViewCell
@property (nonatomic,copy) COL COLBlock;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic ,strong) NSArray * arrayCerImages;
- (void)setArrayCerImages:(NSArray *)arrayCerImages;
@end
