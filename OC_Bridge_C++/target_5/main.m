//
//  main.m
//  target_5
//
//  Created by 朗镜科技 on 2019/5/22.
//  Copyright © 2019 袁冬冬. All rights reserved.
//

#import <Foundation/Foundation.h>

#include <objc/runtime.h>

struct ydd_objc_class{
    Class isa;
};

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSObject *object = [[NSObject alloc] init];
        Class objectClass = [NSObject class];
        
//        struct ydd_objc_class *ydd_objectClass = (__bridge struct ydd_objc_class *)(objectClass);
        
        Class objectMetaClass = object_getClass([NSObject class]);
        
        NSLog(@"%p %p %p", object, objectClass, objectMetaClass);
    }
    return 0;
}

/*
 
 https://links.jianshu.com/go?to=https%3A%2F%2Fopensource.apple.com%2Ftarballs%2Fobjc4%2F
 
 https://developer.apple.com/documentation/objectivec/objective-c_runtime
 
 # if __arm64__
 #   define ISA_MASK        0x0000000ffffffff8ULL
 # elif __x86_64__
 #   define ISA_MASK        0x00007ffffffffff8ULL

 
 (lldb) p/x object->isa
 (Class) $0 = 0x001dffff9c24a141 NSObject
 (lldb) objectClass
 error: 'objectClass' is not a valid command.
 (lldb) p/x objectClass
 (Class) $1 = 0x00007fff9c24a140 NSObject
 (lldb) p/x 0x00007ffffffffff8 & 0x001dffff9c24a141
 (long) $2 = 0x00007fff9c24a140
 
 
 */
