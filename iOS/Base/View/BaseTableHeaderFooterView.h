//
//  BaseTableHeaderFooterView.h
//  iOS
//
//  Created by aStudyer on 2019/9/10.
//  Copyright © 2019 com.aStudyer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableHeaderFooterView : UITableViewHeaderFooterView

+ (instancetype)headerFooterViewWithTableView:(UITableView *)tableView section:(NSInteger)section;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) void(^clickBlock)(UITableView *tableView, NSInteger section);

@end

NS_ASSUME_NONNULL_END
