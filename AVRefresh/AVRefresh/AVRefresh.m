//
//  AVRefresh.m
//  AVRefreshExtension
//
//  Created by 周济 on 16/1/14.
//  Copyright © 2016年 swiftTest. All rights reserved.
//

#import "AVRefresh.h"
#import "UIView+AVFrameExtension.h"
#define kAVRefreshFooterHeight 44
#define AVRefreshKeyPathContentOffset  @"contentOffset"
#define AVRefreshKeyPathContentInset   @"contentInset"
#define AVRefreshKeyPathContentSize    @"contentSize"
#define AVRefreshKeyPathPanState       @"state"
#define AVRefreshAnimationDuration     0.25


// 定制文字
#define AVHeaderRefreshNormalStateDescription          @"下拉刷新"
#define AVHeaderRefreshWillRefreshingStateDescription  @"松手即将刷新"
#define AVFooterRefreshNormalStateDescription          @"上拉刷新"
#define AVFooterRefreshWillRefreshingStateDescription  @"松手即将刷新"
#define AVRefreshNoticeNoMoreDataStateDescription      @"没有更多了"



@interface AVRefresh ()
@property (nonatomic, strong) UIScrollView            *scrollView;
@property (nonatomic, assign) UIEdgeInsets            originalContentInset;
@property (nonatomic, assign) CGFloat                 insetTopDelta;
@property (nonatomic, assign) CGFloat                 lastBottomDelta;
@property (nonatomic, weak  ) UIView                  *footerView;
@property (nonatomic, weak  ) UIView                  *headerView;
@property (nonatomic, weak  ) UIActivityIndicatorView *activityHeader;
@property (nonatomic, weak  ) UIActivityIndicatorView *activityFooter;

@property (nonatomic, weak  ) UILabel                 *headerLabel;
@property (nonatomic, weak  ) UILabel                 *footerLabel;

@property (strong, nonatomic) UIPanGestureRecognizer  *pan;
@end



@implementation AVRefresh

+ (instancetype)footerRefreshWithScrollView:(UIScrollView *)scrollView footerRefreshingBlock:(AVRefreshRefreshingBlock)block{
    return [[self alloc] initFooterWithScrollView:scrollView footerRefreshingBlock:block];
}

- (instancetype)initFooterWithScrollView:(UIScrollView *)scrollView footerRefreshingBlock:(AVRefreshRefreshingBlock)block{
    if (self = [super init]) {
        [self setup:scrollView];
        [self setupFooter:block];
    }
    return self;
}

+ (instancetype)headerRefreshWithScrollView:(UIScrollView *)scrollView headerRefreshingBlock:(AVRefreshRefreshingBlock)block{
    return [[self alloc] initHeaderWithScrollView:scrollView headerRefreshingBlock:block];
}

- (instancetype)initHeaderWithScrollView:(UIScrollView *)scrollView headerRefreshingBlock:(AVRefreshRefreshingBlock)block{
    if (self = [super init]) {
        [self setup:scrollView];
        [self setupHeader:block];
    }
    return self;
}

- (void)setup:(UIScrollView *)scrollView{
    if (scrollView == nil) return;
    self.scrollView = scrollView;
    // 旧的父控件移除监听
    [self removeObservers];
   
    self.av_w = scrollView.av_w;
    self.av_x = 0;
    
    // 设置永远支持垂直弹簧效果
    _scrollView.alwaysBounceVertical = YES;
    // 记录UIScrollView最开始的contentInset
    _originalContentInset = self.scrollView.contentInset;
    
        // 添加监听
    [self addObservers];
}

