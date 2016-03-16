//
//  AVHeaderRefresh.m
//  AVRefreshExtension
//
//  Created by 周济 on 16/1/13.
//  Copyright © 2016年 swiftTest. All rights reserved.
//

#import "AVHeaderRefresh.h"

@implementation AVHeaderRefresh
+ (instancetype)createHeaderWithRefreshingBlock:(AVRefreshRefreshingBlock)refreshingBlock scrollView:(UIScrollView *)scrollView{
    return [self headerRefreshWithScrollView:scrollView headerRefreshingBlock:refreshingBlock];
}


@end
