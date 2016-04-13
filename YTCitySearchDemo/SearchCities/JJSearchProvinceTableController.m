//
//  JJSearchProvinceTableController.m
//  YTCitySearchDemo
//
//  Created by TonyAng on 16/4/13.
//  Copyright © 2016年 TonyAng. All rights reserved.
//

#import "JJSearchProvinceTableController.h"
#import "JJCitiesTableViewController.h"
#import "JJSearchResultTableController.h"
#import "JJCitiesModel.h"
#import "MJExtension.h"

static NSString *searchProvinceCellId = @"searchProvinceCellId";

@interface JJSearchProvinceTableController ()<UISearchResultsUpdating,UISearchControllerDelegate,UISearchBarDelegate>

/// 省份数据
@property (nonatomic,strong) NSArray *provincesArray;
/// 搜索条
@property (nonatomic,strong) UISearchController *searchController;
/// 搜索省份的结果
@property (nonatomic,strong) JJSearchResultTableController *searchResultTableVC;
/// 选中的省份模型
@property (nonatomic,strong) NSMutableArray *resultProvinces;

@end

@implementation JJSearchProvinceTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"省份";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:searchProvinceCellId];
  
    self.searchResultTableVC = [[JJSearchResultTableController alloc] initWithStyle:UITableViewStyleGrouped];
    self.searchResultTableVC.searchProvinceNav = self.navigationController;
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:self.searchResultTableVC];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nav];
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.searchController.searchResultsUpdater = self;
    
    self.searchController.delegate = self;
    self.searchController.searchBar.delegate = self;
    self.searchController.searchBar.placeholder = @"请输入您要搜索的省份";
    self.definesPresentationContext = YES;  // 解决headView的高度无法自定义的问题
}



- (NSMutableArray *)resultProvinces {
    if (_resultProvinces == nil) {
        _resultProvinces = [NSMutableArray array];
    }
    return _resultProvinces;
}



-(NSArray *)provincesArray {
    if (_provincesArray == nil) {
        NSArray *dictArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cities.plist" ofType:nil]];
        
        NSMutableArray *mutArr = [NSMutableArray array];
        for (NSDictionary *dict in dictArr) {
            JJCitiesModel *citiesModel = [JJCitiesModel mj_objectWithKeyValues:dict];
            [mutArr addObject:citiesModel];
        }
        _provincesArray = mutArr.copy;
    }
    
    return _provincesArray;
}



#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.provincesArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:searchProvinceCellId forIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [self.provincesArray[indexPath.row] name];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JJCitiesTableViewController *citiesTabelVC = [[JJCitiesTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    citiesTabelVC.citiesArr = [self.provincesArray[indexPath.row] cities];
    
    [self.navigationController pushViewController:citiesTabelVC animated:YES];
}



#pragma mark - 更新搜索结果
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@",self.searchController.searchBar.text];
    
    NSMutableArray *proviceNameList = [NSMutableArray array];
    for (JJCitiesModel *model in self.provincesArray) {
        [proviceNameList addObject:model.name];
    }
    
    
    // arr中存的只有省份的name
    NSArray *arr = [NSArray arrayWithArray:[proviceNameList filteredArrayUsingPredicate:predicate]];
    
    
    for (JJCitiesModel *model in self.provincesArray) {
        for (NSString *provinceName in arr) {
            if ([model.name isEqualToString:provinceName]) {
                [self.resultProvinces addObject:model];
            }
        }
    }
    
    
    self.searchResultTableVC.provinceNamesList = arr;
    self.searchResultTableVC.resultProvinces = self.resultProvinces.copy;
    
    [self.searchResultTableVC.tableView reloadData];
}



#pragma mark - UISearchControllerDelegate代理方法
- (void)didDismissSearchController:(UISearchController *)searchController {
    if (searchController.searchBar.text.length == 0) {
        return;
    }
    [self.resultProvinces removeAllObjects];
}



#pragma mark - UISearchBarDelegate代理方法
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length == 0) {
        return;
    }

    [self.resultProvinces removeAllObjects];
}

@end








