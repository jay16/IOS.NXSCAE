//
//  Product.h
//  nxscae
//
//  Created by lijunjie on 15/7/20.
//  Copyright (c) 2015年 solife. All rights reserved.
//
#import "BaseModel.h"

@interface Product : BaseModel

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *fullname;
@property (nonatomic, strong) NSNumber *highPrice;
@property (nonatomic, strong) NSNumber *lowPrice;
@property (nonatomic, strong) NSString *sumNum;
@property (nonatomic, strong) NSNumber *sumMoney;
@property (nonatomic, strong) NSString *time;

- (void)refresh;
@end
