//
//  ZFSqliteTool.m
//  ZFBaseFramework
//
//  Created by zf on 2019/1/26.
//

#import "ZFSqliteTool.h"
#import "ZFFileManagerTool.h"

@implementation ZFSqliteTool

static sqlite3 *db;

+ (BOOL)executeSql:(NSString *)sql uid:(NSString *)uid
{
    if (![self openDB:uid]) return NO;
    
    BOOL result = (sqlite3_exec(db, sql.UTF8String, nil, nil, nil) == SQLITE_OK);
    [self closeDB];
    
    if (!result) return NO;
    
    
    return YES;
}

+ (BOOL)executeSqls:(NSArray <NSString *>*)sqls uid:(NSString *)uid
{
    if (![self openDB:uid]) return NO;
    [self beginTransaction];
    for (NSString *sql in sqls) {
        BOOL result = (sqlite3_exec(db, sql.UTF8String, nil, nil, nil) == SQLITE_OK);
        
        if (!result) {
            [self rollBackTransaction];
            [self closeDB];
            return NO;
        }
    }
    [self commitTransaction];
    [self closeDB];
    return YES;
}


+ (NSArray <NSDictionary *>*)querySql:(NSString *)sql uid:(NSString *)uid
{
    if (![self openDB:uid]) return nil;
    
    //查询 要预处理语句
    sqlite3_stmt *stmt;
    //如果nByte参数为负数，则读取zSql到第一个零终止符
    //^如果nByte是正数，那么它就是从zSql读取的字节数。
    //^如果nByte为零，则没有准备好语句生成。
    BOOL result = (sqlite3_prepare(db, sql.UTF8String, -1, &stmt, nil) == SQLITE_OK);
    if (!result) {
        NSLog(@"预处理失败");
        //预处理失败 关闭预处理
        sqlite3_finalize(stmt);
        [self closeDB];
        return nil;
    }
    
    
    NSMutableArray *resultArray = [NSMutableArray array];
    //迭代每一行
    while (sqlite3_step(stmt) == SQLITE_ROW) {
        
        NSMutableDictionary *stepDic = [NSMutableDictionary dictionary];
        [resultArray addObject:stepDic];
        //获取一行有多少列
        int colNum = sqlite3_column_count(stmt);
        
        //遍历每一列
        for (int i = 0; i < colNum; i++) {
            //每一列名字
            const char *colNameChar = sqlite3_column_name(stmt, i);
            NSString *colNameStr = [[NSString alloc] initWithUTF8String:colNameChar];
            
            //每一列数据类型
            int type = sqlite3_column_type(stmt, i);
//
//#define SQLITE_INTEGER  1
//#define SQLITE_FLOAT    2
//#define SQLITE_BLOB     4
//#define SQLITE_NULL     5
//#ifdef SQLITE_TEXT
            
            id value;
            switch (type) {
                case SQLITE_INTEGER:
                    value = @(sqlite3_column_int(stmt, i));
                    break;
                case SQLITE_FLOAT:
                    value = @(sqlite3_column_double(stmt, i));
                    break;
                case SQLITE_BLOB://二进制数据
                    //CFBridgingRelease 把非OC的指针指向OC并且转换成ARC。由ARC自动释放对象
                    //CFBridgingRetain OC对象转换成CF对象时，将OC对象的所有权交给CF对象来管理
                    //代表OC要将对象所有权交给CF对象自己来管理,所以我们要在ref使用完成以后用CFRelease将其手动释放.
                    
                    value = CFBridgingRelease(sqlite3_column_blob(stmt, i));
                    break;
                case SQLITE_NULL:
                    value = @"";
                    break;
                case SQLITE_TEXT:
                {
                    const char *vChar = (const char *)sqlite3_column_text(stmt, i);
                    value = [[NSString alloc] initWithUTF8String:vChar];
                }
                    break;
                default:
                    break;
            }
            
            [stepDic setValue:value forKey:colNameStr];
            
        }
        
    }
    
    sqlite3_finalize(stmt);
    [self closeDB];
    
    return resultArray;
}

//开启事务
+ (void)beginTransaction
{
    sqlite3_exec(db, "begin transaction", nil, nil, nil);
}
//提交事务
+(void)commitTransaction
{
    sqlite3_exec(db, "commit transaction", nil, nil, nil);
}
//事务回滚
+(void)rollBackTransaction
{
    sqlite3_exec(db, "rollback transaction", nil, nil, nil);
}


+ (BOOL)openDB:(NSString *)uid
{
    if (uid.length < 0) {
        uid = @"common";
    }
    NSString *dbName = [NSString stringWithFormat:@"%@.db",uid];
    NSString *dbPath = [[ZFFileManagerTool cachePath] stringByAppendingPathComponent:dbName];
    NSLog(@"dbPath:%@",dbPath);
    
    if(sqlite3_open(dbPath.UTF8String, &db) != SQLITE_OK){
        NSLog(@"打开数据库失败");
        return NO;
    }
    
    return YES;
}

+ (void)closeDB
{
    sqlite3_close(db);
}
@end