- (void)setupFooter:(AVRefreshRefreshingBlock)block{
//    if (self.scrollView.contentSize.height == 0) return;
    if (self.scrollView == nil) return;
    UIView *footerView = [[UIView alloc] initWithFrame:self.bounds];
    footerView.backgroundColor = [UIColor clearColor];
    self.footerView = footerView;
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activity.hidesWhenStopped = NO;
    activity.hidden = YES;
//    [activity startAnimating];
    self.activityFooter = activity;
    [footerView addSubview:activity];
    
    UILabel *footerLabel = [[UILabel alloc] init];
    footerLabel.font = [UIFont systemFontOfSize:14.0f];
    footerLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    footerLabel.textAlignment = NSTextAlignmentCenter;
    footerLabel.text = AVHeaderRefreshNormalStateDescription;
    self.footerLabel = footerLabel;
    [footerView addSubview:footerLabel];
    [self addSubview:footerView];
    [self.scrollView addSubview:self];
    
    self.footerRefreshingBlock = block;
    self.refreshType = AVRefreshTypeFooter;
    self.footerRefreshState = AVRefreshStateNormal;
    
}


- (void)setupHeader:(AVRefreshRefreshingBlock)block{
//    if (self.scrollView.contentSize.height == 0) return;
    if (self.scrollView == nil) return;
    UIView *headerView = [[UIView alloc] initWithFrame:self.bounds];
    headerView.backgroundColor = [UIColor clearColor];
    self.headerView = headerView;
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activity.hidesWhenStopped = NO;
    activity.hidden = YES;
//    [activity startAnimating];
    self.activityHeader = activity;
    [headerView addSubview:activity];
    
    UILabel *headerLabel = [[UILabel alloc] init];
    headerLabel.font = [UIFont systemFontOfSize:14.0f];
    headerLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.text = AVHeaderRefreshNormalStateDescription;
    self.headerLabel = headerLabel;
    [headerView addSubview:headerLabel];
    
    [self addSubview:headerView];
    [self.scrollView addSubview:self];
    
    self.headerRefreshingBlock = block;
    self.refreshType = AVRefreshTypeHeader;
    self.headerRefreshState = AVRefreshStateNormal;
}

//- (void)willMoveToSuperview:(UIView *)newSuperview{
//    [super willMoveToSuperview:newSuperview];
//    
//    // 如果不是UIScrollView，不做任何事情
//    if (newSuperview && ![newSuperview isKindOfClass:[UIScrollView class]]) return;
//    
//    // 旧的父控件移除监听
//    [self removeObservers];
//    
//    if (newSuperview) { // 新的父控件
//
//        self.av_w = newSuperview.av_w;
//        self.av_x = 0;
//
//        // 记录UIScrollView
//        _scrollView = (UIScrollView *)newSuperview;
//        // 设置永远支持垂直弹簧效果
//        _scrollView.alwaysBounceVertical = YES;
//        // 记录UIScrollView最开始的contentInset
//        _originalContentInset = self.scrollView.contentInset;
//        
//        // 添加监听
//        [self addObservers];
//    }
//}
- (void)setHeaderRefreshState:(AVRefreshState)headerRefreshState{
    AVRefreshState oldState = self.headerRefreshState;
    if (headerRefreshState == oldState) return;
    _headerRefreshState = headerRefreshState;
    
    switch (headerRefreshState) {
        case AVRefreshStateNormal:
        case AVRefreshStateWillRefreshing:
        {
            self.headerLabel.hidden = NO;
            self.activityHeader.hidden = YES;
            if (headerRefreshState == AVRefreshStateNormal) {
                self.headerLabel.text = AVHeaderRefreshNormalStateDescription;
            }else if(headerRefreshState == AVRefreshStateWillRefreshing){
                self.headerLabel.text = AVHeaderRefreshWillRefreshingStateDescription;
            }
            if (oldState != AVRefreshStateRefresing) return;
            // 恢复inset和offset
            [UIView animateWithDuration:AVRefreshAnimationDuration animations:^{
                self.scrollView.av_insetTop += self.insetTopDelta;
            }];
        }
            break;
        case AVRefreshStateRefresing:
        {
            self.headerLabel.hidden = YES;
            self.activityHeader.hidden = NO;
            [UIView animateWithDuration:AVRefreshAnimationDuration animations:^{
                // 增加滚动区域
                CGFloat top = self.originalContentInset.top + self.av_h;
                self.scrollView.av_insetTop = top;
                
                // 设置滚动位置
                self.scrollView.av_offsetY = - top;
            } completion:^(BOOL finished) {
                if (self.headerRefreshingBlock) {
                    self.headerRefreshingBlock();
                }
            }];
        }
            break;
        case AVRefreshStateNoticeNoMoreData:
            break;
        default:
            break;
    }
}

