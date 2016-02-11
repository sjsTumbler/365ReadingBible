//
//  SJSListTableViewCell.m
//  Reading365
//
//  Created by SunJishuai on 16/2/11.
//  Copyright (c) 2016年 SunJishuai. All rights reserved.
//

#import "SJSListTableViewCell.h"

@implementation SJSListTableViewCell
{
    IndexingModel * _indexModel;
}

- (void)awakeFromNib {
    
}
- (void)setCellByModel:(IndexingModel *)model {
    
    [[self.contentView viewWithTag:10089]removeFromSuperview];
    _indexModel = model;
    int lines = [model.TOTALNUM intValue]/6+ (([model.TOTALNUM intValue]<6)?1:0);
    // 1.实例化布局模式
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 2.设置item大小
    [layout setItemSize:CGSizeMake(50, 50)];
    [layout setMinimumLineSpacing:0.0];
    [layout setMinimumInteritemSpacing:0.0];
    // 3.设置布局方向(默认纵向)
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    // 4.实例化collectionView
    UICollectionView *cv = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 0,viewWidth-20, 50*lines) collectionViewLayout:layout];
    cv.backgroundColor = [UIColor clearColor];
    cv.tag = 10089;
    // 5.设置协议代理者
    cv.delegate = self;
    cv.dataSource = self;
    // 6.注册item
    [cv registerClass:[SJSListCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    // 7.加入到view中
    [self.contentView addSubview:cv];
    [cv reloadData];
}
// 设置有多少个分组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

// 设置一个分组中有多少item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_indexModel.TOTALNUM intValue];
}

// item方法
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"cell";
    SJSListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellName forIndexPath:indexPath];
    cell.numberLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedCollectionIndex:)]) {
        [self.delegate didSelectedCollectionIndex:indexPath];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
