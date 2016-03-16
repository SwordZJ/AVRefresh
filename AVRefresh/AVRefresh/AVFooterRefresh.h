//
//  AVFooterRefresh.h
//  AVRefreshExtension
//
//  Created by 周济 on 16/1/13.
//  Copyright © 2016年 swiftTest. All rights reserved.
//

#import "AVRefreshExtension.h"
#import "AVRefresh.h"
@interface AVFooterRefresh : AVRefresh
+ (instancetype)createFooterWithRefreshingBlock:(AVRefreshRefreshingBlock)refreshingBlock scrollView:(UIScrollView *)scrollView;
@end
