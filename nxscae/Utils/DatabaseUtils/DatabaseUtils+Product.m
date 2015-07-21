//
//  DatabaseUtils+ActionLog.m
//  iSearch
//
//  Created by lijunjie on 15/7/9.
//  Copyright (c) 2015年 Intfocus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseUtils+Product.h"
#import "FMDB.h"
#import "const.h"
#import "ProductDayinfo.h"
#import "FileUtils.h"
#import "ExtendNSLogFunctionality.h"

@implementation DatabaseUtils (Product)
/**
 *  find then update or create it.
 *
 *  @param product params
 *  @param time    table time
 *
 *  @return ID
 */
- (NSInteger)findOrCreateProduct:(NSDictionary *)product Time:(NSString *)time {
    NSString *findSQL = [NSString stringWithFormat:@"select id from %@ where %@ = '%@' and %@ = '%@';",
                         TNProduct,
                         ColumnCode,
                         product[@"code"],
                         ColumnFullName,
                         product[@"fullname"]];
    NSInteger ID = [self findID:findSQL];
    if(ID >= 0) {
        NSString *updateSQL = [NSString stringWithFormat:@"update %@ set %@ = %@, %@ = %@, %@ = '%@';",
                               TNProduct,
                               ColumnHighPrice,
                               product[@"HighPrice"],
                               ColumnLowPrice,
                               product[@"LowPrice"],
                               ColumnTime,
                               time];
        [self executeSQL:updateSQL];
        
        return ID;
    } else {
        NSString *insertSQL = [NSString stringWithFormat:@"insert into %@(%@, %@, %@, %@, %@, %@, %@)   \
                               values('%@', '%@', %@, %@, %@, %@, '%@');",
                               TNProduct,
                               ColumnCode,
                               ColumnFullName,
                               ColumnHighPrice,
                               ColumnLowPrice,
                               ColumnSumNum,
                               ColumnSumMoney,
                               ColumnTime,
                               product[@"code"],
                               product[@"fullname"],
                               product[@"HighPrice"],
                               product[@"LowPrice"],
                               product[@"TotalAmount"],
                               product[@"TotalMoney"],
                               time];
        [self executeSQL:insertSQL];
        
        return [self findID:findSQL];
    }
}

- (void)findOrCreateProductDayinfo:(NSInteger)parentID Params:(NSDictionary *)product Time:(NSString *)time {
    NSString *findSQL = [NSString stringWithFormat:@"select id from %@ where %@ = %li and %@ = '%@' and %@ = '%@' and %@ = '%@' \
                         and %@ = %@ and %@ = %@ and %@ = %@ and %@ = %@ and %@ = %@ and %@ = %@ and %@ = %@;",
                         TNProductDayInfo,
                         @"parent_id",
                         (long)parentID,
                         ColumnCode,
                         product[@"code"],
                         ColumnFullName,
                         product[@"fullname"],
                         ColumnOpenPrice,
                         product[@"OpenPrice"],
                         ColumnCurPrice,
                         product[@"CurPrice"],
                         ColumnTotalAmount,
                         product[@"TotalAmount"],
                         ColumnTotalMoney,
                         product[@"TotalMoney"],
                         ColumnCurrentGains,
                         product[@"CurrentGains"],
                         ColumnYesterBlancePrice,
                         product[@"YesterBalancePrice"],
                         ColumnHighPrice,
                         product[@"HighPrice"],
                         ColumnLowPrice,
                         product[@"LowPrice"]];
    NSInteger ID = [self findID:findSQL];
    if(ID < 0) {
        NSString *insertSQL = [NSString stringWithFormat:@"insert into %@(%@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@)   \
                               values(%li, '%@', '%@', %@, %@, %@, %@, %@, %@, %@, %@, '%@');",
                               TNProductDayInfo,
                               @"parent_id",
                               ColumnCode,
                               ColumnFullName,
                               ColumnOpenPrice,
                               ColumnCurPrice,
                               ColumnTotalAmount,
                               ColumnTotalMoney,
                               ColumnCurrentGains,
                               ColumnYesterBlancePrice,
                               ColumnHighPrice,
                               ColumnLowPrice,
                               ColumnTime,
                               (long)parentID,
                               product[@"code"],
                               product[@"fullname"],
                               product[@"OpenPrice"],
                               product[@"CurPrice"],
                               product[@"TotalAmount"],
                               product[@"TotalMoney"],
                               product[@"CurrentGains"],
                               product[@"YesterBalancePrice"],
                               product[@"HighPrice"],
                               product[@"LowPrice"],
                               time];
        [self executeSQL:insertSQL];
    }
}

- (void)insertProductCache:(NSData *)data {
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSString *insertSQL = [NSString stringWithFormat:@"insert into %@(%@) \
                           values('%@');",
                           TNProductCache,
                           ColumnContent,
                           jsonString];
    [self executeSQL:insertSQL];
}

- (NSArray *)productDayinfos {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *selectSQL = [NSString stringWithFormat:@"select %@, %@, %@, %@, %@, %@, %@, %@, %@, %@ from %@;",
                         ColumnCode,
                         ColumnFullName,
                         ColumnOpenPrice,
                         ColumnCurPrice,
                         ColumnTotalAmount,
                         ColumnTotalMoney,
                         ColumnCurrentGains,
                         ColumnYesterBlancePrice,
                         ColumnHighPrice,
                         ColumnLowPrice,
                         TNProductDayInfo];
    
    ProductDayinfo *dayinfo;
    FMDatabase *db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        FMResultSet *s = [db executeQuery:selectSQL];
        while([s next]) {
            dayinfo                    = [[ProductDayinfo alloc] init];
            dayinfo.code               = [s stringForColumnIndex:0];
            dayinfo.fullname           = [s stringForColumnIndex:1];
            dayinfo.openPrice          = [NSNumber numberWithDouble:[s doubleForColumnIndex:2]];
            dayinfo.curPrice           = [NSNumber numberWithDouble:[s doubleForColumnIndex:3]];
            dayinfo.totalAmount        = [NSNumber numberWithInt:[s doubleForColumnIndex:4]];
            dayinfo.totalMoney         = [NSNumber numberWithDouble:[s doubleForColumnIndex:5]];
            dayinfo.currentGains       = [NSNumber numberWithDouble:[s doubleForColumnIndex:6]];
            dayinfo.yesterBalancePrice = [NSNumber numberWithDouble:[s doubleForColumnIndex:7]];
            dayinfo.highPrice          = [NSNumber numberWithDouble:[s doubleForColumnIndex:8]];
            dayinfo.lowPrice           = [NSNumber numberWithDouble:[s doubleForColumnIndex:9]];
            
            [array addObject:dayinfo];
            dayinfo = nil;
        }
        [db close];
    }
    
    return [NSArray arrayWithArray: array];
}
@end