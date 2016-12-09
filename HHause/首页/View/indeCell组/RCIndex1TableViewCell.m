//
//  RCIndex1TableViewCell.m
//  HHause
//
//  Created by HHause on 16/5/23.
//  Copyright © 2016年 HHause. All rights reserved.
//

#import "RCIndex1TableViewCell.h"
#import "RCIndex1CollectionViewCell.h"
#import "RCindex2CollectionViewCell.h"
#import "UIImageView+WebCache.h"
#define reuseIdentifier @"RCIndex1CollectionViewCell"
#define reuseIdentifier1 @"RCindex2CollectionViewCell"
@interface RCIndex1TableViewCell ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@end

@implementation RCIndex1TableViewCell

- (void)awakeFromNib {
    
//    if([_type isEqualToString:@"热门区域"])
//    {
//        
//        _arrayCerImages =@[@{@"city":@"Irvine",
//                             @"city_cn":@"尔湾",
//                             @"image":@"http://media.hhause.com/city/Irvine/1.jpg"},
//                           @{@"city":@"Walnut",
//                             @"city_cn":@"核桃市",
//                             @"image":@"http://media.hhause.com/city/Walnut/1.jpg"},
//                           @{@"city":@"Newport Beach",
//                             @"city_cn":@"纽波特比",
//                             @"image":@"http://media.hhause.com/city/NewportBeach/1.jpg"},
//                           @{@"city":@"Mountain View",
//                             @"city_cn":@"山景城",
//                             @"image":@"http://media.hhause.com/city/MountainView/1.jpg"}];
//       
//    }else if([_type isEqualToString: @"精选好房"]){
//        _arrayCerImages =@[@{@"attributes":@"2",
//                             @"bedrooms" :@"4",
//                             @"built_year" : @"2000",
//                             @"city" : @"Thousand Oaks",
//                             @"floor_area" :@"2927",
//                             @"full_baths" :@"3",
//                             @"id" :@"55942",
//                             @"mls" :@"216010905",
//                             @"partial_baths":@"0",
//                             @"preview" :@"FvYDJHqaygnmnS9-SLH5reqozPET",
//                             @"price" :@"944500",
//                             @"space_area":@"8299",
//                             @"title" :@"",
//                             @"type":@"H"},
//                           @{@"attributes":@"2",
//                             @"bedrooms" :@"4",
//                             @"built_year" : @"2000",
//                             @"city" : @"Thousand Oaks",
//                             @"floor_area" :@"2927",
//                             @"full_baths" :@"3",
//                             @"id" :@"55942",
//                             @"mls" :@"216010905",
//                             @"partial_baths":@"0",
//                             @"preview" :@"FvYDJHqaygnmnS9-SLH5reqozPET",
//                             @"price" :@"944500",
//                             @"space_area":@"8299",
//                             @"title" :@"",
//                             @"type":@"H"},
//                           @{@"attributes":@"2",
//                             @"bedrooms" :@"4",
//                             @"built_year" : @"2000",
//                             @"city" : @"Thousand Oaks",
//                             @"floor_area" :@"2927",
//                             @"full_baths" :@"3",
//                             @"id" :@"55942",
//                             @"mls" :@"216010905",
//                             @"partial_baths":@"0",
//                             @"preview" :@"FvYDJHqaygnmnS9-SLH5reqozPET",
//                             @"price" :@"944500",
//                             @"space_area":@"8299",
//                             @"title" :@"",
//                             @"type":@"H"},
//                           @{@"attributes":@"2",
//                             @"bedrooms" :@"4",
//                             @"built_year" : @"2000",
//                             @"city" : @"Thousand Oaks",
//                             @"floor_area" :@"2927",
//                             @"full_baths" :@"3",
//                             @"id" :@"55942",
//                             @"mls" :@"216010905",
//                             @"partial_baths":@"0",
//                             @"preview" :@"FvYDJHqaygnmnS9-SLH5reqozPET",
//                             @"price" :@"944500",
//                             @"space_area":@"8299",
//                             @"title" :@"",
//                             @"type":@"H"},
//                           @{@"attributes":@"2",
//                             @"bedrooms" :@"4",
//                             @"built_year" : @"2000",
//                             @"city" : @"Thousand Oaks",
//                             @"floor_area" :@"2927",
//                             @"full_baths" :@"3",
//                             @"id" :@"55942",
//                             @"mls" :@"216010905",
//                             @"partial_baths":@"0",
//                             @"preview" :@"FvYDJHqaygnmnS9-SLH5reqozPET",
//                             @"price" :@"944500",
//                             @"space_area":@"8299",
//                             @"title" :@"",
//                             @"type":@"H"}];
      
//    }

    

    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
     self.collectionView.backgroundColor = [UIColor whiteColor];
    
//    _arrayCerImages =@[@{@"attributes":@"2",
//                         @"bedrooms" :@"4",
//                         @"built_year" : @"2000",
//                         @"city" : @"Thousand Oaks",
//                         @"floor_area" :@"2927",
//                         @"full_baths" :@"3",
//                         @"id" :@"55942",
//                         @"mls" :@"216010905",
//                         @"partial_baths":@"0",
//                         @"preview" :@"FvYDJHqaygnmnS9-SLH5reqozPET",
//                         @"price" :@"944500",
//                         @"space_area":@"8299",
//                         @"title" :@"",
//                         @"type":@"H"},
//                       @{@"attributes":@"2",
//                         @"bedrooms" :@"4",
//                         @"built_year" : @"2000",
//                         @"city" : @"Thousand Oaks",
//                         @"floor_area" :@"2927",
//                         @"full_baths" :@"3",
//                         @"id" :@"55942",
//                         @"mls" :@"216010905",
//                         @"partial_baths":@"0",
//                         @"preview" :@"FvYDJHqaygnmnS9-SLH5reqozPET",
//                         @"price" :@"944500",
//                         @"space_area":@"8299",
//                         @"title" :@"",
//                         @"type":@"H"},
//                       @{@"attributes":@"2",
//                         @"bedrooms" :@"4",
//                         @"built_year" : @"2000",
//                         @"city" : @"Thousand Oaks",
//                         @"floor_area" :@"2927",
//                         @"full_baths" :@"3",
//                         @"id" :@"55942",
//                         @"mls" :@"216010905",
//                         @"partial_baths":@"0",
//                         @"preview" :@"FvYDJHqaygnmnS9-SLH5reqozPET",
//                         @"price" :@"944500",
//                         @"space_area":@"8299",
//                         @"title" :@"",
//                         @"type":@"H"},
//                       @{@"attributes":@"2",
//                         @"bedrooms" :@"4",
//                         @"built_year" : @"2000",
//                         @"city" : @"Thousand Oaks",
//                         @"floor_area" :@"2927",
//                         @"full_baths" :@"3",
//                         @"id" :@"55942",
//                         @"mls" :@"216010905",
//                         @"partial_baths":@"0",
//                         @"preview" :@"FvYDJHqaygnmnS9-SLH5reqozPET",
//                         @"price" :@"944500",
//                         @"space_area":@"8299",
//                         @"title" :@"",
//                         @"type":@"H"},
//                       @{@"attributes":@"2",
//                         @"bedrooms" :@"4",
//                         @"built_year" : @"2000",
//                         @"city" : @"Thousand Oaks",
//                         @"floor_area" :@"2927",
//                         @"full_baths" :@"3",
//                         @"id" :@"55942",
//                         @"mls" :@"216010905",
//                         @"partial_baths":@"0",
//                         @"preview" :@"FvYDJHqaygnmnS9-SLH5reqozPET",
//                         @"price" :@"944500",
//                         @"space_area":@"8299",
//                         @"title" :@"",
//                         @"type":@"H"}];
    

    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark ------------------collection----------
- (void)setArrayCerImages:(NSArray *)arrayCerImages{
    
//数据
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

    return _arrayCerImages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([_type isEqualToString:@"精选好房"]) {
        UINib * nib=[UINib nibWithNibName:reuseIdentifier1 bundle:nil];
        [self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier1];
        RCindex2CollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier1 forIndexPath:indexPath];
        NSDictionary *dic = self.arrayCerImages[indexPath.row];
        NSString * imageUrl = [NSString stringWithFormat:@"%@%@?imageMogr2/thumbnail/%.f",KAPIQINIU,dic[@"preview"],kScreeWidth];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"bg-2"]];
        cell.nameLab.text = [self returnTitleType:dic[@"type"] bedrooms:dic[@"bedrooms"] full_baths:dic[@"full_baths"] partial_baths:dic[@"partial_baths"]];
        cell.descriptionLab.text = [self returndescriptionFlool_area:dic[@"floor_area"] space_area:dic[@"space_area"] built_year:dic[@"built_year"]];
        return cell;
    }
    UINib * nib=[UINib nibWithNibName:reuseIdentifier bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
    RCIndex1CollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    //数据
    NSDictionary *dic = self.arrayCerImages[indexPath.row];
    cell.nameLab.text = dic[@"city"];
    cell.CNnameLab.text = dic[@"city_cn"];
    NSString * urlstring =[NSString stringWithFormat:@"%@",dic[@"image"]];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:urlstring] placeholderImage:[UIImage imageNamed:@"bg-2"]];
    
    
    return cell;
}

#pragma mark- collectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    if([_type isEqualToString:@"热门区域"])
    {
    if (self.COLLBlock) {
        self.COLLBlock(self.arrayCerImages[indexPath.row][@"city"],self.arrayCerImages[indexPath.row][@"city_cn"]);
    }
    }else if([_type isEqualToString: @"精选好房"]){
        NSDictionary *dic = self.arrayCerImages[indexPath.row];
        if (self.COBlock) {
            self.COBlock(dic[@"id"],dic[@"mls"],dic[@"city"]);
        }

    }
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
        housetype = @"";
    }
    return  [NSString stringWithFormat:@"%@室%d卫%@",bedrooms,[full_baths intValue]+[partial_baths intValue],housetype];
}
-(NSString *)returndescriptionFlool_area:(NSString *)floor_area space_area:(NSString *)space_area built_year:(NSString *)built_year{
    if ([space_area isEqualToString:@"0"]) {
        return  [NSString stringWithFormat:@"建筑%.f㎡,建于%@年",[floor_area intValue]/10.7639104,built_year];
    }
    return  [NSString stringWithFormat:@"建筑%.f㎡,占地%.f㎡,建于%@年",[floor_area intValue]/10.7639104,[space_area intValue]/10.7639104,built_year];
}

@end
