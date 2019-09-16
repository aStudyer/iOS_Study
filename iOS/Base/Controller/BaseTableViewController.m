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
}

- (void)setDataList:(NSArray<TableSectionModel *> *)dataList{
    _dataList = dataList;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    TableSectionModel *sectionModel = self.dataList[section];
    sectionModel.section = section;
    return sectionModel.isOpened ? sectionModel.items.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseTableViewCell *cell = [BaseTableViewCell cellWithTableView:tableView];
    
    TableSectionModel *sectionModel = self.dataList[indexPath.section];
    TableRowModel *rowModel = sectionModel.items[indexPath.row];
    rowModel.indexPath = indexPath;
    
    cell.data = rowModel;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    TableSectionModel *sectionModel = self.dataList[indexPath.section];
    TableRowModel *rowModel = sectionModel.items[indexPath.row];
    if (rowModel.destVC.length) {
        UIViewController *destVC = nil;
        @try {
            destVC = [UIStoryboard storyboardWithName:rowModel.destVC bundle:nil].instantiateInitialViewController;
        } @catch (NSException *exception) {
            destVC = [[NSClassFromString(rowModel.destVC) alloc] init];
        } @finally {
            if (destVC) {
                destVC.title = rowModel.title;
                [self.navigationController pushViewController:destVC animated:YES];
            }
        }
    }else if (rowModel.operation){
        rowModel.operation(tableView, indexPath);
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    TableSectionModel *sectionModel = self.dataList[section];
    if (sectionModel.header.length) {
        BaseTableHeaderFooterView *headerView = [BaseTableHeaderFooterView headerFooterViewWithTableView:tableView section:section];
        headerView.content = sectionModel.header;
        @weakify(self);
        headerView.clickBlock = ^(UITableView * _Nonnull tableView, NSInteger section) {
            @strongify(self);
            TableSectionModel *sectionModel = self.dataList[section];
            if (sectionModel.destVC.length) {
                UIViewController *destVC = nil;
                @try {
                    destVC = [UIStoryboard storyboardWithName:sectionModel.destVC bundle:nil].instantiateInitialViewController;
                } @catch (NSException *exception) {
                    destVC = [[NSClassFromString(sectionModel.destVC) alloc] init];
                } @finally {
                    if (destVC) {
                        destVC.title = sectionModel.header;
                        [self.navigationController pushViewController:destVC animated:YES];
                    }
                }
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

@end
