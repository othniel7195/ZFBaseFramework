//
//  ZFDownLoadTests.m
//  ZFBaseFramework_Tests
//
//  Created by zhao.feng on 2019/1/24.
//  Copyright © 2019年 478043385@qq.com. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZFDownLoader.h"

@interface ZFDownLoadTests : XCTestCase

@end

@implementation ZFDownLoadTests

- (void)setUp {
    
}

- (void)tearDown {
    
}

- (void)testExample {
    NSURL *url = [NSURL URLWithString:@"https://github-production-release-asset-2e65be.s3.amazonaws.com/73220421/bb250f80-1b07-11e9-9c0d-a189d51e506b?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20190124%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20190124T071012Z&X-Amz-Expires=300&X-Amz-Signature=79e77028de961aadc72beaa8b07f22eba3c09f72745d0b19d88cde198525ffee&X-Amz-SignedHeaders=host&actor_id=1490943&response-content-disposition=attachment%3B%20filename%3DKeka-1.1.10.dmg&response-content-type=application%2Foctet-stream"];
    ZFDownLoader *downLoader = [[ZFDownLoader alloc] init];
    [downLoader downLoadWithURL:url
                   downLoadInfo:^(long long fileSize) {
                       
                   } downLoadSuccess:^(NSString * _Nonnull cachePath) {
                       
                   } downLoadFail:^{
                       
                   }];
}

- (void)testPerformanceExample {
    
    [self measureBlock:^{
        
    }];
}

@end
