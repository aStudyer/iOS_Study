//
//  BaseTableViewCell.m
//  iOS
//
//  Created by aStudyer on 2019/9/10.
//  Copyright © 2019 com.aStudyer. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface BaseTableViewCell ()

@property (nonatomic, strong) UILabel *lb_content;

@end
@implementation BaseTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    NSString *reuseIdentifier = NSStringFromClass([self class]);
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[self alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:reuseIdentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.lb_content];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.lb_content.frame = CGRectMake(10, 0, self.frame.size.width, self.frame.size.height);
}

#pragma mark - Setter
- (void)setData:(TableRowModel *)data{
    _data = data;
    self.lb_content.text = _data.title;
}

#pragma mark - Getter
- (UILabel *)lb_content{
    if (!_lb_content) {
        _lb_content = [UILabel new];
        _lb_content.font = [UIFont systemFontOfSize:16];
        _lb_content.textColor = [UIColor blackColor];
    }
    return _lb_content;
}

@end
