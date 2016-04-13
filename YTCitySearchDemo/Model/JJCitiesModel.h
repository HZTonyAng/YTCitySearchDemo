//
//  JJCitiesModel.h
//  YTCitySearchDemo
//
//  Created by TonyAng on 16/4/13.
//  Copyright © 2016年 TonyAng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JJCitiesModel : NSObject

/// 城市数组
@property (nonatomic,strong) NSArray *cities;
/// 城市名字
@property (nonatomic,copy) NSString *name;

@end
