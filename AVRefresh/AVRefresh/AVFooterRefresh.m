//
//  AVFooterRefresh.m
//  AVRefreshExtension
//
//  Created by 周济 on 16/1/13.
//  Copyright © 2016年 swiftTest. All rights reserved.
//

#import "AVFooterRefresh.h"

@implementation AVFooterRefresh
+ (instancetype)createFooterWithRefreshingBlock:(AVRefreshRefreshingBlock)refreshingBlock scrollView:(UIScrollView *)scrollView{
    return [self footerRefreshWithScrollView:scrollView footerRefreshingBlock:refreshingBlock];
}

@end
