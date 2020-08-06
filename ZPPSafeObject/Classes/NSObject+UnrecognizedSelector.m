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
+ (void)setArray:(Class)class{
    NSMutableArray * arrayTemp = [NSMutableArray arrayWithArray:[self getArray]];
    [arrayTemp addObject:NSStringFromClass(class)];
    objc_setAssociatedObject(self, @selector(getArray), arrayTemp, OBJC_ASSOCIATION_RETAIN);
}
+ (NSArray *)getArray{
   id array = objc_getAssociatedObject(self, @selector(getArray));
    if(array == nil){
        return [NSMutableArray array];
    }
    return array;
}
+ (void)avoidCrashExchangeMethodIfDeal{
    NSAssert((self != NSObject.class), @"警告： 不能为 NSObject 添加方法 unrecognized selector sent to instance 请使用子类");
    [NSObject setArray:self];
    [self ccustomLoad];
}

+ (void)ccustomLoad{
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
#pragma clang diagnostic pop
#pragma mark - 实例方法转发
- (void)new_forwardInvocation:(NSInvocation *)anInvocation{
     if (![[NSObject getArray] containsObject:NSStringFromClass(self.class)]) {
         [self new_forwardInvocation:anInvocation];
       return;
     }
    NSString * string = [NSString stringWithFormat:@"%@ [%@ %@]: unrecognized selector sent to instance -> %@",[self getMethodType:anInvocation] ,[anInvocation.target class], NSStringFromSelector(anInvocation.selector) ,anInvocation.target];
    NSLog(@"%@",string);
    anInvocation.selector = @selector(unrecognizedSelector);
    [anInvocation invoke];
}
- (NSMethodSignature *)new_methodSignatureForSelector:(SEL)aSelector{
    NSMethodSignature * signature = [self new_methodSignatureForSelector:aSelector];
    if ([[NSObject getArray] containsObject:NSStringFromClass(self.class)]) {
        if (signature == nil) {
            return [self new_methodSignatureForSelector:@selector(unrecognizedSelector)];
        }
    }
    return signature;
}

#pragma mark - 类方法转发
+ (NSMethodSignature *)new_methodSignatureForSelector:(SEL)aSelector{
    NSMethodSignature * signature = [self new_methodSignatureForSelector:aSelector];
    if ([[NSObject getArray] containsObject:NSStringFromClass(self.class)]) {
        if (signature == nil) {
            return [NSMethodSignature signatureWithObjCTypes: "v@:"];
        }
    }
    return signature;
}
+ (void)new_forwardInvocation:(NSInvocation *)anInvocation{
    if (![[NSObject getArray] containsObject:NSStringFromClass(self.class)]) {
        [self new_forwardInvocation:anInvocation];
        return;
    }
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
