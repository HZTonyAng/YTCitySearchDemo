//
//  JJSearchResultTableController.h
//  YTCitySearchDemo
//
//  Created by TonyAng on 16/4/13.
//  Copyright © 2016年 TonyAng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JJSearchResultTableController : UITableViewController

/// 省列表(保存的只是省份的名字)
@property (nonatomic,strong) NSArray *provinceNamesList;
/// 保存搜索结果的省模型
@property (nonatomic,strong) NSArray *resultProvinces;
/// 保存导航控制器
@property (nonatomic,strong) UINavigationController *searchProvinceNav;

@end
