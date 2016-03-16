//
//  AVRefresh.h
//  AVRefreshExtension
//
//  Created by 周济 on 16/1/14.
//  Copyright © 2016年 swiftTest. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,AVRefreshType) {
    AVRefreshTypeFooter = 0,
    AVRefreshTypeHeader,
};

typedef NS_ENUM(NSUInteger,AVRefreshState) {
    AVRefreshStateNormal = 0,
    AVRefreshStateWillRefreshing,
    AVRefreshStateRefresing,
    AVRefreshStateNoticeNoMoreData,
};


/** 进入刷新状态的回调 */
typedef void (^AVRefreshRefreshingBlock)();


@interface AVRefresh : UIView

@property (nonatomic, copy  ) AVRefreshRefreshingBlock footerRefreshingBlock;
@property (nonatomic, copy  ) AVRefreshRefreshingBlock headerRefreshingBlock;
@property (nonatomic, assign) AVRefreshType            refreshType;
@property (nonatomic, assign) AVRefreshState           headerRefreshState;
@property (nonatomic, assign) AVRefreshState           footerRefreshState;
@property (nonatomic, copy  ) NSString                 *endWithNoMoreDataDescription;
/**
 *  上拉控件初始化方法
 */
- (instancetype)initFooterWithScrollView:(UIScrollView *)scrollView footerRefreshingBlock:(AVRefreshRefreshingBlock)block;
+ (instancetype)footerRefreshWithScrollView:(UIScrollView *)scrollView footerRefreshingBlock:(AVRefreshRefreshingBlock)block;
/**
 *  下拉控件初始化方法
 */
- (instancetype)initHeaderWithScrollView:(UIScrollView *)scrollView headerRefreshingBlock:(AVRefreshRefreshingBlock)block;
+ (instancetype)headerRefreshWithScrollView:(UIScrollView *)scrollView headerRefreshingBlock:(AVRefreshRefreshingBlock)block;

- (void)beginHeaderRefreshing;
- (void)beginFooterRefreshing;

- (void)endHeaderRefreshing;
- (void)endFooterRefreshing;
- (void)endFooterRefreshingWithNoMoreData;
- (void)endFooterRefreshingWithNoMoreData:(NSString *)customTitle;

/** 当scrollView的contentOffset发生改变的时候调用 */
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change;
/** 当scrollView的contentSize发生改变的时候调用 */
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change;
/** 当scrollView的拖拽状态发生改变的时候调用 */
- (void)scrollViewPanStateDidChange:(NSDictionary *)change;

@end
