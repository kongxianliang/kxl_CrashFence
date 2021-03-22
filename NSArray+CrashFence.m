//
//  NSArray+CrashFence.m
//  kxl_text
//
//  Created by 魔厨开发 on 2021/3/22.
//

#import "NSArray+CrashFence.h"
#import <objc/runtime.h>

@implementation NSArray (CrashFence)

+ (void)load {
    //包含多个对象的NSArray
    Class arrayIClass = NSClassFromString(@"__NSArrayI");
    Method objectAt = class_getInstanceMethod(arrayIClass, @selector(objectAtIndex:));
    Method avoidCrashAtIndex = class_getInstanceMethod(arrayIClass, @selector(avoidCrashObjectAtIndex:));
    method_exchangeImplementations(objectAt, avoidCrashAtIndex);
    
    //包含0个对象的NSArray
    Class arrayClass0 = NSClassFromString(@"__NSArray0");
    Method objectAt0 = class_getInstanceMethod(arrayClass0, @selector(objectAtIndex:));
    Method avoidCrashAtIndex0 = class_getInstanceMethod(arrayClass0, @selector(avoidCrashObject_0_AtIndex:));
    method_exchangeImplementations(objectAt0, avoidCrashAtIndex0);
    
    //包含1个对象的NSArray
    Class arrayIClass1 = NSClassFromString(@"__NSSingleObjectArrayI");
    Method objectAt1 = class_getInstanceMethod(arrayIClass1, @selector(objectAtIndex:));
    Method avoidCrashAtIndex1 = class_getInstanceMethod(arrayIClass1, @selector(avoidCrashObject_1_AtIndex:));
    method_exchangeImplementations(objectAt1, avoidCrashAtIndex1);
    
}

#pragma mark - private
- (id)avoidCrashObjectAtIndex:(NSUInteger)index {
    if (index < self.count) {
        return [self avoidCrashObjectAtIndex:index];//
    }
    return nil;
}

- (id)avoidCrashObject_0_AtIndex:(NSUInteger)index {
    if (index < self.count) {
        return [self avoidCrashObject_0_AtIndex:index];//
    }
    return nil;
}

- (id)avoidCrashObject_1_AtIndex:(NSUInteger)index {
    if (index < self.count) {
        return [self avoidCrashObject_1_AtIndex:index];//
    }
    return nil;
}

@end
