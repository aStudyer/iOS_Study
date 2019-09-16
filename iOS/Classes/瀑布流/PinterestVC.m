
//
//  PinterestVC.m
//  iOS
//
//  Created by aStudyer on 2019/9/16.
//  Copyright © 2019 com.aStudyer. All rights reserved.
//

#import "PinterestVC.h"
#import "WaterFallLayout.h"
#import "WaterFallCollectionViewCell.h"

static NSString *const cellID = @"WaterFallCollectionViewCell_ID";

@interface PinterestVC ()<UICollectionViewDataSource, WaterFallLayoutDataSource>
@property (nonatomic, strong) WaterFallLayout *flowLayout;
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation PinterestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
}

#pragma mark - Getter
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.flowLayout];
        _collectionView.dataSource = self;
        [_collectionView registerClass:[WaterFallCollectionViewCell class] forCellWithReuseIdentifier:cellID];
    }
    return _collectionView;
}

- (WaterFallLayout *)flowLayout{
    if (!_flowLayout) {
        _flowLayout = [WaterFallLayout new];
        _flowLayout.minimumLineSpacing = 10;
        _flowLayout.minimumInteritemSpacing = 10;
        _flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        _flowLayout.dataSource = self;
    }
    return _flowLayout;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WaterFallCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    cell.backgroundColor = RandomColor;
    cell.title = [NSString stringWithFormat:@"%zd",indexPath.item];
    return cell;
}

#pragma mark - WaterFallLayoutDataSource
- (NSUInteger)numbersOfColsInWaterFallLayout:(WaterFallLayout *)layout{
    return 3;
}

- (CGFloat)waterFallLayout:(WaterFallLayout *)layout heightForItem:(NSInteger)item{
    return arc4random_uniform(150) + 50;
}

@end
