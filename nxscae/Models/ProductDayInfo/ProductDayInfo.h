//
//  DatInfo.h
//  nxscae
//
//  Created by lijunjie on 15/7/20.
//  Copyright (c) 2015年 solife. All rights reserved.
//

#import "BaseModel.h"

@interface ProductDayinfo : BaseModel

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *fullname;
@property (nonatomic, strong) NSNumber *highPrice;
@property (nonatomic, strong) NSNumber *lowPrice;
@property (nonatomic, strong) NSNumber *sumNum;
@property (nonatomic, strong) NSNumber *sumMoney;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSNumber *yesterBalancePrice;
@property (nonatomic, strong) NSNumber *openPrice;
@property (nonatomic, strong) NSNumber *curPrice;
@property (nonatomic, strong) NSNumber *currentGains;
@property (nonatomic, strong) NSNumber *totalAmount;
@property (nonatomic, strong) NSNumber *totalMoney;

+ (NSArray *)list;
@end
