//
//  Test2TableViewController.m
//  AVRefreshDemo
//
//  Created by LeoZ on 16/3/16.
//  Copyright © 2016年 LeoZ. All rights reserved.
//

#import "Test2TableViewController.h"
#import "AVRefreshExtension.h"
@interface Test2TableViewController ()
@property (nonatomic, strong) NSMutableArray *titles;
@end

@implementation Test2TableViewController
- (NSMutableArray *)titles{
    if (!_titles) {
        _titles = [NSMutableArray array];
    }
    return _titles;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:51.0/255.0 green:143.0/255.0 blue:210.0/255.0 alpha:0.8];
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.5];
    // 注意若是存在导航控制器 ，请设置一下属性，不然会导致刷新控件以及tableView的位置异常(没有根据导航控制器的位置自动调节)
    self.tableView.autoresizingMask = UIViewAutoresizingNone;
    self.navigationController.navigationBar.translucent = NO;
    for (int i = 0; i < 5; i++) {
        [self.titles addObject:@"测试数据1"];
        [self.titles addObject:@"测试数据2"];
        [self.titles addObject:@"测试数据3"];
    }
    [self.tableView reloadData];
    
    self.tableView.av_footer = [AVFooterRefresh footerRefreshWithScrollView:self.tableView footerRefreshingBlock:^{
        [self loadMoreData];
    }];
}

- (void)loadMoreData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (int i = 0; i < arc4random_uniform(20) + 1; i++) {
            [self.titles addObject:[NSString stringWithFormat:@"下拉测试数据---%zd",arc4random_uniform(999)]];
        }
        [self.tableView.av_footer endFooterRefreshing];
        [self.tableView reloadData];        
    });
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end