- (void)setFooterRefreshState:(AVRefreshState)footerRefreshState{
    AVRefreshState oldState = self.footerRefreshState;
    if (footerRefreshState == oldState) return;
    _footerRefreshState = footerRefreshState;
    
    switch (footerRefreshState) {
        case AVRefreshStateNormal:
        case AVRefreshStateWillRefreshing:
        case AVRefreshStateNoticeNoMoreData:
        {
            self.footerLabel.hidden = NO;
            self.activityFooter.hidden = YES;
            if (footerRefreshState == AVRefreshStateNormal) {
                self.footerLabel.text = AVFooterRefreshNormalStateDescription;
            }else if(footerRefreshState == AVRefreshStateWillRefreshing){
                self.footerLabel.text = AVFooterRefreshWillRefreshingStateDescription;
            }else{
                if (self.endWithNoMoreDataDescription.length > 0) {
                    self.footerLabel.text = self.endWithNoMoreDataDescription;
                }else{
                    self.footerLabel.text = AVRefreshNoticeNoMoreDataStateDescription;
                }
            }
            if (oldState != AVRefreshStateRefresing) return;
            // 刷新完毕
            if (AVRefreshStateRefresing == oldState) {
                [UIView animateWithDuration:AVRefreshAnimationDuration animations:^{
                    self.scrollView.av_insetBottom -= self.lastBottomDelta;
                }];
            }
        }
            break;
        case AVRefreshStateRefresing:
        {
            self.footerLabel.hidden = YES;
            self.activityFooter.hidden = NO;
            [UIView animateWithDuration:AVRefreshAnimationDuration animations:^{
                CGFloat bottom = self.av_h + self.originalContentInset.bottom;
                CGFloat deltaH = [self heightForContentBreakView];
                if (deltaH < 0) { // 如果内容高度小于view的高度
                    bottom -= deltaH;
                }
                self.lastBottomDelta = bottom - self.scrollView.av_insetBottom;
                self.scrollView.av_insetBottom = bottom;
                self.scrollView.av_offsetY = [self happenOffsetY] + self.av_h;
            } completion:^(BOOL finished) {
                if (self.footerRefreshingBlock) {
                    self.footerRefreshingBlock();
                }
            }];
        }
            break;
        default:
            break;
    }
}



- (void)layoutSubviews{
    [super layoutSubviews];
    if (self.footerView) { // 上拉刷新控件
        self.av_y = self.scrollView.av_contentHeight > self.scrollView.av_h ? self.scrollView.av_contentHeight + self.scrollView.av_insetBottom: self.scrollView.av_h + self.scrollView.av_insetBottom;
        self.av_h = kAVRefreshFooterHeight;
        self.footerView.frame = self.bounds;
        self.activityFooter.center = self.footerView.center;
        self.footerLabel.frame = self.footerView.bounds;
    }
    
    if (self.headerView) { // 下拉刷新控件
        self.av_y = -kAVRefreshFooterHeight;
        self.av_h = kAVRefreshFooterHeight;
        self.headerView.frame = self.bounds;
        self.activityHeader.center = self.headerView.center;
        self.headerLabel.frame = self.headerView.bounds;
    }
}

