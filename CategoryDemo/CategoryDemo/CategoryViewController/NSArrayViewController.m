//
//  NSArrayViewController.m
//  CategoryDemo
//
//  Created by hadlinks on 2019/7/15.
//  Copyright © 2019 Ningbo Hadlinks IOT Science&Technology Co.,Ltd. All rights reserved.
//

#import "NSArrayViewController.h"
#import "HDLHelper.h"

@interface NSArrayViewController ()

@end

@implementation NSArrayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    // 1. NSArray
    NSArray *testArray1 = @[ @"H", @"D", @"L" ];
    // 正常取值
    NSString *letter1 = [testArray1 objectAtIndex:0];
    // 越界取值
//    NSString *letter2 = [testArray1 objectAtIndex:3]; // 崩溃
    NSString *letter2 = [testArray1 x_objectAtIndex:3]; // 不崩溃
    NSLog(@"letter1: %@, letter2: %@", letter1, letter2);
 
    
    // 2. NSMutableArray
    NSMutableArray *testArray2 = [NSMutableArray array];
    
    // 追加空值元素
//    [testArray2 addObject:nil]; // 崩溃
    [testArray2 x_addObject:nil]; // 不崩溃
    
    // 越界插入
//    [testArray2 insertObject:@"D0" atIndex:2]; // 崩溃
    [testArray2 x_insertObject:@"D0" atIndex:2]; // 不崩溃
    
    
    [testArray2 insertObject:@"D1" atIndex:0];
    [testArray2 x_insertObjectAtFirstWithObject:@"D2"];
    
    // 越界移除
//    [testArray2 removeObjectAtIndex:2]; // 崩溃
    [testArray2 x_removeObjectAtIndex:2]; // 不崩溃
    
    // 越界替换
//    [testArray2 replaceObjectAtIndex:2 withObject:@"D3"]; // 崩溃
    [testArray2 x_replaceObjectAtIndex:2 withObject:@"D3"]; // 不崩溃
    
    // 追加空值
    [testArray2 addObjectsFromArray:nil];
    [testArray2 x_addObjectsFromArray:nil];
    
    NSLog(@"testArray2: %@", testArray2.description);
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor colorWithRed:38 / 255.0 green:155 / 255.0 blue:166 / 255.0 alpha:1.0];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
