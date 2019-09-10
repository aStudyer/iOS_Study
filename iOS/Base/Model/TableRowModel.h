//
//  TableRowModel.h
//  iOS
//
//  Created by aStudyer on 2019/9/10.
//  Copyright © 2019 com.aStudyer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableRowModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *destVC;

@property (nonatomic, copy) void(^operation)(UITableView *tableView, NSIndexPath *indexPath);

@end

NS_ASSUME_NONNULL_END
