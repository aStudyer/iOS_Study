//
//  BaseTableHeaderFooterView.m
//  iOS
//
//  Created by aStudyer on 2019/9/10.
//  Copyright © 2019 com.aStudyer. All rights reserved.
//

#import "BaseTableHeaderFooterView.h"

@interface BaseTableHeaderFooterView ()
@property (nonatomic, strong) UIButton *lb_content;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, assign) NSInteger section;
@end
@implementation BaseTableHeaderFooterView

+ (instancetype)headerFooterViewWithTableView:(UITableView *)tableView section:(NSInteger)section{
    NSString *reuseIdentifier = NSStringFromClass([self class]);
    BaseTableHeaderFooterView *headerFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseIdentifier];
    if (!headerFooterView) {
        headerFooterView = [[self alloc] initWithReuseIdentifier:reuseIdentifier];
    }
    headerFooterView.tableView = tableView;
    headerFooterView.section = section;
    headerFooterView.clickBlock = ^(UITableView * _Nonnull tableView, NSInteger section) {
        
    };
    return headerFooterView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.lb_content];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.lb_content.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 1);
    self.lb_content.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
}

- (void)_lb_content_did_click{
    if (self.clickBlock) {
        self.clickBlock(self.tableView, self.section);
    }
}

#pragma mark - Setter
- (void)setContent:(NSString *)content{
    _content = content;
    [self.lb_content setTitle:content forState:(UIControlStateNormal)];
}

#pragma mark - Getter
- (UIButton *)lb_content{
    if (!_lb_content) {
        _lb_content = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _lb_content.backgroundColor = [UIColor colorWithRed:0.776 green:0.804 blue:0.843 alpha:1.00];
        [_lb_content setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        _lb_content.titleLabel.font = [UIFont systemFontOfSize:16 weight:(UIFontWeightBold)];
        [_lb_content addTarget:self action:@selector(_lb_content_did_click) forControlEvents:(UIControlEventTouchUpInside)];
        _lb_content.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _lb_content;
}

@end
