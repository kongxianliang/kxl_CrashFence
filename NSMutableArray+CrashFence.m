//
//  NSMutableArray+CrashFence.m
//  kxl_text
//
//  Created by 魔厨开发 on 2021/3/20.
//

#import "NSMutableArray+CrashFence.h"
#import <objc/runtime.h>

@implementation NSMutableArray (CrashFence)

+ (void)load {
    Class arrayMClass = NSClassFromString(@"__NSArrayM");
    
    //获取系统的添加元素的方法
//    Method addObject = class_getInstanceMethod(self, @selector(addObject:));
////    获取我们自定义添加元素的方法
//    Method avoidCrashAddObject = class_getInstanceMethod(self, @selector(avoidCrashAddObject:));
//    //将两个方法进行交换
//    method_exchangeImplementations(addObject, avoidCrashAddObject);
    
//    获取系统的获取元素的方法
    Method objectAt = class_getInstanceMethod(arrayMClass, @selector(objectAtIndex:));
    Method avoidCrashAtIndex = class_getInstanceMethod(arrayMClass, @selector(avoidCrashObjectAtIndex:));
    method_exchangeImplementations(objectAt, avoidCrashAtIndex);
    
//    根据下标移除元素
    Method removeObjectAt = class_getInstanceMethod(arrayMClass, @selector(removeObjectAtIndex:));
    Method removeAvoidCrashAtIndex = class_getInstanceMethod(arrayMClass, @selector(removeAvoidCrashObjectAtIndex:));
    method_exchangeImplementations(removeObjectAt, removeAvoidCrashAtIndex);
    
//    根据下标插入数组
    Method insetObjectAt = class_getInstanceMethod(arrayMClass, @selector(insertObject:atIndex:));
    Method insetAvoidCrashAtIndex = class_getInstanceMethod(arrayMClass, @selector(insertAvoidCrashObject:atIndex:));
    method_exchangeImplementations(insetObjectAt, insetAvoidCrashAtIndex);
    
//    根据下标替换数组
    Method replaceObjectAt = class_getInstanceMethod(arrayMClass, @selector(replaceObjectAtIndex:withObject:));
    Method replaceAvoidCrashAtIndex = class_getInstanceMethod(arrayMClass, @selector(replaceAvoidCrashObjectAtIndex:withObject:));
    method_exchangeImplementations(replaceObjectAt, replaceAvoidCrashAtIndex);
}

#pragma mark - private
//- (void)avoidCrashAddObject:(id)object {
//
//    @try {
//        //可能出现异常的方法 比如数组不能添加空对象 所以addObject可能会出现异常
//        [self avoidCrashAddObject:object];//本质是调用addObject
//
//    } @catch (NSException *exception) {
//
//        //捕捉到异常后对该异常进行处理
//        NSLog(@"\n异常名称：%@\n异常原因：%@",exception.name,exception.reason);
//
//    } @finally {
//        //这里的代码一定会执行，可以进行相应的操作
//
//    }
//}

- (id)avoidCrashObjectAtIndex:(NSUInteger)index {
    if (index < self.count) {
        return [self avoidCrashObjectAtIndex:index];//
    }
    return nil;
}

- (void)removeAvoidCrashObjectAtIndex:(NSUInteger)index {
//    if (index < self.count) {
//        [self removeAvoidCrashObjectAtIndex:index];//
//    }
//    
    @try {
        //可能出现异常的方法 比如数组不能添加空对象 所以addObject可能会出现异常
        [self removeAvoidCrashObjectAtIndex:index];//
    
    } @catch (NSException *exception) {
    
        //捕捉到异常后对该异常进行处理
        NSLog(@"\n异常名称：%@\n异常原因：%@",exception.name,exception.reason);
//        要抛出异常写,不抛则不会崩溃
//        @throw exception;
    } @finally {
        //这里的代码一定会执行，可以进行相应的操作
    
    }
}

- (void)insertAvoidCrashObject:(id)anObject atIndex:(NSUInteger)index {
    @try {
        //可能出现异常的方法 比如数组不能添加空对象 所以addObject可能会出现异常
        [self insertAvoidCrashObject:anObject atIndex:index];//

    } @catch (NSException *exception) {
        
        //捕捉到异常后对该异常进行处理
        NSLog(@"\n异常名称：%@\n异常原因：%@",exception.name,exception.reason);
        //        要抛出异常写,不抛则不会崩溃
        //        @throw exception;
    } @finally {
        //这里的代码一定会执行，可以进行相应的操作

    }
}

- (void)replaceAvoidCrashObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    @try {
        //可能出现异常的方法 比如数组不能添加空对象 所以addObject可能会出现异常
        [self replaceAvoidCrashObjectAtIndex:index withObject:anObject];//

    } @catch (NSException *exception) {

        //捕捉到异常后对该异常进行处理
        NSLog(@"\n异常名称：%@\n异常原因：%@",exception.name,exception.reason);
        //        要抛出异常写,不抛则不会崩溃
        //        @throw exception;
    } @finally {
        //这里的代码一定会执行，可以进行相应的操作

    }
}

@end
