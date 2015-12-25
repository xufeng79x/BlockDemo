//
//  XFGoodsShowsViewController.m
//  How to create groupBuy page
//
//  Created by apple on 15/12/15.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "XFGoodsShowsViewController.h"
#import "XFGoodModel.h"
#import "XFGoodTableViewCell.h"
#import "XFLoadMoreView.h"
#import "XFHeadView.h"

//@interface XFGoodsShowsViewController () <UITableViewDataSource, XFLoadMoreViewDelegate>
@interface XFGoodsShowsViewController () <UITableViewDataSource>
// 通知接受方法
-(void) loadMoreViewDidClickedToLoadBtn:(XFLoadMoreView *) loadMoreView;

@property (weak, nonatomic) IBOutlet UITableView *goodsTableView;

/**
 *  数据源
 */
@property (nonatomic,strong) NSMutableArray *goodsList;

@end

@implementation XFGoodsShowsViewController

/**
 *  懒加载plist信息
 */
-(NSMutableArray *)goodsList
{
    // 如果未空就进行加载
    if(!_goodsList)
    {
        _goodsList = [XFGoodModel goodsList];
    }
    
    return _goodsList;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    XFHeadView *headView = [XFHeadView headViewInit];
    
    headView.pictsList = @[@"headimage_01", @"headimage_02", @"headimage_03", @"headimage_04"];
    
    self.goodsTableView.tableHeaderView = headView;
    
    
    // 指定tableview的数据代理
    self.goodsTableView.dataSource = self;
    
    // 加载tableView的footview
    XFLoadMoreView *loadMoreView = [XFLoadMoreView loadMoreViewWithNotifyBlock:^(XFLoadMoreView * view){
        [self loadMoreViewDidClickedToLoadBtn:view];
    }];
    
    // 设定view的代理为当前对象，时间发生后将通知当前对象
    // loadMoreView.delegate = self;
    
    // 设定tableview的foot view属性
    self.goodsTableView.tableFooterView = loadMoreView;
    
}


#pragma 重写代理方法

//返回总数据量
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 1.加载xib取得cell定义
    XFGoodTableViewCell *cell = [XFGoodTableViewCell goodCellWithTableView:tableView];
    // 2.设定cell数据
    cell.goodInfo = self.goodsList[indexPath.row];
    // 3.返回cell
    return cell;
    
}

// 加载cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.goodsList.count;
}

#pragma 重写foot view的代理方法
// 加载按钮按下后通知到此对象调用此方法
-(void) loadMoreViewDidClickedToLoadBtn:(XFLoadMoreView *) loadMoreView
{
    // 这里我们模拟增加一个团购的信息，插入到列表的最好一行
    XFGoodModel *model = [[XFGoodModel alloc] init];
    model.image = @"image.jpg";
    model.name = @"new food";
    model.price = 123;
    model.soldNum = 321;
    
    // 将次信息插入到表数据源中
    [self.goodsList addObject:model];
    
    // 需要将此数据塞入table的最后一行
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.goodsList.count - 1 inSection:0];\
    [self.goodsTableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    
    // 加载完毕后将table滚到新加入的行那里，也就是最后一条
    [self.goodsTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}


@end
