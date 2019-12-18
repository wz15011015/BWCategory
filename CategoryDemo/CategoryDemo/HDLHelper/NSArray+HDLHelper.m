//
//  NSArray+HDLHelper.m
//  CategoryDemo
//
//  Created by hadlinks on 2019/7/15.
//  Copyright © 2019 Ningbo Hadlinks IOT Science&Technology Co.,Ltd. All rights reserved.
//

#import "NSArray+HDLHelper.h"

// 是否开启Log: 0-关闭  1-开启
#define HDL_NSARRAY_LOG_ENABLE 1


@implementation NSArray (HDLHelper)

/**
 获取元素 (越界检测)

 @param index 索引值
 @return 获取的元素为NSNull时,返回nil
 */
- (id)x_objectAtIndex:(NSUInteger)index {
    // 越界检测
    if (index >= self.count) {
#if HDL_NSARRAY_LOG_ENABLE
        NSLog(@"越界错误: x_objectAtIndex:, index:%ld, count:%ld", index, self.count);
#else
#endif
        return nil;
    }
    
    id value = [self objectAtIndex:index];
    // 判断是否为Null,为Null时返回nil
    if (value == [NSNull null]) {
        return nil;
    }
    
    return value;
}

@end


@implementation NSMutableArray (HDLHelper)

/**
 追加元素 (空值检测)

 @param anObject 元素
 */
- (void)x_addObject:(id)anObject {
    // 空值检测
    if (anObject == nil || anObject == [NSNull null]) {
#if HDL_NSARRAY_LOG_ENABLE
        NSLog(@"空值错误: x_addObject:");
#else
#endif
        return;
    }
    
    [self addObject:anObject];
}

/**
 插入元素 (越界检测 / 空值检测)

 @param anObject 元素
 @param index 索引值
 */
- (void)x_insertObject:(id)anObject atIndex:(NSUInteger)index {
    // 空值检测
    if (anObject == nil || anObject == [NSNull null]) {
#if HDL_NSARRAY_LOG_ENABLE
        NSLog(@"空值错误: x_insertObject:atIndex:");
#else
#endif
        return;
    }
    
    // 越界检测
    if (index >= self.count) {
#if HDL_NSARRAY_LOG_ENABLE
        NSLog(@"越界错误: x_insertObject:atIndex:, index:%ld, count:%ld", index, self.count);
#else
#endif
        return;
    }
    
    [self insertObject:anObject atIndex:index];
}

/**
 向数组第一个位置插入元素 (空值检测)

 @param anObject 元素
 */
- (void)x_insertObjectAtFirstWithObject:(id)anObject {
    // 空值检测
    if (anObject == nil || anObject == [NSNull null]) {
#if HDL_NSARRAY_LOG_ENABLE
        NSLog(@"空值错误: x_insertObjectAtFirstWithObject:");
#else
#endif
        return;
    }
    
    if (self.count == 0) {
        [self addObject:anObject];
    } else {
        [self insertObject:anObject atIndex:0];
    }
}

/**
 移除元素 (越界检测)

 @param index 索引值
 */
- (void)x_removeObjectAtIndex:(NSUInteger)index {
    // 越界检测
    if (index >= self.count) {
#if HDL_NSARRAY_LOG_ENABLE
        NSLog(@"越界错误: x_removeObjectAtIndex:, index:%ld, count:%ld", index, self.count);
#else
#endif
        return;
    }
    
    [self removeObjectAtIndex:index];
}

/**
 替换元素 (越界检测 / 空值检测)

 @param index 索引值
 @param anObject 元素
 */
- (void)x_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    // 空值检测
    if (anObject == nil || anObject == [NSNull null]) {
#if HDL_NSARRAY_LOG_ENABLE
        NSLog(@"空值错误: x_replaceObjectAtIndex:withObject:");
#else
#endif
        return;
    }
    
    // 越界检测
    if (index >= self.count) {
#if HDL_NSARRAY_LOG_ENABLE
        NSLog(@"越界错误: x_replaceObjectAtIndex:withObject:, index:%ld, count:%ld", index, self.count);
#else
#endif
        return;
    }
    
    [self replaceObjectAtIndex:index withObject:anObject];
}

/**
 追加数组 (空值检测)

 @param otherArray 数组
 */
- (void)x_addObjectsFromArray:(NSArray *)otherArray {
    if (otherArray == nil || [otherArray isKindOfClass:[NSNull class]]) {
#if HDL_NSARRAY_LOG_ENABLE
        NSLog(@"空值错误: x_addObjectsFromArray:");
#else
#endif
        return;
    }
    
    [self addObjectsFromArray:otherArray];
}

@end
