//
//  ViewController.m
//  CategoryDemo
//
//  Created by hadlinks on 2019/7/8.
//  Copyright © 2019 Ningbo Hadlinks IOT Science&Technology Co.,Ltd. All rights reserved.
//

#import "ViewController.h"

NSString *const CellID = @"ListCellIdentifier";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *categories;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"常用分类列表";
    
    [self.view addSubview:self.tableView];
    
    [self loadData];
}


#pragma mark - Data

- (void)loadData {
    self.categories = @[
        @{@"name" : @"UIDevice+HDLHelper",
          @"className" : @"UIDeviceViewController"},
                            
        @{@"name" : @"NSBundle+HDLHelper",
          @"className" : @"NSBundleViewController"},
        
        @{@"name" : @"NSString+HDLHelper",
          @"className" : @"NSStringViewController"},
        
        @{@"name" : @"UIImage+HDLHelper",
          @"className" : @"UIImageViewController"},
        
        @{@"name" : @"UIColor+HDLHelper",
          @"className" : @"UIColorViewController"},
        
        @{@"name" : @"UIAlertController+HDLHelper",
          @"className" : @"UIAlertControllerViewController"},
        
        @{@"name" : @"NSArray+HDLHelper",
          @"className" : @"NSArrayViewController"},
          
        @{@"name" : @"NSData+HDLHelper",
          @"className" : @"NSDataViewController"}
    ];
    
    [self.tableView reloadData];
}


#pragma mark - UITableViewDatasource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    
    NSDictionary *categoryDic = self.categories[indexPath.row];
    NSString *name = categoryDic[@"name"]; // 分类名称
    
    cell.textLabel.text = name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *categoryDic = self.categories[indexPath.row];
    NSString *name = categoryDic[@"name"]; // 分类名称
    NSString *className = categoryDic[@"className"];
    Class class = NSClassFromString(className);
    
    UIViewController *vc = [[class alloc] init];
    vc.title = name;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - Getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:UIScreen.mainScreen.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellID];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _tableView;
}

@end
