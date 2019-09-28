//
//  TableSectionModel.h
//  iOS
//
//  Created by aStudyer on 2019/9/10.
//  Copyright © 2019 com.aStudyer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TableRowModel.h"
#import <MJExtension/MJExtension.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableSectionModel : NSObject

@property (nonatomic, copy) NSString *header;

@property (nonatomic, copy) NSString *footer;

@property (nonatomic, assign, getter=isOpened) BOOL open;

@property (nonatomic, copy) NSString *destVC;

@property (nonatomic, assign) NSInteger section;

@property (nonatomic, strong) NSArray<TableRowModel *> *items;

@property (nonatomic, copy) void(^operation)(UITableView *tableView, NSInteger section);

@end

NS_ASSUME_NONNULL_END
