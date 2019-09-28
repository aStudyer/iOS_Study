//
//  BaseTableViewController.m
//  iOS
//
//  Created by aStudyer on 2019/9/10.
//  Copyright © 2019 com.aStudyer. All rights reserved.
//

#import "BaseTableViewController.h"
#import "BaseTableViewCell.h"
#import "BaseTableHeaderFooterView.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [UIView new];
    
    NSString *fileName = [NSString stringWithFormat:@"%@.plist", NSStringFromClass(self.class)];
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        self.dataList = [TableSectionModel mj_objectArrayWithFilename:fileName];
    }
    
    [self.dataList enumerateObjectsUsingBlock:^(TableSectionModel * _Nonnull sectionItem, NSUInteger sectionIndex, BOOL * _Nonnull stop) {
        NSString *sectionSelectorName = [NSString stringWithFormat:@"section_%02zd:",sectionIndex];
        SEL sectionSelector = NSSelectorFromString(sectionSelectorName);
        if ([self respondsToSelector:sectionSelector]) {
            [self performSelectorOnMainThread:NSSelectorFromString(sectionSelectorName) withObject:sectionItem waitUntilDone:NO];
        }else{
            NSLog(@"尚未实现方法:%@",sectionSelectorName);
        }
        [sectionItem.items enumerateObjectsUsingBlock:^(TableRowModel * _Nonnull rowItem, NSUInteger rowIndex, BOOL * _Nonnull stop) {
            NSString *rowSelectorName = [NSString stringWithFormat:@"row_%02zd_%02zd:",sectionIndex, rowIndex];
            SEL rowSelector = NSSelectorFromString(rowSelectorName);
            if ([self respondsToSelector:rowSelector]) {
                [self performSelectorOnMainThread:NSSelectorFromString(rowSelectorName) withObject:rowItem waitUntilDone:NO];
            }else{
                NSLog(@"尚未实现方法:%@",rowSelectorName);
            }
        }];
    }];
    
    NSLog(@"Welcome to %@", NSStringFromClass(self.class));
}

- (void)dealloc{
    NSLog(@"%@ is dealloc", NSStringFromClass(self.class));
}

- (void)setDataList:(NSArray<TableSectionModel *> *)dataList{
    [dataList enumerateObjectsUsingBlock:^(TableSectionModel * _Nonnull sectionItem, NSUInteger sectionIndex, BOOL * _Nonnull stop) {
        sectionItem.section = sectionIndex;
        NSMutableArray *items = [NSMutableArray arrayWithArray:sectionItem.items];
        [sectionItem.items enumerateObjectsUsingBlock:^(TableRowModel * _Nonnull rowItem, NSUInteger rowIndex, BOOL * _Nonnull stop) {
            if (!rowItem.title.length) {
                [items removeObject:rowItem];
            }else{
                rowItem.indexPath = [NSIndexPath indexPathForRow:rowIndex inSection:sectionIndex];
            }
        }];
        sectionItem.items = items;
    }];
    _dataList = dataList;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    TableSectionModel *sectionModel = self.dataList[section];
    return sectionModel.isOpened ? sectionModel.items.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseTableViewCell *cell = [BaseTableViewCell cellWithTableView:tableView];
    
    TableSectionModel *sectionModel = self.dataList[indexPath.section];
    TableRowModel *rowModel = sectionModel.items[indexPath.row];
    
    cell.data = rowModel;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    TableSectionModel *sectionModel = self.dataList[indexPath.section];
    TableRowModel *rowModel = sectionModel.items[indexPath.row];
    
    if (rowModel.destVC.length) {
        [self jumpToDestVC:rowModel.destVC title:rowModel.title];
    }else if (rowModel.operation){
        rowModel.operation(tableView, indexPath);
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    TableSectionModel *sectionModel = self.dataList[section];
    if (sectionModel.header.length) {
        BaseTableHeaderFooterView *headerView = [BaseTableHeaderFooterView headerFooterViewWithTableView:tableView section:section];
        headerView.content = sectionModel.header;
        __weak typeof(self) weakself = self;
        headerView.clickBlock = ^(UITableView * _Nonnull tableView, NSInteger section) {
            __strong typeof(weakself) self = weakself;
            TableSectionModel *sectionModel = self.dataList[section];
            if (sectionModel.destVC.length) {
                [self jumpToDestVC:sectionModel.destVC title:sectionModel.header];
            }else if (sectionModel.operation) {
                sectionModel.operation(tableView, section);
            }else {
                sectionModel.open = !sectionModel.isOpened;
                [tableView reloadData];
            }
        };
        return headerView;
    }else{
        return nil;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    TableSectionModel *sectionModel = self.dataList[section];
    if (sectionModel.footer.length) {
        BaseTableHeaderFooterView *footerView = [BaseTableHeaderFooterView headerFooterViewWithTableView:tableView section:section];
        footerView.content = sectionModel.footer;
        return footerView;
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    TableSectionModel *sectionModel = self.dataList[section];
    return sectionModel.header.length ? 40 : CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    TableSectionModel *sectionModel = self.dataList[section];
    return sectionModel.footer.length ? 40 : CGFLOAT_MIN;
}

#pragma mark - Utils
- (void)jumpToDestVC:(NSString *)destVC title:(NSString *)title{
    UIViewController *destViewController = nil;
    if ([[NSBundle mainBundle] pathForResource:destVC ofType:@"storyboard"]) {
        destViewController = [UIStoryboard storyboardWithName:destVC bundle:nil].instantiateInitialViewController;
    }else{
        destViewController = [[NSClassFromString(destVC) alloc] init];
    }
    destViewController.title = title;
    [self.navigationController pushViewController:destViewController animated:YES];
}

@end
