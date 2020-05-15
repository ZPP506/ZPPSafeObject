//  NSObject+Swizzling.h
//  SafeObjectCrash
//
//  Created by admin on 2020/5/14.
//  Copyright © 2020 April. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Swizzling)
+ (void)exchangeInstanceMethodWithSelfClass:(Class)selfClass
                           originalSelector:(SEL)originalSelector
                           swizzledSelector:(SEL)swizzledSelector;
@end
