//
//  DatInfo.m
//  nxscae
//
//  Created by lijunjie on 15/7/20.
//  Copyright (c) 2015年 solife. All rights reserved.
//

#import "ProductDayInfo.h"
#import "DatabaseUtils+Product.h"

@implementation ProductDayinfo

+ (NSArray *)list {
    DatabaseUtils *databaseUtils = [[DatabaseUtils alloc] init];
    return [databaseUtils productDayinfos];
}
@end
