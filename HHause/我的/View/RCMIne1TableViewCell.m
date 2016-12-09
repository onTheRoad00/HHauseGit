//
//  RCMIne1TableViewCell.m
//  HHause
//
//  Created by HHause on 16/6/22.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "RCMIne1TableViewCell.h"
#import "RCMine1CollectionViewCell.h"
#import "UIImageView+WebCache.h"
#define reuseIdentifier @"RCMine1CollectionViewCell"
@interface RCMIne1TableViewCell ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@end

@implementation RCMIne1TableViewCell

- (void)awakeFromNib {
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    UINib * nib=[UINib nibWithNibName:reuseIdentifier bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark ------------------collection----------
//- (void)setArrayCerImages:(NSArray *)arrayCerImages{
//    _arrayCerImages = arrayCerImages;
//    
//    NSLog(@"%@",_arrayCerImages);
//    
//    
//    [self.collectionView reloadData];
//}

#pragma mark- collectionViewDatasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //    return self.arrayCerImages.count;
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RCMine1CollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    //    NSDictionary *dic = self.arrayCerImages[indexPath.row];
    //    NSString * string = dic[@"fileUrl"];
    //    cell.imageView.backgroundColor = [UIColor grayColor];
    //    [cell.imageView setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@""]];
    
    cell.imageView.image = [UIImage imageNamed:_arrayCerImages[indexPath.row]];
    
    
    return cell;
}

#pragma mark- collectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    if (self.COLLBlock) {
        self.COLLBlock(@"房源名字id");
    }
}

@end
