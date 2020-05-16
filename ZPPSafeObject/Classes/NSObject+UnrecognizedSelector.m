//  NSObject+Safe.m
//  SafeObject
//  Created by admin on 2020/5/14.
//  Copyright © 2020 April. All rights reserved.
//

#import "NSObject+UnrecognizedSelector.h"
#import <objc/runtime.h>
@implementation NSObject (UnrecognizedSelector)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
 #ifdef  DEBUG
 #else
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       
       
          /**实例方法转发*/
          Method oldmeThodmethodSignatureForSelector = class_getInstanceMethod(self, @selector(methodSignatureForSelector:));
          Method newmeThodmethodSignatureForSelector = class_getInstanceMethod(self, @selector(new_methodSignatureForSelector:));
          method_exchangeImplementations(oldmeThodmethodSignatureForSelector, newmeThodmethodSignatureForSelector);
          
          Method oldmeThodforwardInvocation = class_getInstanceMethod(self, @selector(forwardInvocation:));
          Method newmeThodforwardInvocation = class_getInstanceMethod(self, @selector(new_forwardInvocation:));
          method_exchangeImplementations(oldmeThodforwardInvocation, newmeThodforwardInvocation);
          
          /**类方法转发*/
          Method calss_oldmeThodmethodSignatureForSelector = class_getClassMethod(self, @selector(methodSignatureForSelector:));
          Method calss_newmeThodmethodSignatureForSelector = class_getClassMethod(self, @selector(new_methodSignatureForSelector:));
          method_exchangeImplementations(calss_oldmeThodmethodSignatureForSelector, calss_newmeThodmethodSignatureForSelector);
          Method class_oldmeThodforwardInvocation = class_getClassMethod(self, @selector(forwardInvocation:));
          Method class_newmeThodforwardInvocation = class_getClassMethod(self, @selector(new_forwardInvocation:));
          method_exchangeImplementations(class_oldmeThodforwardInvocation, class_newmeThodforwardInvocation);
       
    });
}
#endif
#pragma clang diagnostic pop
#pragma mark - 实例方法转发
- (void)new_forwardInvocation:(NSInvocation *)anInvocation{
    NSString * string = [NSString stringWithFormat:@"%@ [%@ %@]: unrecognized selector sent to instance -> %@",[self getMethodType:anInvocation] ,[anInvocation.target class], NSStringFromSelector(anInvocation.selector) ,anInvocation.target];
    NSLog(@"%@",string);
    anInvocation.selector = @selector(unrecognizedSelector);
    [anInvocation invoke];
}
- (NSMethodSignature *)new_methodSignatureForSelector:(SEL)aSelector{
    NSMethodSignature * signature = [self new_methodSignatureForSelector:aSelector];
    if (signature == nil) {
        Class superClass =  class_getSuperclass(object_getClass(self));
        return [[superClass new] new_methodSignatureForSelector:aSelector];
    }
    return signature;
}

#pragma mark - 类方法转发
+ (NSMethodSignature *)new_methodSignatureForSelector:(SEL)aSelector{
    NSMethodSignature * signature = [self new_methodSignatureForSelector:aSelector];
    if (signature == nil) {
         Class superClass =  class_getSuperclass(self);
        return [superClass new_methodSignatureForSelector:aSelector];
    }
    return signature;
}
+ (void)new_forwardInvocation:(NSInvocation *)anInvocation{
    NSString * string = [NSString stringWithFormat:@"%@ [%@ %@]: unrecognized selector sent to instance -> [%@ class]",[self getMethodType:anInvocation] ,[anInvocation.target class], NSStringFromSelector(anInvocation.selector) ,anInvocation.target];
    NSLog(@"%@",string);
    anInvocation.selector = @selector(unrecognizedSelector);
    [anInvocation invoke];
    
}
#pragma mark -
- (void)unrecognizedSelector{
    
}
- (NSString *)getMethodType:(NSInvocation *)anInvocation{
    Class class =  object_getClass(anInvocation.target);
    if (class_isMetaClass(class)) {
        return @"+";
    }
    return @"-";
    
}
@end
