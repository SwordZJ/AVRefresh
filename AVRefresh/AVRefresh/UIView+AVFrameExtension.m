//
//  UIView+AVFrameExtension.m
//  AVRefreshExtension
//
//  Created by 周济 on 16/1/13.
//  Copyright © 2016年 swiftTest. All rights reserved.
//

#import "UIView+AVFrameExtension.h"

@implementation UIView (AVFrameExtension)

- (void)setAv_x:(CGFloat)av_x{
    CGRect frame = self.frame;
    frame.origin.x = av_x;
    self.frame = frame;
}
- (CGFloat)av_x{
    return self.frame.origin.x;
}
- (void)setAv_y:(CGFloat)av_y{
    CGRect frame = self.frame;
    frame.origin.y = av_y;
    self.frame = frame;
}
- (CGFloat)av_y{
    return self.frame.origin.y;
}
- (void)setAv_centerX:(CGFloat)av_centerX{
    CGPoint center = self.center;
    center.x = av_centerX;
    self.center = center;
}
- (CGFloat)av_centerX{
    return self.center.x;
}

- (void)setAv_centerY:(CGFloat)av_centerY{
    CGPoint center = self.center;
    center.y = av_centerY;
    self.center = center;
}
- (CGFloat)av_centerY{
    return self.center.y;
}

- (void)setAv_w:(CGFloat)av_w{
    CGRect frame = self.frame;
    frame.size.width = av_w;
    self.frame = frame;
}
- (CGFloat)av_w{
    return self.frame.size.width;
}

- (void)setAv_h:(CGFloat)av_h{
    CGRect frame = self.frame;
    frame.size.height = av_h;
    self.frame = frame;
}

- (CGFloat)av_h{
    return self.frame.size.height;
}
- (void)setAv_size:(CGSize)av_size{
    CGRect frame = self.frame;
    frame.size = av_size;
    self.frame = frame;
}
- (CGSize)av_size{
    return self.frame.size;
}
- (void)setAv_origin:(CGPoint)av_origin{
    CGRect frame = self.frame;
    frame.origin = av_origin;
    self.frame = frame;
}
- (CGPoint)av_origin{
    return self.frame.origin;
}
@end
@implementation UIScrollView (AVFrameExtension)
- (void)setAv_insetTop:(CGFloat)av_insetTop
{
    UIEdgeInsets inset = self.contentInset;
    inset.top = av_insetTop;
    self.contentInset = inset;
}

- (CGFloat)av_insetTop
{
    return self.contentInset.top;
}

- (void)setAv_insetBottom:(CGFloat)av_insetBottom
{
    UIEdgeInsets inset = self.contentInset;
    inset.bottom = av_insetBottom;
    self.contentInset = inset;
}

- (CGFloat)av_insetBottom
{
    return self.contentInset.bottom;
}

- (void)setAv_insetLeft:(CGFloat)av_insetLeft
{
    UIEdgeInsets inset = self.contentInset;
    inset.left = av_insetLeft;
    self.contentInset = inset;
}

- (CGFloat)av_insetLeft
{
    return self.contentInset.left;
}

- (void)setAv_insetRight:(CGFloat)av_insetRight
{
    UIEdgeInsets inset = self.contentInset;
    inset.right = av_insetRight;
    self.contentInset = inset;
}

- (CGFloat)av_insetRight
{
    return self.contentInset.right;
}

- (void)setAv_offsetX:(CGFloat)av_offsetX
{
    CGPoint offset = self.contentOffset;
    offset.x = av_offsetX;
    self.contentOffset = offset;
}

- (CGFloat)av_offsetX
{
    return self.contentOffset.x;
}

- (void)setAv_offsetY:(CGFloat)av_offsetY
{
    CGPoint offset = self.contentOffset;
    offset.y = av_offsetY;
    self.contentOffset = offset;
}

- (CGFloat)av_offsetY
{
    return self.contentOffset.y;
}

- (void)setAv_contentWidth:(CGFloat)av_contentWidth
{
    CGSize size = self.contentSize;
    size.width = av_contentWidth;
    self.contentSize = size;
}

- (CGFloat)av_contentWidth
{
    return self.contentSize.width;
}

- (void)setAv_contentHeight:(CGFloat)av_contentHeight
{
    CGSize size = self.contentSize;
    size.height = av_contentHeight;
    self.contentSize = size;
}

- (CGFloat)av_contentHeight
{
    return self.contentSize.height;
}
@end

