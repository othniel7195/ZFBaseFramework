//
//  ZFDBTests.m
//  ZFBaseFramework_Tests
//
//  Created by zf on 2019/1/26.
//  Copyright © 2019 478043385@qq.com. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <ZFBaseFramework/ZFSqliteTool.h>

@interface ZFDBTests : XCTestCase

@end

@implementation ZFDBTests

- (void)setUp {


}

- (void)tearDown {
    
}

- (void)testExample {
    
    NSString *createTable = @"CREATE TABLE IF NOT EXISTS Person(Id_P INTEGER ,LastName varchar(255),FirstName varchar(255),Address varchar(255),City varchar(255))";
    //创建数据库和表
    BOOL r = [ZFSqliteTool executeSql:createTable uid:@"Persons"];
    XCTAssertTrue(r,@"创建表成功");


    //插入 一条数据
    NSString *insertOne = @"INSERT INTO Person VALUES ('1','Gates', 'Bill', 'Xuanwumen 10', 'Beijing') ";
    r = [ZFSqliteTool executeSql:insertOne uid:@"Persons"];
    XCTAssertTrue(r,@"插入一条数据成功");

    //查询一下
    NSString *q1 = @"SELECT * FROM Person";
    NSArray *a1 = [ZFSqliteTool querySql:q1 uid:@"Persons"];
    NSLog(@"a1:%@",a1);
    
    //插入3条数据
    NSString *i1 = @"INSERT INTO Person VALUES ('2','Yang', 'Wei', 'Xuanwumen 100', 'Beijing') ";
    NSString *i2 = @"INSERT INTO Person VALUES ('3','Li', 'Song', 'Xuanwumen 10', 'Shanghai') ";
    NSString *i3 = @"INSERT INTO Person VALUES ('4','Qi', 'Yi', 'WuYiFan 10', 'ZheJiang') ";
    NSArray *sqls = @[i1,i2,i3];
    r = [ZFSqliteTool executeSqls:sqls uid:@"Persons"];
    XCTAssertTrue(r,@"插入三条数据成功");

    //查询2
    NSArray *a2 = [ZFSqliteTool querySql:q1 uid:@"Persons"];
    NSLog(@"a2:%@",a2);
    
    
}

@end
