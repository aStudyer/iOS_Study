//
//  HHCollectionViewFlowLayout.m
//  iOS
//
//  Created by aStudyer on 2019/9/16.
//  Copyright © 2019 com.aStudyer. All rights reserved.
//

#import "WaterFallLayout.h"

@interface WaterFallLayout ()
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *attributes;
@property (nonatomic, strong) NSMutableArray *currentHeights;
@end
@implementation WaterFallLayout
// 1.准备布局
- (void)prepareLayout{
    [super prepareLayout];
    NSAssert(self.dataSource != nil, @"请先设置对应的数据源方法");
    NSUInteger cols = [self.dataSource numbersOfColsInWaterFallLayout:self];
    CGFloat width = (ScreenW - self.sectionInset.left - self.sectionInset.right - (cols - 1) * self.minimumInteritemSpacing) / cols;
    NSUInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (int i = 0; i < count; i++) {
        // 1.根据i创建indexPath
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        // 2.根据indexPath创建对应的UICollectionViewLayoutAttributes
        UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        // 3.设置attribute中的frame
        CGFloat minHeight = [[self.currentHeights valueForKeyPath:@"@min.floatValue"] floatValue];
        NSInteger minIndex = [self.currentHeights indexOfObject:@(minHeight)];
        CGFloat x = self.sectionInset.left + (self.minimumInteritemSpacing + width) * minIndex;
        CGFloat y = minHeight + self.minimumLineSpacing;
        CGFloat height = [self.dataSource waterFallLayout:self heightForItem:i];
        attribute.frame = CGRectMake(x, y, width, height);
        // 4.保存attribute
        [self.attributes addObject:attribute];
        // 5.更新高度
        [self.currentHeights replaceObjectAtIndex:minIndex withObject:@(y + height)];
    }
}

// 2.设置布局
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attributes;
}

// 3.设置contentSize
- (CGSize)collectionViewContentSize{
    return CGSizeMake(ScreenW, [[self.currentHeights valueForKeyPath:@"@max.floatValue"] floatValue] + self.sectionInset.bottom);
}

#pragma mark - Getter
- (NSMutableArray<UICollectionViewLayoutAttributes *> *)attributes{
    if (!_attributes) {
        _attributes = [NSMutableArray array];
    }
    return _attributes;
}

- (NSMutableArray *)currentHeights{
    if (!_currentHeights) {
        _currentHeights = [NSMutableArray arrayWithArray:@[@(self.sectionInset.top), @(self.sectionInset.top), @(self.sectionInset.top)]];
    }
    return _currentHeights;
}

@end
