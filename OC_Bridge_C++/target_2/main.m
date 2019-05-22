//
//  main.m
//  target_2
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
    
    int hight;
    
}

@end

@implementation Person

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        Person *person = [[Person alloc] init];
        
        person -> age = 10;
        
        person -> hight = 100;
        
        NSLog(@"person对象：%@",person);
        
        //运行时获取Person类的d内存
        NSLog(@"NSObjct内存字节= %zd,Person内存字节= %zd",class_getInstanceSize([NSObject class]),class_getInstanceSize([Person class]));
    }
    return 0;
}


@end

/*
 
 isa指针所占有内存8个字节
 int 变量 4个i字节
 String 变量 8个字节
 
 */
