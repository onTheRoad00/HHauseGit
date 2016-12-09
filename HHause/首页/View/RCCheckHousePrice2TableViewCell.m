//
//  RCCheckHousePrice2TableViewCell.m
//  HHause
//
//  Created by HHause on 2016/11/11.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "RCCheckHousePrice2TableViewCell.h"
#import "RCindex2CollectionViewCell.h"
#define reuseIdentifier @"RCindex2CollectionViewCell"
@interface RCCheckHousePrice2TableViewCell ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@end
@implementation RCCheckHousePrice2TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    
    
    UINib * nib=[UINib nibWithNibName:reuseIdentifier bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
    _arrayCerImages =@[@{@"attributes":@"2",
                         @"bedrooms" :@"4",
                         @"built_year" : @"2000",
                         @"city" : @"Thousand Oaks",
                         @"floor_area" :@"2927",
                         @"full_baths" :@"3",
                         @"id" :@"55942",
                         @"mls" :@"216010905",
                         @"partial_baths":@"0",
                         @"preview" :@"FvYDJHqaygnmnS9-SLH5reqozPET",
                         @"price" :@"944500",
                         @"space_area":@"8299",
                         @"title" :@"",
                         @"type":@"H"},
                       @{@"attributes":@"2",
                         @"bedrooms" :@"4",
                         @"built_year" : @"2000",
                         @"city" : @"Thousand Oaks",
                         @"floor_area" :@"2927",
                         @"full_baths" :@"3",
                         @"id" :@"55942",
                         @"mls" :@"216010905",
                         @"partial_baths":@"0",
                         @"preview" :@"FvYDJHqaygnmnS9-SLH5reqozPET",
                         @"price" :@"944500",
                         @"space_area":@"8299",
                         @"title" :@"",
                         @"type":@"H"},
                       @{@"attributes":@"2",
                         @"bedrooms" :@"4",
                         @"built_year" : @"2000",
                         @"city" : @"Thousand Oaks",
                         @"floor_area" :@"2927",
                         @"full_baths" :@"3",
                         @"id" :@"55942",
                         @"mls" :@"216010905",
                         @"partial_baths":@"0",
                         @"preview" :@"FvYDJHqaygnmnS9-SLH5reqozPET",
                         @"price" :@"944500",
                         @"space_area":@"8299",
                         @"title" :@"",
                         @"type":@"H"},
                       @{@"attributes":@"2",
                         @"bedrooms" :@"4",
                         @"built_year" : @"2000",
                         @"city" : @"Thousand Oaks",
                         @"floor_area" :@"2927",
                         @"full_baths" :@"3",
                         @"id" :@"55942",
                         @"mls" :@"216010905",
                         @"partial_baths":@"0",
                         @"preview" :@"FvYDJHqaygnmnS9-SLH5reqozPET",
                         @"price" :@"944500",
                         @"space_area":@"8299",
                         @"title" :@"",
                         @"type":@"H"},
                       @{@"attributes":@"2",
                         @"bedrooms" :@"4",
                         @"built_year" : @"2000",
                         @"city" : @"Thousand Oaks",
                         @"floor_area" :@"2927",
                         @"full_baths" :@"3",
                         @"id" :@"55942",
                         @"mls" :@"216010905",
                         @"partial_baths":@"0",
                         @"preview" :@"FvYDJHqaygnmnS9-SLH5reqozPET",
                         @"price" :@"944500",
                         @"space_area":@"8299",
                         @"title" :@"",
                         @"type":@"H"}];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark ------------------collection----------
- (void)setArrayCerImages:(NSArray *)arrayCerImages{
    //    /数据
    if (arrayCerImages.count>0) {
        _arrayCerImages = arrayCerImages;
    }
    [self.collectionView reloadData];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (CGSize){246*kScreeWidth/375,self.collectionView.frame.size.height};
}
#pragma mark- collectionViewDatasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //    return self.arrayCerImages.count;
    return _arrayCerImages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    RCindex2CollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSDictionary *dic = self.arrayCerImages[indexPath.row];
    NSString * imageUrl = [NSString stringWithFormat:@"%@%@?imageMogr2/thumbnail/%.f",KAPIQINIU,dic[@"preview"],kScreeWidth];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"bg-2"]];
    cell.nameLab.text = [self returnTitleType:dic[@"type"] bedrooms:dic[@"bedrooms"] full_baths:dic[@"full_baths"] partial_baths:dic[@"partial_bath"]];
    cell.descriptionLab.text = [self returndescriptionFlool_area:dic[@"floor_area"] space_area:dic[@"space_area"] built_year:dic[@"built_year"]];
    return cell;
}

#pragma mark- collectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
//    NSDictionary *dic = self.arrayCerImages[indexPath.row];
//    if (self.COLBlock) {
//        self.COLBlock(dic[@"id"],dic[@"mls"],dic[@"city"],[self returnTitleType:dic[@"type"] bedrooms:dic[@"bedrooms"] full_baths:dic[@"full_baths"] partial_baths:dic[@"partial_bath"]],[self returndescriptionFlool_area:dic[@"floor_area"] space_area:dic[@"space_area"] built_year:dic[@"built_year"]]);
//    }
}
-(NSString *)returnTitleType:(NSString *)type bedrooms:(NSString *)bedrooms full_baths:(NSString *)full_baths partial_baths:(NSString *)partial_baths{
    //名字
    NSString * housetype;
    if ([type isEqualToString:@"A"]) {
        housetype = @"公寓";
    }else if ([type isEqualToString:@"H"]){
        housetype = @"独栋别墅";
    }else if ([type isEqualToString:@"T"]){
        housetype = @"联排别墅";
    }else{
        housetype = @"房子";
    }
    return  [NSString stringWithFormat:@"%@室%d卫%@",bedrooms,[full_baths intValue]+[partial_baths intValue],housetype];
}
-(NSString *)returndescriptionFlool_area:(NSString *)floor_area space_area:(NSString *)space_area built_year:(NSString *)built_year{
    
    return  [NSString stringWithFormat:@"建筑%.f㎡,占地%.f㎡,建于%@年",[floor_area intValue]/10.7639104,[space_area intValue]/10.7639104,built_year];
}
@end
