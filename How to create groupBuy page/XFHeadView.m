//
//  XFHeadView.m
//  How to create groupBuy page
//
//  Created by apple on 15/12/17.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "XFHeadView.h"

@interface XFHeadView()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollerView;
@property (weak, nonatomic) IBOutlet UIPageControl *indexView;

// 计算使用变量
@property(nonatomic,assign) CGSize scrollViewSize;

// 自动滚动timer
@property(nonatomic, strong) NSTimer *timer;

@end

@implementation XFHeadView
+(instancetype) headViewInit;
{
    // 从xib文件中加载 view
    XFHeadView * headView = [[[NSBundle mainBundle] loadNibNamed:@"XFHeadView" owner:nil options:nil]lastObject];
    
    // 设定尺寸的计算变量
    headView.scrollViewSize = headView.scrollerView.bounds.size;
    
    // 设定scrollerView的代理为当前view对象
    headView.scrollerView.delegate = headView;
    
    // 设定一些固定的控件配置
    // 禁止纵向滚动
    headView.scrollerView.showsHorizontalScrollIndicator = NO;
    
    // 分页显示
    headView.scrollerView.pagingEnabled = YES;
    
    // 返回
    return headView;
}


-(void)addAutoNextPageTimer
{
    // 如果已有timer在运行则将其停止销毁
    if  (self.timer != nil && self.timer.isValid)
    {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    // 新建timer
    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    self.timer = timer;
    
    // 将此timer加入到主loop中去,并设定NSRunLoopCommonModes，防止在主loop中阻塞
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:timer forMode: NSRunLoopCommonModes];
}

/**
 *  滚动到下一页
 */
-(void)nextPage
{
    // 设定pageControl,在这里不这是pageControl变量的值，这个值到代理方法中计算
    NSInteger page = self.indexView.currentPage;
    if (page == self.indexView.numberOfPages - 1) {
        page = 0;
    }
    else{
        page++;
    }
    
    /**
     *  根据当前页码来控制scroll的off位置，去显示正确的图片
     */
    CGFloat offsetX = page * self.scrollerView.frame.size.width;
    
    [UIView animateWithDuration:1.0 animations:^{
        self.scrollerView.contentOffset = CGPointMake(offsetX, 0);
    }];
}

/**
 *  设定图片信息
 *
 *  @param pictsList pictsList description
 */
-(void) setPictsList:(NSArray *)pictsList
{
    _pictsList = pictsList;
    
    // 设定UIPageControl
    self.indexView.numberOfPages = pictsList.count;
    self.indexView.currentPage = 0;
    
    // 首先需要将将scrollView上所有字view，也就是全部图片清除
    [self.scrollerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // 设定需要加载的图片
    for (int i = 0; i < pictsList.count; i++)
    {
        // 创建图片空间
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.scrollerView addSubview:imageView];
        
        // 设定图片
        NSString *imageName = pictsList[i];
        imageView.image = [UIImage imageNamed:imageName];
        
        // 设定在scrollView中每一张图的排版
        CGFloat x  = i * self.scrollViewSize.width;
        imageView.frame = CGRectMake(x, 0, self.scrollViewSize.width, self.scrollViewSize.height);
    }
    
    // 设置滚动空间的滚动范围,只有横向滚动，无纵向滚动
    self.scrollerView.contentSize = CGSizeMake(pictsList.count * self.scrollViewSize.width, 0);
    
    // 开始自动滚动
    [self addAutoNextPageTimer];
}

#pragma mark --scrollView的代理方法

// 正在滚动
- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 计算pageControl的值
    int page = (self.scrollerView.contentOffset.x + self.scrollerView.frame.size.width / 2) / self.scrollerView.frame.size.width;
    self.indexView.currentPage = page;
}


// 当点住scrollView不让图片自动滚动的时候停止自动化timer
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate];
    self.timer = nil;
}

// 拖拽结束
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addAutoNextPageTimer];
}


@end
