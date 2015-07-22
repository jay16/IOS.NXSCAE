//
//  HtmlBuilder.h
//  nxscae
//
//  Created by lijunjie on 15/7/22.
//  Copyright (c) 2015年 solife. All rights reserved.
//

#import "BaseModel.h"

@interface HtmlBuilder : BaseModel
@property (nonatomic, strong) NSMutableString *content;

+ (NSString *)script:(NSString *)fileName;
+ (NSString *)stylesheet:(NSString *)fileName;
+ (NSString *)attrToString:(NSDictionary *)attrDict;
+ (NSString *)tag:(NSString *)tagName Content:(NSString *)content Attribute:(NSString *)attrString;
+ (NSString *)tag:(NSString *)tagName Content:(NSString *)content Attributes:(NSDictionary *)attrDict;
+ (NSString *)tag:(NSString *)tagName Contents:(NSArray *)contents Attributes:(NSDictionary *)attrDict;
+ (NSString *)tag:(NSString *)tagName Content:(NSString *)content;
+ (NSString *)tag:(NSString *)tagName Contents:(NSArray *)contents;


- (void)clear;
- (NSString *)string;
- (void)wrap:(NSString *)tagName;
- (void)script:(NSString *)fileName;
- (void)stylesheet:(NSString *)fileName;
- (void)tag:(NSString *)tagName Content:(NSString *)content Attributes:(NSDictionary *)attrDict;
- (void)tag:(NSString *)tagName Contents:(NSArray *)contents Attributes:(NSDictionary *)attrDict;

- (void)tag:(NSString *)tagName Content:(NSString *)content;
- (void)tag:(NSString *)tagName Contents:(NSArray *)contents;
@end
