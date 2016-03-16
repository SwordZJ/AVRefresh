//
//  AVHeaderRefresh.h
//  AVRefreshExtension
//
//  Created by 周济 on 16/1/13.
//  Copyright © 2016年 swiftTest. All rights reserved.
//

#import "AVRefreshExtension.h"
#import "AVRefresh.h"
@interface AVHeaderRefresh : AVRefresh
+ (instancetype)createHeaderWithRefreshingBlock:(AVRefreshRefreshingBlock)refreshingBlock scrollView:(UIScrollView *)scrollView;
@end
