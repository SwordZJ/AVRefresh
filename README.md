# AVRefresh
简单易用的上下拉刷新框架

![github](https://github.com/SwordZJ/AVRefresh/blob/master/Image/Snip20160316_10.png)
## 1 下拉集成，请查看Test1TableViewController 示例代码
```objc
// 初始化刷新控件，在block中回调刷新方法
self.tableView.av_footer = [AVHeaderRefresh headerRefreshWithScrollView:self.tableView headerRefreshingBlock:^{
        [self loadNewData];
    }];
```

![github](https://github.com/SwordZJ/AVRefresh/blob/master/Image/Snip20160316_13.png)
![github](https://github.com/SwordZJ/AVRefresh/blob/master/Image/Snip20160316_14.png)
![github](https://github.com/SwordZJ/AVRefresh/blob/master/Image/Snip20160316_15.png)

## 2 上拉集成，请查看Test2TableViewController 示例代码
```objc
self.tableView.av_footer = [AVFooterRefresh footerRefreshWithScrollView:self.tableView footerRefreshingBlock:^{
        [self loadMoreData];
    }];
```
![github](https://github.com/SwordZJ/AVRefresh/blob/master/Image/Snip20160316_16.png)
![github](https://github.com/SwordZJ/AVRefresh/blob/master/Image/Snip20160316_17.png)
### tip:在上拉集成中，提供没有更多数据时的展示，请查看Test3TableViewController示例代码
![github](https://github.com/SwordZJ/AVRefresh/blob/master/Image/Snip20160316_18.png)


## 3.同时集成上下拉，请查看Test4TableViewController 示例代码
