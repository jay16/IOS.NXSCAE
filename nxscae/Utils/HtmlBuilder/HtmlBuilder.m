//
//  HtmlBuilder.m
//  nxscae
//
//  Created by lijunjie on 15/7/22.
//  Copyright (c) 2015年 solife. All rights reserved.
//

#import "HtmlBuilder.h"

@implementation HtmlBuilder

#pragma mark - base function methods


NSString* attrToString(NSDictionary *attrDict) {
    NSMutableArray *attrArray = [[NSMutableArray alloc] init];
    for(NSString *key in attrDict) {
        [attrArray addObject:[NSString stringWithFormat:@"%@='%@'", key, attrDict[key]]];
    }
    return [attrArray componentsJoinedByString:@" "];
}
NSString* buildTagWithString(NSString *tagName, NSString *content, NSString *attrString) {
    return [NSString stringWithFormat:@"<%@ %@>%@</%@>", tagName, attrString, content, tagName];
}
NSString* buildTagWithDictionary(NSString *tagName, NSString *content, NSDictionary* attrDict) {
    return buildTagWithString(tagName, content, attrToString(attrDict));
}
NSString* buildTagWithMulti(NSString *tagName, NSArray *contents, NSDictionary *attrDict) {
    NSString *attrString = attrToString(attrDict);
    NSMutableString *tmpString = [[NSMutableString alloc] init];
    for(id content in contents) {
        [tmpString appendString:buildTagWithString(tagName, content, attrString)];
    }
    return [NSString stringWithString:tmpString];
}

#pragma mark - HtmlBuilder
- (HtmlBuilder *)init {
    if(self = [super init]) {
        _content = [[NSMutableString alloc] init];
    }
    return self;
}

- (void)clear {
    _content = nil;
    _content = [[NSMutableString alloc] init];
}

+ (NSString *)tag:(NSString *)tagName Content:(NSString *)content Attribute:(NSString *)attrString {
    return buildTagWithString(tagName, content, attrString);
}

+ (NSString *)tag:(NSString *)tagName Content:(NSString *)content Attributes:(NSDictionary *)attrDict {
    return buildTagWithDictionary(tagName, content, attrDict);
}
+ (NSString *)tag:(NSString *)tagName Content:(NSString *)content {
    return buildTagWithDictionary(tagName, content, @{});
}

+ (NSString *)tag:(NSString *)tagName Contents:(NSArray *)contents Attributes:(NSDictionary *)attrDict {
    return buildTagWithMulti(tagName, contents, attrDict);
}
+ (NSString *)tag:(NSString *)tagName Contents:(NSArray *)contents {
    return buildTagWithMulti(tagName, contents, @{});
}

+ (NSString *)script:(NSString *)fileName {
    return [NSString stringWithFormat:@"<script src='%@' type='text/javascript'></script>", fileName];
}

+ (NSString *)stylesheet:(NSString *)fileName {
    return [NSString stringWithFormat:@"<link href='%@' media='screen' rel='stylesheet' type='text/css'>", fileName];
}

- (void)script:(NSString *)fileName {
    [self.content appendString: [HtmlBuilder script:fileName]];
}

- (void)stylesheet:(NSString *)fileName {
    [self.content appendString: [HtmlBuilder stylesheet:fileName]];
}

- (void)tag:(NSString *)tagName Content:(NSString *)content Attributes:(NSDictionary *)attrDict {
    [self.content appendString:buildTagWithDictionary(tagName, content, attrDict)];
}

- (void)tag:(NSString *)tagName Contents:(NSArray *)contents Attributes:(NSDictionary *)attrDict {
    [self.content appendString:buildTagWithMulti(tagName, contents, attrDict)];
}

- (void)tag:(NSString *)tagName Content:(NSString *)content {
    [self.content appendString:buildTagWithDictionary(tagName, content, @{})];
}

- (void)tag:(NSString *)tagName Contents:(NSArray *)contents {
    [self.content appendString:buildTagWithMulti(tagName, contents, @{})];
}
- (void)wrap:(NSString *)tagName Attributes:(NSDictionary *)attrDict {
    _content = [NSMutableString stringWithString:buildTagWithDictionary(tagName, [self.content copy], attrDict)];
}
- (void)wrap:(NSString *)tagName {
    [self wrap:tagName Attributes:@{}];
}

- (NSString *)string {
    return [NSString stringWithString:self.content];
}
@end
