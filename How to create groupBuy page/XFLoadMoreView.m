//
//  XFLoadMoreView.m
//  How to create groupBuy page
//
//  Created by apple on 15/12/16.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "XFLoadMoreView.h"

@interface XFLoadMoreView()
@property (weak, nonatomic) IBOutlet UIButton *loadMoreBtnView;

@property (weak, nonatomic) IBOutlet UIView *loadMoreIngView;

- (IBAction)loadMoreClick;
@end


@implementation XFLoadMoreView

/**
 *  初始化方法
 *
 *  @return load view
 */
+(instancetype) loadMoreView
{
    // 直接从xib中加载view
    XFLoadMoreView *loadView  = [[[NSBundle mainBundle] loadNibNamed:@"XFLoadButton" owner:nil options:nil] lastObject];
    
    // 美化按钮，将按钮的四个角圆润化
    loadView.loadMoreBtnView.layer.cornerRadius = 5;
    loadView.loadMoreBtnView.layer.masksToBounds = YES;
    
    return loadView;
}

// 利用block来进行通知回调的初始化方法
+(instancetype) loadMoreViewWithNotifyBlock:(void (^)(XFLoadMoreView *)) notifyLoadBlock
{
    // 直接从xib中加载view
    XFLoadMoreView *loadView  = [[[NSBundle mainBundle] loadNibNamed:@"XFLoadButton" owner:nil options:nil] lastObject];
    
    // 美化按钮，将按钮的四个角圆润化
    loadView.loadMoreBtnView.layer.cornerRadius = 5;
    loadView.loadMoreBtnView.layer.masksToBounds = YES;
    
    // 设定加载更多回调block
    loadView.notifyLoadBlock = notifyLoadBlock;
    return loadView;
}

/**
 *  点击加载更多按钮后触发
 */
- (IBAction)loadMoreClick {
    // 将botton隐藏让后将加载样式呈现
    self.loadMoreBtnView.hidden = YES;
    self.loadMoreIngView.hidden = NO;
    
    // 使用此方法能够达到延迟执行效果
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        self.loadMoreBtnView.hidden = NO;
        self.loadMoreIngView.hidden = YES;
        
        // 向代理发送信息,由于是代理定义中设置的是可选方法，所以发送信息之前需要检查是否实现了此方法
//        if ([self.delegate respondsToSelector:@selector(loadMoreViewDidClickedToLoadBtn:)])
//        {
//            [self.delegate loadMoreViewDidClickedToLoadBtn:self];
//        }
        
        // 使用回调进行加载通知
        if (nil != self.notifyLoadBlock)
        {
            self.notifyLoadBlock(self);
        }
    });

}
@end
