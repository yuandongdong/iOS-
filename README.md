# iOS-底层原理
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