#pragma mark - KVO监听
- (void)addObservers
{
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.scrollView addObserver:self forKeyPath:AVRefreshKeyPathContentOffset options:options context:nil];
    [self.scrollView addObserver:self forKeyPath:AVRefreshKeyPathContentSize options:options context:nil];
    self.pan = self.scrollView.panGestureRecognizer;
    [self.pan addObserver:self forKeyPath:AVRefreshKeyPathPanState options:options context:nil];
}

- (void)removeObservers
{
    [self.superview removeObserver:self forKeyPath:AVRefreshKeyPathContentOffset];
    [self.superview removeObserver:self forKeyPath:AVRefreshKeyPathContentSize];;
    [self.pan removeObserver:self forKeyPath:AVRefreshKeyPathPanState];
    self.pan = nil;
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:AVRefreshKeyPathContentOffset]) { // 偏移位置变化
        [self scrollViewContentOffsetDidChange:change];
    }else if([keyPath isEqualToString:AVRefreshKeyPathContentSize]){ // contentSize变化
        [self scrollViewContentSizeDidChange:change];
    }else if([keyPath isEqualToString:AVRefreshKeyPathPanState]){ // 手势变化
        [self scrollViewPanStateDidChange:change];
    }
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{
    
    
    if (self.refreshType == AVRefreshTypeFooter) {
        if(self.footerRefreshState == AVRefreshStateRefresing)return;
        if(self.footerRefreshState == AVRefreshStateNoticeNoMoreData)return;
    }else if(self.refreshType == AVRefreshTypeHeader){
        // 在刷新的refreshing状态
        if (self.headerRefreshState == AVRefreshStateRefresing) {
            if (self.window == nil) return;
            
            // sectionheader停留解决
            CGFloat insetT = - self.scrollView.av_offsetY > _originalContentInset.top ? - self.scrollView.av_offsetY : _originalContentInset.top;
            insetT = insetT > self.av_h + _originalContentInset.top ? self.av_h + _originalContentInset.top : insetT;
            self.scrollView.av_insetTop = insetT;
            
            self.insetTopDelta = _originalContentInset.top - insetT;
            return;
        }
    }
    // 当前的contentOffset
    CGFloat offsetY = self.scrollView.av_offsetY;
    CGFloat happenOffsetY = 0;
    CGFloat normal2pullingOffsetY = 0;
    
    if(self.refreshType == AVRefreshTypeHeader){
        // 头部控件刚好出现的offsetY
        happenOffsetY = - self.originalContentInset.top;
        // 如果是向上滚动到看不见头部控件，直接返回
        if (offsetY > happenOffsetY) return;
        normal2pullingOffsetY = happenOffsetY - self.av_h;
    }else if(self.refreshType == AVRefreshTypeFooter){
        // 尾部控件刚好出现的offsetY
        happenOffsetY = [self happenOffsetY];
        // 如果是向下滚动到看不见尾部控件，直接返回
        if (offsetY <= happenOffsetY) return;
        normal2pullingOffsetY = happenOffsetY + self.av_h;
    }

    
    if (self.scrollView.isDragging) { // 如果正在拖拽
        if (self.refreshType == AVRefreshTypeHeader) {
            if (self.headerRefreshState == AVRefreshStateNormal) {
                if (offsetY < normal2pullingOffsetY) {
                        // 转为即将刷新状态
                        self.headerRefreshState = AVRefreshStateWillRefreshing;
                }
            }else if (self.headerRefreshState == AVRefreshStateWillRefreshing){
                if (offsetY >= normal2pullingOffsetY) {
                    // 转为普通状态
                    self.headerRefreshState = AVRefreshStateNormal;
                }
            }
        }
        
        if (self.refreshType == AVRefreshTypeFooter) {
            if (self.footerRefreshState == AVRefreshStateNormal) {
                if (offsetY > normal2pullingOffsetY) {
                    // 转为即将刷新状态
                    self.footerRefreshState = AVRefreshStateWillRefreshing;
                }
            }else if (self.footerRefreshState == AVRefreshStateWillRefreshing ) {
                if (offsetY <= normal2pullingOffsetY) {
                    // 转为普通状态
                    self.footerRefreshState = AVRefreshStateNormal;
                }
            }
        }
    }else if (self.footerRefreshState == AVRefreshStateWillRefreshing
              || self.headerRefreshState == AVRefreshStateWillRefreshing) {// 即将刷新 && 手松开
        
        if (self.refreshType == AVRefreshTypeHeader) {
            // 开始刷新
            [self beginHeaderRefreshing];
        }else if (self.refreshType == AVRefreshTypeFooter) {
            [self beginFooterRefreshing];
        }
    }
}

