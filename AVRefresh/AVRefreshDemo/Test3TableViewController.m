//
//  Test3TableViewController.m
//  AVRefreshDemo
//
//  Created by LeoZ on 16/3/16.
//  Copyright © 2016年 LeoZ. All rights reserved.
//

#import "Test3TableViewController.h"
#import "AVRefreshExtension.h"
@interface Test3TableViewController ()
@property (nonatomic, strong) NSMutableArray *titles;
/** <#desc#>  */
@property (nonatomic, assign) NSInteger index;
@end

@implementation Test3TableViewController
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
}

- (void)loadMoreData{
    if (_index < 3) {
        _index++;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            for (int i = 0; i < arc4random_uniform(20) + 1; i++) {
                [self.titles addObject:[NSString stringWithFormat:@"下拉测试数据---%zd",arc4random_uniform(999)]];
            }
            [self.tableView.av_footer endFooterRefreshing];
            [self.tableView reloadData];
        });
    }else{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.av_footer endFooterRefreshingWithNoMoreData];
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
