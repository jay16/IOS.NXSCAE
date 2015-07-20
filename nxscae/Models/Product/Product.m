//
//  Product.m
//  nxscae
//
//  Created by lijunjie on 15/7/20.
//  Copyright (c) 2015年 solife. All rights reserved.
//

#import "Product.h"
#import "HttpResponse.h"
#import "ApiHelper.h"
#import "DatabaseUtils+Product.h"

@implementation Product

- (void)refresh {
    HttpResponse *httpResponse = [ApiHelper products];
    if(!httpResponse.data[@"tables"]) return;
    
    DatabaseUtils *databaseUtils = [[DatabaseUtils alloc] init];
    NSString *time = httpResponse.data[@"time"];
    NSInteger ID;
    for(NSDictionary *params in httpResponse.data[@"tables"]) {
        ID = [databaseUtils findOrCreateProduct:params Time:time];
        [databaseUtils findOrCreateProductDayinfo:ID Params:params Time:time];
    }
    [databaseUtils insertProductCache:httpResponse.received];
}
@end
