//
//  XFGoodTableViewCell.h
//  How to create groupBuy page
//
//  Created by apple on 15/12/15.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XFGoodModel;

@interface XFGoodTableViewCell : UITableViewCell

@property(nonatomic,strong) XFGoodModel *goodInfo;

+(instancetype) goodCellWithTableView:(UITableView *) tableView;


@end
