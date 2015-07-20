//
//  Database_Utils.m
//  AudioNote
//
//  Created by lijunjie on 15-1-6.
//  Copyright (c) 2015年 Intfocus. All rights reserved.
//

#import "DatabaseUtils.h"
#import "FMDB.h"
#import "const.h"
#import "FileUtils.h"
#import "ExtendNSLogFunctionality.h"

@implementation DatabaseUtils

- (DatabaseUtils *)init {
    if (self = [super init]) {
        NSDictionary *localVersionInfo =[[NSBundle mainBundle] infoDictionary];
        _dbVersion = (NSString *)psd(localVersionInfo[@"Database Version"], @"NotSet");
        _dbPath    = [FileUtils getPathName:DATABASE_DIRNAME FileName:@"nxscae.db"];

        [self executeSQL:[self createTableProduct]];
        [self executeSQL:[self createTableProductDayinfo]];
        [self executeSQL:[self createTableProductCache]];
    }
    return self;
}

/**
 *  数据库初始化时，集中配置在这里
 */
- (NSString *)createTableProduct {
    return [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (             \
            id integer PRIMARY KEY AUTOINCREMENT,                                   \
            %@ varchar(100) NOT NULL,                                               \
            %@ varchar(200) NOT NULL,                                               \
            %@ float NOT NULL,                                                      \
            %@ float NOT NULL,                                                      \
            %@ integer NULL,                                                        \
            %@ float NULL,                                                          \
            %@ varchar(100) NULL,                                                   \
            %@ datetime NOT NULL DEFAULT (datetime(CURRENT_TIMESTAMP,'localtime')), \
            %@ datetime NOT NULL DEFAULT (datetime(CURRENT_TIMESTAMP,'localtime'))  \
            );                                                                      \
        CREATE INDEX IF NOT EXISTS idx_create_time ON %@(%@);",
        TNProduct,
        ColumnCode,
        ColumnFullName,
        ColumnHighPrice,
        ColumnLowPrice,
        ColumnSumNum,
        ColumnSumMoney,
        ColumnTime,
        DB_COLUMN_CREATED,
        DB_COLUMN_UPDATED,
        TNProduct,DB_COLUMN_CREATED];
}

- (NSString *) createTableProductDayinfo {
    return [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (             \
            id integer PRIMARY KEY AUTOINCREMENT,                                   \
            parent_id integer NOT NULL,                                             \
            %@ varchar(100) NOT NULL,                                               \
            %@ varchar(200) NOT NULL,                                               \
            %@ float NOT NULL,                                                      \
            %@ float NOT NULL,                                                      \
            %@ integer NULL,                                                        \
            %@ float NULL,                                                          \
            %@ varchar(100) NULL,                                                   \
            %@ float NULL,                                                          \
            %@ float NULL,                                                          \
            %@ float NULL,                                                          \
            %@ float NULL,                                                          \
            %@ integer NULL,                                                        \
            %@ float NULL,                                                          \
            %@ datetime NOT NULL DEFAULT (datetime(CURRENT_TIMESTAMP,'localtime')), \
            %@ datetime NOT NULL DEFAULT (datetime(CURRENT_TIMESTAMP,'localtime'))  \
            );                                                                      \
            CREATE INDEX IF NOT EXISTS idx_create_time ON %@(%@);",
            TNProductDayInfo,
            ColumnCode,
            ColumnFullName,
            ColumnHighPrice,
            ColumnLowPrice,
            ColumnSumNum,
            ColumnSumMoney,
            ColumnTime,
            ColumnYesterBlancePrice,
            ColumnOpenPrice,
            ColumnCurPrice,
            ColumnCurrentGains,
            ColumnTotalAmount,
            ColumnTotalMoney,
            DB_COLUMN_CREATED,
            DB_COLUMN_UPDATED,
            TNProductDayInfo, DB_COLUMN_CREATED];
}

- (NSString *) createTableProductCache {
    return [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (             \
            id integer PRIMARY KEY AUTOINCREMENT,                                   \
            parent_id integer NOT NULL,                                             \
            %@ varchar(1000) NOT NULL,                                              \
            %@ datetime NOT NULL DEFAULT (datetime(CURRENT_TIMESTAMP,'localtime')), \
            %@ datetime NOT NULL DEFAULT (datetime(CURRENT_TIMESTAMP,'localtime'))  \
            );                                                                      \
            CREATE INDEX IF NOT EXISTS idx_create_time ON %@(%@);",
            TNProductCache,
            ColumnContent,
            DB_COLUMN_CREATED,
            DB_COLUMN_UPDATED,
            TNProductCache, DB_COLUMN_CREATED];
}
/**
 *  需要的取值方式未定义或过于复杂时，直接执行SQL语句
 *  若是SELECT则返回搜索到的行ID
 *  若是DELECT/INSERT可忽略返回值
 *
 *  @param sql SQL语句，请参考SQLite语法
 *
 *  @return 返回搜索到数据行的ID,执行失败返回该代码行
 */
- (NSInteger)executeSQL:(NSString *)sql {
    FMDatabase *db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        BOOL isExecuteSuccessfully = [db executeStatements:sql];
        if(!isExecuteSuccessfully) {
            NSLog(@"Executed faile with SQL below:\n%@", sql);
        }
        [db close];
    }
    else {
        NSLog(@"Cannot open DB at the path: %@", self.dbPath);
    }
    return -__LINE__;
} // end of executeSQL()

- (NSInteger)findID:(NSString *)sql {
    NSInteger ID = -1;
    FMDatabase *db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        FMResultSet *s = [db executeQuery:sql];
        while([s next]) {
            ID   = [s intForColumnIndex:0];
        }
        [db close];
    }
    return ID;
}
@end

