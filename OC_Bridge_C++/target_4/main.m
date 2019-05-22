//
//  main.m
//  target_4
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

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //instance对象
        NSObject *object1 = [[NSObject alloc] init];
        NSObject *object2 = [[NSObject alloc] init];
        Person *per = [[Person alloc] init];
        
        //class对象(一个类在内存中只有一个class对象)
        Class objectClass1 = [object1 class];
        Class objectClass2 = [object2 class];
        Class objectClass3 = [NSObject class];
        // runtime
        Class objectClass4 = object_getClass(object1);
        Class objectClass5 = object_getClass(object2);
        NSLog(@"%p %p %p %p %p", objectClass1, objectClass2, objectClass3, objectClass4, objectClass5);
        
        //元类(meta-class)
        //runtime中传入类对象此时得到的就是元类对象,每个类在内存中有且只有一个meta-class对象
        Class objectMetaClass = object_getClass([NSObject class]);
        Class objectMetaClass1 = object_getClass([NSObject class]);
        // 而调用类对象的class方法时得到还是类对象，无论调用多少次都是类对象
        Class cls = [[NSObject class] class];
        Class cls1 = [NSObject class];
        BOOL flag = class_isMetaClass(objectMetaClass); // 判断该对象是否为元类对象
        NSLog(@"%p %p %p %p %d", objectMetaClass, objectMetaClass1, cls, cls1, flag); // 后面两个地址相同，说明多次调用class得到的还是类对象
        
    }
    return 0;
}


@end


/*
 
 OC对象主要分为三类：
 instance对象（实例对象）:包含 1.isa指针，2.其他成员变量
 class对象（类对象）：1.isa指针 2.superclass指针 3.类的属性信息（@property）4.类的成员变量信息（ivar）5.类的对象方法信息（instance method）6.类的协议信息（protocol）
 meta-class对象(元类)：1.isa指针 2.superclass指针 3.类的类方法的信息（class method）
 
 1.当对象调用实例方法的时候，实例方法信息是存储在class类对象中的，那么要想找到实例方法，就必须找到class类对象，isa的作用
 instance的isa指向class，当调用对象方法时，通过instance的isa找到class，最后找到对象方法的实现进行调用。
 
 2.当类对象调用类方法的时候，同上，类方法是存储在meta-class元类对象中的。那么要找到类方法，就需要找到meta-class元类对象，而class类对象的isa指针就指向元类对象
 当调用类方法时，通过class的isa找到meta-class，最后找到类方法的实现进行调用
 
 3.当对象调用其父类对象方法的时候，用到class类对象superclass指针。
 例如:Student extends Person
 Student *stu = [[Student alloc] init];//instance实例对象
 instance实例对象调用父类Person的方法，Student instance ---isa----> Student class ---superclass---> Person class 调用Person中的对象方法,如果没有找到就会通过Person的superclass指针找到NSObject的class对象，去寻找响应的方法
 
 4.当类对象调用父类的类方法时，就需要先通过isa指针找到meta-class，然后通过superclass去寻找响应的方法
 Student class ---isa----> Student meta-class ---superclass---> Person meta-class
 
 
 
 instance的isa指向class
 class的isa指向meta-class
 meta-class的isa指向基类的meta-class，基类的isa指向自己
 class的superclass指向父类的class，如果没有父类，superclass指针为nil
 meta-class的superclass指向父类的meta-class，基类的meta-class的superclass指向基类的class
 instance调用对象方法的轨迹，isa找到class，方法不存在，就通过superclass找父类
 class调用类方法的轨迹，isa找meta-class，方法不存在，就通过superclass找父类
 
 */
