//
//  JJSearchResultTableController.m
//  YTCitySearchDemo
//
//  Created by TonyAng on 16/4/13.
//  Copyright © 2016年 TonyAng. All rights reserved.
//

#import "JJSearchResultTableController.h"
#import "JJCitiesTableViewController.h"
#import "JJCitiesModel.h"


static NSString *searchResultCellId = @"searchResultCellId";

@interface JJSearchResultTableController ()


@end

@implementation JJSearchResultTableController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:searchResultCellId];
}


- (NSArray *)resultProvinces {
    if (_resultProvinces == nil) {
        _resultProvinces = [NSArray array];
    }
    return _resultProvinces;
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.provinceNamesList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:searchResultCellId forIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.provinceNamesList[indexPath.row];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JJCitiesTableViewController *citiesTableVC = [[JJCitiesTableViewController alloc] initWithStyle:UITableViewStyleGrouped];

    citiesTableVC.citiesArr = [self.resultProvinces[indexPath.row] cities];
    [self.searchProvinceNav pushViewController:citiesTableVC animated:YES];
}



- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return 1.0f;
    return 44.0f;
}

@end






