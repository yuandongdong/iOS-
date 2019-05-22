//
//  main.m
//  target_3
//
//  Created by 朗镜科技 on 2019/5/22.
//  Copyright © 2019 袁冬冬. All rights reserved.
//

#import <Foundation/Foundation.h>

#include <objc/runtime.h>

@interface Person : NSObject

{
    
@public
    
    int age;
    
}

@end

@implementation Person



@end


@interface Student : Person

{
    
    @public
    
    int hight;
    
}

@end

@implementation Student

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        //运行时获取Person类的d内存
        NSLog(@"NSObjct内存字节= %zd,Person内存字节= %zd,Student内存字节= %zd",class_getInstanceSize([NSObject class]),class_getInstanceSize([Person class]),class_getInstanceSize([Student class]));

    }
    return 0;
}


@end


/*
 
 内存对齐为两个原则：
 原则 1. 前面的地址必须是后面的地址整数倍,不是整数倍就补齐。
 原则 2. 整个Struct的地址必须是最大字节的整数倍。
 
 */
