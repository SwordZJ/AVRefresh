//
//  UIView+AVFrameExtension.h
//  AVRefreshExtension
//
//  Created by 周济 on 16/1/13.
//  Copyright © 2016年 swiftTest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AVFrameExtension)
@property (assign, nonatomic) CGFloat av_x;
@property (assign, nonatomic) CGFloat av_y;
@property (assign, nonatomic) CGFloat av_w;
@property (assign, nonatomic) CGFloat av_h;
@property (assign, nonatomic) CGFloat av_centerX;
@property (assign, nonatomic) CGFloat av_centerY;
@property (assign, nonatomic) CGSize  av_size;
@property (assign, nonatomic) CGPoint av_origin;
@end

@interface UIScrollView (AVFrameExtension)
@property (assign, nonatomic) CGFloat av_insetTop;
@property (assign, nonatomic) CGFloat av_insetBottom;
@property (assign, nonatomic) CGFloat av_insetLeft;
@property (assign, nonatomic) CGFloat av_insetRight;

@property (assign, nonatomic) CGFloat av_offsetX;
@property (assign, nonatomic) CGFloat av_offsetY;

@property (assign, nonatomic) CGFloat av_contentWidth;
@property (assign, nonatomic) CGFloat av_contentHeight;
@end