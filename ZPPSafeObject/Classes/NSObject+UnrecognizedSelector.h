//  NSObject+Safe.h
//  SafeObject
//  Created by admin on 2020/5/14.
//  Copyright © 2020 April. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface NSObject (UnrecognizedSelector)
/* 不能为 NSObject 添加方法 unrecognized selector sent to instance 请使用子类 */
+ (void)avoidCrashExchangeMethodIfDeal;
@end

