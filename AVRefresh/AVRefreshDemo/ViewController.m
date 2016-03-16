//
//  ViewController.m
//  AVRefreshDemo
//
//  Created by LeoZ on 16/3/16.
//  Copyright © 2016年 LeoZ. All rights reserved.
//

#import "ViewController.h"
#import "Test1TableViewController.h"
#import "Test2TableViewController.h"
#import "Test3TableViewController.h"
#import "Test4TableViewController.h"
@interface ViewController ()
/** <#desc#>  */
@property (nonatomic, strong) NSArray *titles;
/** <#desc#>  */
@property (nonatomic, strong) NSArray *classNames;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    self.title = @"AVRefreshDemo";
    // Do any additional setup after loading the view, typically from a nib.
    self.titles = @[@"下拉刷新",@"上拉刷新",@"上拉没有更多数据",@"上下拉同时集成"];
    self.classNames = @[@"Test1TableViewController",@"Test2TableViewController",@"Test3TableViewController",@"Test4TableViewController"];
    [self.tableView reloadData];
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
    Class className = NSClassFromString(self.classNames[indexPath.row]);
    if (className) {
        UIViewController *pushVc = className.new;
        pushVc.title = self.titles[indexPath.row];
        [self.navigationController pushViewController:pushVc animated:YES];
    }
}



@end
