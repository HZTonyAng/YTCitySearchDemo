//
//  JJCitiesTableViewController.m
//  YTCitySearchDemo
//
//  Created by TonyAng on 16/4/13.
//  Copyright © 2016年 TonyAng. All rights reserved.
//

#import "JJCitiesTableViewController.h"


static NSString *citiesCellId = @"citiesCellId";

@interface JJCitiesTableViewController ()


@end

@implementation JJCitiesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"城市";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:citiesCellId];
    
    
}


- (void)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.citiesArr.count;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:citiesCellId forIndexPath:indexPath];

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.citiesArr[indexPath.row];
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *str = self.citiesArr[indexPath.row];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"cityName" object:self userInfo:@{@"cityName":str}];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return 1.0f;
    return 44.0f;
}

@end









