//
//  NSObject+crashFence.m
//  kxl_text
//
//  Created by 魔厨开发 on 2021/3/20.
//

#import "NSObject+CrashFence.h"
//#import <objc/message.h>
//#import <objc/runtime.h>

@implementation NSObject (CrashFence)

-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    if ([NSObject methodSignatureForSelector:aSelector] == nil) {
        NSMethodSignature *signature = [NSMethodSignature signatureWithObjCTypes:"v@:"];
        return signature;
    }
    return [NSObject methodSignatureForSelector:aSelector];
}

-(void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"forwardInvocation");
}

@end
