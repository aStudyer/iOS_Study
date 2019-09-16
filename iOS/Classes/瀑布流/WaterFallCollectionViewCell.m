//
//  WaterFallCollectionViewCell.m
//  iOS
//
//  Created by aStudyer on 2019/9/16.
//  Copyright © 2019 com.aStudyer. All rights reserved.
//

#import "WaterFallCollectionViewCell.h"

@interface WaterFallCollectionViewCell ()
@property (nonatomic, strong) UILabel *lb_content;
@end
@implementation WaterFallCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.lb_content];
    }
    return self;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.lb_content.text = title;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.lb_content.frame = self.bounds;
}

#pragma mark - Getter
- (UILabel *)lb_content{
    if (!_lb_content) {
        _lb_content = [UILabel new];
        _lb_content.textAlignment = NSTextAlignmentCenter;
        _lb_content.font = [UIFont boldSystemFontOfSize:30];
        _lb_content.textColor = [UIColor whiteColor];
    }
    return _lb_content;
}

@end
