//
//  UIScrollView+AVRefreshExtension.h
//  AVRefreshExtension
//
//  Created by 周济 on 16/1/13.
//  Copyright © 2016年 swiftTest. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AVRefresh;
@interface UIScrollView (AVRefreshExtension)
// 给scrollView添加上下拉控件
@property (nonatomic, strong) AVRefresh *av_header;
@property (nonatomic, strong) AVRefresh *av_footer;
@end
