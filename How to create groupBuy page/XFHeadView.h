//
//  XFHeadView.h
//  How to create groupBuy page
//
//  Created by apple on 15/12/17.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XFHeadView : UIView

// 需要显示的所有图片信息
@property (nonatomic, strong) NSArray *pictsList;

// 类创建方法
+(instancetype) headViewInit;
@end
