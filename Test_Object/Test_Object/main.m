//
//  main.m
//  Test_Object
//
//  Created by 朗镜科技 on 2019/5/21.
//  Copyright © 2019 朗镜科技. All rights reserved.
//

#import <Foundation/Foundation.h>

#include <objc/runtime.h>

//int main(int argc, const char * argv[]) {
//    @autoreleasepool {
//        // insert code here...
//        NSObject *obj = [[NSObject alloc] init];
//        NSLog(@"Hello, World!");
//    }
//    return 0;
//}

/*
 
 OC --> c++--> 汇编语言 --> 机器语言
 
 1: xcode-select --print-path打印xcode命令行路径
 /Applications/Xcode.app/Contents/Developer
 
 2:sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer选择xcode版本
 
 3.OC的mian.m文件转化为c++文件
 xcrun -sdk iphoneos clang -arch arm64 -rewrite-objc main.m -o test_main-arm64.cpp
 
 4.main-arm64.cpp 找到NSObjcet_IMPL
 
  isa指针所占有内存8个字节
  int 变量 4个i字节
  String 变量 8个字节
 
 内存对齐为两个原则：
 原则 1. 前面的地址必须是后面的地址整数倍,不是整数倍就补齐。
 原则 2. 整个Struct的地址必须是最大字节的整数倍。
 
 OC对象主要分为三类：
 instance对象（实例对象）:包含 1.isa指针，2.其他成员变量
 class对象（类对象）：1.isa指针 2.superclass指针 3.类的属性信息（@property）4.类的成员变量信息（ivar）5.类的对象方法信息（instance method）6.类的协议信息（protocol）
 meta-class对象(元类)：1.isa指针 2.superclass指针 3.类的类方法的信息（class method）
 
 instance的isa指向class
 class的isa指向meta-class
 
 instance-----isa------>class-----isa------>meta-class
 
 instance调用父类方法的时候会用到superclass指针
 
 instance的isa指向class
 class的isa指向meta-class
 meta-class的isa指向基类的meta-class，基类的isa指向自己
 class的superclass指向父类的class，如果没有父类，superclass指针为nil
 meta-class的superclass指向父类的meta-class，基类的meta-class的superclass指向基类的class
 instance调用对象方法的轨迹，isa找到class，方法不存在，就通过superclass找父类
 class调用类方法的轨迹，isa找meta-class，方法不存在，就通过superclass找父类
 
 
 Class objectClass1 = [object1 class];
 Class objectClass2 = [object2 class];
 Class objectClass3 = [NSObject class];
 
 // runtime
 Class objectClass4 = object_getClass(object1);
 Class objectClass5 = object_getClass(object2);
 //runtime中传入类对象此时得到的就是元类对象
 Class objectMetaClass = object_getClass([NSObject class]);
 NSLog(@"%p %p %p %p %p", objectClass1, objectClass2, objectClass3, objectClass4, objectClass5);
 
 */

@interface Person : NSObject

{
@public
    int age;
    
    int hight;
    
}

@end


@implementation Person

//int main(int argc, const char * argv[]) {
//    @autoreleasepool {
//        // insert code here...
//        Person *person = [[Person alloc] init];
//
//        person -> age = 10;
//
//        person -> hight = 100;
//
//        NSLog(@"person对象：%@",person);
//
//        //运行时获取Person类的d内存
//        NSLog(@"NSObjct内存字节= %zd,Person内存字节= %zd",class_getInstanceSize([NSObject class]),class_getInstanceSize([Person class]));
//    }
//    return 0;
//}

@end


@interface Student : Person

{
@public
    
    int no;
    
}

@end

@implementation Student

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //运行时获取Person类的d内存
        NSLog(@"NSObjct内存字节= %zd,Person内存字节= %zd,Student内存字节= %zd",class_getInstanceSize([NSObject class]),class_getInstanceSize([Person class]),class_getInstanceSize([Student class]));
        
        /*
         (lldb) p/x object->isa
         (Class) $0 = 0x001dffff9c24a141 NSObject
         (lldb) p/x objectClass
         (Class) $1 = 0x00007fff9c24a140 NSObject
         */
        NSObject *object = [[NSObject alloc] init];
        Class objectClass = [NSObject class];
        Class objectMetaClass = object_getClass([NSObject class]);
        
        NSLog(@"%p %p %p", object, objectClass, objectMetaClass);
        
        
    }
    return 0;
}


@end
