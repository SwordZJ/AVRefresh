//
//  UIScrollView+AVRefreshExtension.m
//  AVRefreshExtension
//
//  Created by 周济 on 16/1/13.
//  Copyright © 2016年 swiftTest. All rights reserved.
//

#import "UIScrollView+AVRefreshExtension.h"
#import "AVRefresh.h"
#import <objc/runtime.h>

@implementation UIScrollView (AVRefreshExtension)
#pragma mark - header
static const char AVRefreshExtensionHeaderKey = '\0';
- (void)setAv_header:(AVRefresh *)av_header{
    if (av_header != self.av_header) {
        // 删除旧的，添加新的
        [self.av_header removeFromSuperview];
        [self insertSubview:av_header atIndex:0];
        
        // 存储新的
        [self willChangeValueForKey:@"av_header"]; // KVO
        objc_setAssociatedObject(self, &AVRefreshExtensionHeaderKey,
                                 av_header, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"av_header"]; // KVO
    }
}

- (AVRefresh *)av_header{
    return objc_getAssociatedObject(self, &AVRefreshExtensionHeaderKey);
}

#pragma mark - footer
static const char AVRefreshExtensionFooterKey = '\0';
- (void)setAv_footer:(AVRefresh *)av_footer{
    if (av_footer != self.av_footer) {
        // 删除旧的，添加新的
        [self.av_footer removeFromSuperview];
        [self insertSubview:av_footer atIndex:0];
        
        // 存储新的
        [self willChangeValueForKey:@"av_footer"]; // KVO
        objc_setAssociatedObject(self, &AVRefreshExtensionFooterKey,
                                 av_footer, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"av_footer"]; // KVO
    }
}

- (AVRefresh *)av_footer{
    return objc_getAssociatedObject(self, &AVRefreshExtensionFooterKey);
}@end
