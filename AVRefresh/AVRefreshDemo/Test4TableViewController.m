//
//  Test4TableViewController.m
//  AVRefreshDemo
//
//  Created by 周济 on 16/3/16.
//  Copyright © 2016年 LeoZ. All rights reserved.
//

#import "Test4TableViewController.h"
#import "AVRefreshExtension.h"
@interface Test4TableViewController ()
@property (nonatomic, strong) NSMutableArray *titles;
/** <#desc#>  */
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, assign) BOOL isLoading;
@end

@implementation Test4TableViewController
- (NSMutableArray *)titles{
    if (!_titles) {
        _titles = [NSMutableArray array];
    }
    return _titles;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 注意若是存在导航控制器 ，请设置一下属性，不然会导致刷新控件以及tableView的位置异常(没有根据导航控制器的位置自动调节)
    self.tableView.autoresizingMask = UIViewAutoresizingNone;
    self.navigationController.navigationBar.translucent = NO;
    for (int i = 0; i < 5; i++) {
        [self.titles addObject:@"测试数据1"];
        [self.titles addObject:@"测试数据2"];
        [self.titles addObject:@"测试数据3"];
    }
    [self.tableView reloadData];
    
    // 初始化上拉
    self.tableView.av_footer = [AVFooterRefresh footerRefreshWithScrollView:self.tableView footerRefreshingBlock:^{
        [self loadMoreData];
    }];
    
    self.tableView.av_header = [AVHeaderRefresh headerRefreshWithScrollView:self.tableView headerRefreshingBlock:^{
        [self loadNewData];
    }];
}

- (void)loadNewData{
    if (_isLoading) {
        [self.tableView.av_footer setFooterRefreshState:AVRefreshStateNormal];
        return;
    }
    
    _isLoading = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _index = 0;
        self.titles = nil;
        for (int i = 0; i < arc4random_uniform(20) + 1; i++) {
            [self.titles insertObject:[NSString stringWithFormat:@"下拉测试数据---%zd",arc4random_uniform(999)] atIndex:0];
        }
        [self.tableView reloadData];
        [self.tableView.av_footer setFooterRefreshState:AVRefreshStateNormal];
        [self.tableView.av_header endHeaderRefreshing];
        _isLoading = NO;
    });
}

- (void)loadMoreData{
    if (_isLoading) {
        [self.tableView.av_header setHeaderRefreshState:AVRefreshStateNormal];
        return;
    }
    
    _isLoading = YES;
    if (_index < 3) {
        _index++;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            for (int i = 0; i < arc4random_uniform(20) + 1; i++) {
                [self.titles addObject:[NSString stringWithFormat:@"下拉测试数据---%zd",arc4random_uniform(999)]];
            }
            [self.tableView reloadData];
            [self.tableView.av_footer endFooterRefreshing];
            _isLoading = NO;
        });
    }else{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.av_footer endFooterRefreshingWithNoMoreData];
            _isLoading = NO;
        });
    }
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.titles[indexPath.row];
    return cell;
}

@end
