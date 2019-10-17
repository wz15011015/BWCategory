//
//  NSArray+HDLHelper.h
//  CategoryDemo
//
//  Created by hadlinks on 2019/7/15.
//  Copyright © 2019 Ningbo Hadlinks IOT Science&Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 添加一些空值检测 / 越界检测,避免产生崩溃
 */

@interface NSArray (HDLHelper)

/**
 获取元素 (越界检测)
 
 @param index 索引值
 @return 获取的元素为NSNull时,返回nil
 */
- (id)x_objectAtIndex:(NSUInteger)index;

@end


@interface NSMutableArray (HDLHelper)

/**
 追加元素 (空值检测)
 
 @param anObject 元素
 */
- (void)x_addObject:(id)anObject;

/**
 插入元素 (越界检测 / 空值检测)
 
 @param anObject 元素
 @param index 索引值
 */
- (void)x_insertObject:(id)anObject atIndex:(NSUInteger)index;

/**
 向数组第一个位置插入元素 (空值检测)
 
 @param anObject 元素
 */
- (void)x_insertObjectAtFirstWithObject:(id)anObject;

/**
 移除元素 (越界检测)
 
 @param index 索引值
 */
- (void)x_removeObjectAtIndex:(NSUInteger)index;

/**
 替换元素 (越界检测 / 空值检测)
 
 @param index 索引值
 @param anObject 元素
 */
- (void)x_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;

/**
 追加数组 (空值检测)
 
 @param otherArray 数组
 */
- (void)x_addObjectsFromArray:(NSArray *)otherArray;

@end

NS_ASSUME_NONNULL_END
