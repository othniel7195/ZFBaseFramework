//
//  ZFRealmTests.m
//  ZFBaseFramework_Tests
//
//  Created by zf on 2019/1/27.
//  Copyright © 2019 478043385@qq.com. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Realm.h"
#import "ZFStudent.h"

@interface ZFRealmTests : XCTestCase

@end

@implementation ZFRealmTests

- (void)setUp {
    
}

- (void)tearDown {
    
}

- (void)testExample {
    NSLog(@"沙盒:%@",NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask ,YES)[0]);
    //[self testSaveStudent];
    //[self testUpdateStudent];
    //[self testRemoveStudent];
}

- (void)testPerformanceExample {
    
    [self measureBlock:^{
       
    }];
}

- (void)testSearchStudent
{
    
}

- (void)testRemoveStudent
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    RLMResults *sts = [ZFStudent objectsWhere:@"name == 'zhaofeng2'"];
    for (ZFStudent *st in sts) {
        [realm transactionWithBlock:^{
            
            [realm deleteObject:st];
        }];
    }
    
    RLMResults *sts2 = [ZFStudent allObjects];
    for (ZFStudent *st in sts2) {
        [realm transactionWithBlock:^{
            
            [realm deleteObject:st];
        }];
    }
}

- (void)testUpdateStudent
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    ZFStudent *stu2 = [ZFStudent objectForPrimaryKey:@(2)];

    [realm transactionWithBlock:^{
        stu2.name = @"王二小";
        [realm addOrUpdateObject:stu2];
    }];
    
    ZFStudent *st3 = [[ZFStudent alloc] initWithValue:@[@(2),@"zhaofeng2",@(31),@"又被换了"]];
    [realm transactionWithBlock:^{
        [realm addOrUpdateObject:st3];
    }];
                      
    
}

- (void)testSaveStudent
{
    ZFStudent *stu1 = [[ZFStudent alloc] initWithValue:@{@"num":@(1),@"name":@"zhaofeng",@"age":@(31),@"dis":@"一个c码农"}];
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm beginWriteTransaction];
    
    [realm addObject:stu1];
    
    [realm commitWriteTransaction];
    
     ZFStudent *stu2 = [[ZFStudent alloc] initWithValue:@[@(2),@"zhaofeng1",@(31),@"一个码农"]];
    [realm transactionWithBlock:^{
        [realm addObject:stu2];
    }];
    
    [realm transactionWithBlock:^{
        [ZFStudent createInRealm:realm withValue:@[@(3),@"zhaofeng2",@(30),@"搞oC的"]];
    }];
    
}

@end
