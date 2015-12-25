//
//  XFLoadMoreView.h
//  How to create groupBuy page
//
//  Created by apple on 15/12/16.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

// 创建按钮点击的处理协议
@class XFLoadMoreView;
//@protocol XFLoadMoreViewDelegate <NSObject>
//
///**
// *  当按钮点击后通知代理实现对象
// *
// *  @param loadMoreView 触发者本身
// */
//@optional
//-(void) loadMoreViewDidClickedToLoadBtn:(XFLoadMoreView *) loadMoreView;
//
//@end

@interface XFLoadMoreView : UIView

// 代理属性，指向显示了此代理的对象，防止循环引用需要使用weak属性参数
//@property (nonatomic,weak) id<XFLoadMoreViewDelegate> delegate;

 // 定义通知回调
@property(nonatomic,strong) void (^notifyLoadBlock)(XFLoadMoreView *);
/**
 *  类初始化方法
 *
 *  @return 对象
 */
+(instancetype) loadMoreView;

/**
 *  类初始化方法+回调通知block
 *
 *  @return 对象
 */
+(instancetype) loadMoreViewWithNotifyBlock:(void (^)(XFLoadMoreView *)) notifyLoadBlock;

@end
