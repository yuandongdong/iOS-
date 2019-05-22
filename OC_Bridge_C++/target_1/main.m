//
//  main.m
//  target_1
//
//  Created by 朗镜科技 on 2019/5/22.
//  Copyright © 2019 袁冬冬. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSObject *obj = [[NSObject alloc] init];
        NSLog(@"Hello, World!");
    }
    return 0;
}

/*
 
 OC --> c++--> 汇编语言 --> 机器语言
 
 1: xcode-select --print-path打印xcode命令行路径
 /Applications/Xcode.app/Contents/Developer
 
 2:sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer选择xcode版本
 
 3.OC的mian.m文件转化为c++文件
 xcrun -sdk iphoneos clang -arch arm64 -rewrite-objc main.m -o test_main-arm64.cpp
 
 4.main-arm64.cpp 找到NSObjcet_IMPL
 
 */
