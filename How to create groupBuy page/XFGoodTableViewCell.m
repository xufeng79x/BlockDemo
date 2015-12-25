//
//  XFGoodTableViewCell.m
//  How to create groupBuy page
//
//  Created by apple on 15/12/15.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "XFGoodTableViewCell.h"
#import "XFGoodModel.h"

@interface XFGoodTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *googImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UILabel *priceView;
@property (weak, nonatomic) IBOutlet UILabel *soldNumView;

@end


@implementation XFGoodTableViewCell

/**
 *  快速以重用的方式快速初始化cell
 *
 *  @param tableView 当前tableview
 *
 *  @return 新建的或者重用的cell
 */
+(instancetype)goodCellWithTableView:(UITableView *)tableView
{
    // 根据可ID进行cell的可重用查找
    static NSString *reuseId = @"goodcell";
    XFGoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    
    // 当没有可重用cell的时候我们需要从xib中加载cell
    if (!cell)
    {
        // 指定xib文件名称，在xib中可以包含很多view，这里我们只有一个cell的view，所以直接取得lastObject
        cell = [[[NSBundle mainBundle] loadNibNamed:@"XFGoodCell" owner:nil options:nil]lastObject];
    }
    
    return cell;
}

/**
 *  设定当前cell的数据，同时设定cell中各个空间的值
 *
 *  @param goodInfo <#goodInfo description#>
 */
-(void) setGoodInfo:(XFGoodModel *)goodInfo
{
    _goodInfo = goodInfo;
    
    self.googImageView.image = [UIImage imageNamed:goodInfo.image];
    self.nameView.text = goodInfo.name;
    self.priceView.text = [NSString stringWithFormat:@"￥  %ld", (long)goodInfo.price];
    self.soldNumView.text = [NSString stringWithFormat:@"已经售出 %ld 份", (long)goodInfo.soldNum];  
}

@end
