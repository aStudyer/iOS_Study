//
//  HHCollectionViewFlowLayout.h
//  iOS
//
//  Created by aStudyer on 2019/9/16.
//  Copyright © 2019 com.aStudyer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class WaterFallLayout;
@protocol WaterFallLayoutDataSource <NSObject>

- (NSUInteger)numbersOfColsInWaterFallLayout:(WaterFallLayout *)layout;

- (CGFloat)waterFallLayout:(WaterFallLayout *)layout heightForItem:(NSInteger)item;

@end

@interface WaterFallLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id<WaterFallLayoutDataSource> dataSource;

@end

NS_ASSUME_NONNULL_END
