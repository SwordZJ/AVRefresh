# AVRefresh
简单易用的上下拉刷新框架

## 1 下拉集成，请查看Test1TableViewController 示例代码
```objc
// 初始化刷新控件，在block中回调刷新方法
self.tableView.av_footer = [AVHeaderRefresh headerRefreshWithScrollView:self.tableView headerRefreshingBlock:^{
        [self loadNewData];
    }];
```

## 2 上拉集成，请查看Test2TableViewController 示例代码
```objc
self.tableView.av_footer = [AVFooterRefresh footerRefreshWithScrollView:self.tableView footerRefreshingBlock:^{
        [self loadMoreData];
    }];
```
### tip:在上拉集成中，提供没有更多数据时的展示，请查看Test3TableViewController示例代码

## 3.同时集成上下拉，请查看Test4TableViewController 示例代码
