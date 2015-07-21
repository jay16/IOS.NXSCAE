//
//  DatabaseUtils+ActionLog.h
//  iSearch
//
//  Created by lijunjie on 15/7/9.
//  Copyright (c) 2015年 Intfocus. All rights reserved.
//

#ifndef iSearch_DatabaseUtils_ActionLog_h
#define iSearch_DatabaseUtils_ActionLog_h
#import "DatabaseUtils.h"

@interface DatabaseUtils (Product)

- (void)insertProductCache:(NSData *)data;

- (void)findOrCreateProductDayinfo:(NSInteger)parentID Params:(NSDictionary *)product Time:(NSString *)time;


- (NSInteger)findOrCreateProduct:(NSDictionary *)product Time:(NSString *)time;
- (NSArray *)productDayinfos;
@end

#endif
