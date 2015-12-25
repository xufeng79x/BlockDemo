//
//  XFGoodModel.m
//  How to create groupBuy page
//
//  Created by apple on 15/12/15.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "XFGoodModel.h"

@implementation XFGoodModel
- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init])
    {
        // 利用字典来进行属性初始化
        [self setValuesForKeysWithDictionary:dic];
    }
    
    return self;
}

+ (instancetype)goodWithDic:(NSDictionary *)dic
{
    return [[self alloc] initWithDic:dic];
}

+ (NSMutableArray *)goodsList
{
    // 加载plist
    NSString *path = [[NSBundle mainBundle] pathForResource:@"goods" ofType:@"plist"];
    NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
    
    // 字典转模型
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSDictionary *dic in dictArray)
    {
        XFGoodModel *good = [XFGoodModel goodWithDic:dic];
        [tempArray addObject:good];
    }
    return tempArray;
}

@end
