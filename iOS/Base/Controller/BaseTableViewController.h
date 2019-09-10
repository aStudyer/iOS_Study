//
//  BaseTableViewController.h
//  iOS
//
//  Created by aStudyer on 2019/9/10.
//  Copyright © 2019 com.aStudyer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableSectionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableViewController : UITableViewController

@property (nonatomic, strong) NSArray<TableSectionModel *> *dataList;

@end

NS_ASSUME_NONNULL_END
