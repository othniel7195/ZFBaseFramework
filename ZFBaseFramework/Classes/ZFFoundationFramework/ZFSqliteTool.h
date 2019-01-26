//
//  ZFSqliteTool.h
//  ZFBaseFramework
//
//  Created by zf on 2019/1/26.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZFSqliteTool : NSObject

//执行增删改
+ (BOOL)executeSql:(NSString *)sql uid:(NSString *)uid;
//批量执行增删改
+ (BOOL)executeSqls:(NSArray <NSString *>*)sqls uid:(NSString *)uid;

//查
+ (NSArray <NSDictionary *>*)querySql:(NSString *)sql uid:(NSString *)uid;

@end

NS_ASSUME_NONNULL_END
