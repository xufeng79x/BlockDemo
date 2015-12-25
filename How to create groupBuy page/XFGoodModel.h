//
//  XFGoodModel.h
//  How to create groupBuy page
//
//  Created by apple on 15/12/15.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFGoodModel : NSObject
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *image;
@property (nonatomic,assign) NSInteger price;
@property (nonatomic,assign) NSInteger soldNum;

- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)goodWithDic:(NSDictionary *)dic;

+ (NSMutableArray *)goodsList;
@end