#pragma mark - 刷新状态变换
- (void)beginHeaderRefreshing{
    self.headerRefreshState = AVRefreshStateRefresing;
    [self.activityHeader startAnimating];
}
- (void)beginFooterRefreshing{
    self.footerRefreshState = AVRefreshStateRefresing;
    [self.activityFooter startAnimating];
}

- (void)endHeaderRefreshing{
    self.headerRefreshState = AVRefreshStateNormal;
    if ([self.activityHeader isAnimating]) {
        [self.activityHeader stopAnimating];
    }
}
- (void)endFooterRefreshing{
    self.footerRefreshState = AVRefreshStateNormal;
    if ([self.activityFooter isAnimating]) {
        [self.activityFooter stopAnimating];
    }
}

- (void)endFooterRefreshingWithNoMoreData{
    [self endFooterRefreshingWithNoMoreData:nil];
}

- (void)endFooterRefreshingWithNoMoreData:(NSString *)customTitle{
    self.endWithNoMoreDataDescription = customTitle;
    self.footerRefreshState = AVRefreshStateNoticeNoMoreData;
    if ([self.activityFooter isAnimating]) {
        [self.activityFooter stopAnimating];
    }
}

- (void)scrollViewContentSizeDidChange:(NSDictionary *)change{
    // 内容的高度
    CGFloat contentHeight = self.scrollView.av_contentHeight;
    // 表格的高度
    CGFloat scrollHeight = self.scrollView.av_h - self.originalContentInset.top - self.originalContentInset.bottom;
    // 设置位置和尺寸
    if (self.refreshType == AVRefreshTypeFooter) {
        self.av_y = MAX(contentHeight, scrollHeight);
    }
}
- (void)scrollViewPanStateDidChange:(NSDictionary *)change{
//    if (self.refreshType == AVRefreshTypeFooter) {
//        if (self.footerRefreshState != AVRefreshStateNormal) return;
//        
//        if (_scrollView.panGestureRecognizer.state == UIGestureRecognizerStateEnded) {// 手松开
//            if (_scrollView.av_insetTop + _scrollView.av_contentHeight <= _scrollView.av_h) {  // 不够一个屏幕
//                if (_scrollView.av_offsetY >= - _scrollView.av_insetTop) { // 向上拽
//                    self.footerRefreshState = AVRefreshStateWillRefreshing;
//                }
//            } else { // 超出一个屏幕
//                if (_scrollView.av_offsetY >= _scrollView.av_contentHeight + _scrollView.av_insetBottom - _scrollView.av_h) {
//                    self.footerRefreshState = AVRefreshStateWillRefreshing;
//                }
//            }
//        }
//    }
}

#pragma mark 获得scrollView的内容 超出 view 的高度
- (CGFloat)heightForContentBreakView
{
    CGFloat h = self.scrollView.frame.size.height - self.originalContentInset.bottom - self.originalContentInset.top;
    return self.scrollView.contentSize.height - h;
}

#pragma mark 刚好看到上拉刷新控件时的contentOffset.y
- (CGFloat)happenOffsetY
{
    CGFloat deltaH = [self heightForContentBreakView];
    if (deltaH > 0) { // contentSize 超出scrollView的高度
        return deltaH - self.originalContentInset.top;
    } else { // contentSize 没有超出scrollView的高度
        return - self.originalContentInset.top;
    }
}


@end
