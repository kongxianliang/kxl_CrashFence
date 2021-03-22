//
//  NSMutableDictionary+CrashFence.m
//  kxl_text
//
//  Created by 魔厨开发 on 2021/3/22.
//

#import "NSMutableDictionary+CrashFence.h"
#import <objc/runtime.h>

@implementation NSMutableDictionary (CrashFence)

+(void)load {
    Class dicMClass = NSClassFromString(@"__NSDictionaryM");
    Method setObjc = class_getInstanceMethod(dicMClass, @selector(setObject:forKey:));
    Method crashSetObjc = class_getInstanceMethod(dicMClass, @selector(crashSetObject:forKey:));
    method_exchangeImplementations(setObjc, crashSetObjc);
    
    Method setValue = class_getInstanceMethod(dicMClass, @selector(setValue:forKey:));
    Method crashSetValue = class_getInstanceMethod(dicMClass, @selector(crashSetValue:forKey:));
    method_exchangeImplementations(setValue, crashSetValue);
}

- (void)crashSetObject:(id)anObject forKey:(id<NSCopying>)aKey {
    @try {
        //可能出现异常的方法 比如数组不能添加空对象 所以addObject可能会出现异常
        [self crashSetObject:anObject forKey:aKey];//
        
    } @catch (NSException *exception) {
        
        //捕捉到异常后对该异常进行处理
        NSLog(@"\n异常名称：%@\n异常原因：%@",exception.name,exception.reason);
        //        要抛出异常写,不抛则不会崩溃
        //        @throw exception;
    } @finally {
        //这里的代码一定会执行，可以进行相应的操作
        
    }
}
- (void)crashSetValue:(id)value forKey:(NSString *)key {
    @try {
        //可能出现异常的方法 比如数组不能添加空对象 所以addObject可能会出现异常
        [self crashSetValue:value forKey:key];//
        
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
